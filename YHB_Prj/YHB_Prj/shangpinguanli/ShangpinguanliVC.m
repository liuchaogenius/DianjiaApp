//
//  ShangpinguanliVC.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ShangpinguanliVC.h"
#import "SPGLManager.h"
#import "SPGLCategoryCell.h"
#import "SPGLSearchVC.h"
#import "SPGLSearchVC.h"
#import "SPNewViewController.h"
#import "WYJHMode.h"
#import "DJProductSearchBar.h"

@interface ShangpinguanliVC ()
{
    int currentIndexPath;
    int oldSectionPath;
    NSMutableArray *currentIndexArry;
     DJScanViewController *svc;
}

@property (weak, nonatomic) IBOutlet DJProductSearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *sectionTableview;
@property (strong, nonatomic) IBOutlet UITableView *indexTableview;
@property (nonatomic, strong) SPGLManager *manager;
@property (nonatomic, strong) SPGLCategoryIndexList *modeList;

@property(nonatomic,strong) void(^selectBlock)(SPGLCategoryMode *);
@property(nonatomic,strong) void(^changeBlock)(WYJHModeList *);
@property(nonatomic,strong) WYJHModeList *WYJHModeList;

@property(nonatomic,strong) UIButton *addBtn;
@end

@implementation ShangpinguanliVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[SPGLManager alloc] init];
        currentIndexArry = [NSMutableArray arrayWithCapacity:0];
        
    }
    return self;
}

- (void)setModeList:(WYJHModeList *)aList andChangeBlock:(void(^)(WYJHModeList *))aBlock
{
    _changeBlock = aBlock;
    _WYJHModeList = aList;
}


- (void)setSelectBlock:(void (^)(SPGLCategoryMode *))aBlock
{
    _selectBlock = aBlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"商品管理"];
    self.sectionTableview.delegate = self;
    self.sectionTableview.dataSource = self;
    self.sectionTableview.tag = 10;
    self.sectionTableview.showsHorizontalScrollIndicator = NO;
    self.sectionTableview.showsVerticalScrollIndicator = NO;
    self.indexTableview.delegate = self;
    self.indexTableview.dataSource = self;
    self.indexTableview.tag = 11;
    
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-65, kMainScreenHeight-64-65, 55, 55)];
    [_addBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(touchAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    __weak typeof(self) weakself = self;
    [self.searchBar setNeedShowSearchVCHandler:^{
        [weakself pushSearchVc];
    } andShowScanVCHandler:^{
        [weakself pushScanView];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.manager getAllProductCls:^(SPGLCategoryIndexList *list) {
        if(list)
        {
            self.modeList = list;
            [self.sectionTableview reloadData];
            [self.indexTableview reloadData];
        }
    }];
    if (self.isNeedJumpToScan) {
        self.isNeedJumpToScan = NO;
        [self pushScanView];
    }
}
#pragma mark 进入新增商品
- (void)touchAdd
{
    SPNewViewController *vc = [[SPNewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 进入搜索页面
- (void)pushSearchVc
{
    [self pushXIBName:@"SPGLSearchVC" animated:YES selector:@"setMnager:" param:self.manager,nil];
}
#pragma mark 进入扫描条形码页面
- (void)pushScanView
{
    svc = [[DJScanViewController alloc] init];
    svc.delegate = self;
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)scanController:(UIViewController *)vc didScanedAndTransToMessage: (NSString *)message
{
    MLOG(@"%@",message);
    SPGLSearchVC *ssvc = [[SPGLSearchVC alloc] initWithNibName:@"SPGLSearchVC" bundle:nil];
    [ssvc setMnagerAndCode:self.manager procode:message];
//    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];
//    if (viewControllers.count > 1) {
//        [viewControllers removeLastObject];
//    }
//    [viewControllers addObject:ssvc];
//    [self.navigationController setViewControllers:viewControllers animated:YES];
    [self.navigationController pushViewController:ssvc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if(tableView.tag == 10)
    {
        count = self.modeList.modeSectionArry.count;
    }
    else
    {
        SPGLCategoryMode *mode = [self.modeList.modeSectionArry objectAtIndex:currentIndexPath];
        [currentIndexArry removeAllObjects];
        for(SPGLCategoryMode *iMode in self.modeList.modeIndexArry)
        {
            if([iMode.strPid intValue] == [mode.strId intValue])
            {
                count++;
                [currentIndexArry addObject:iMode];
            }
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPGLCategoryCell *cell = nil;
    if(tableView.tag == 10)
    {
        [tableView dequeueReusableCellWithIdentifier:@"spglcell"];
        if(!cell)
        {
            cell = [[SPGLCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"spglcell10"];
        }
        [self configureCell_10:cell forRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView dequeueReusableCellWithIdentifier:@"spglcell11"];
        if(!cell)
        {
            cell = [[SPGLCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"spglcell"];
        }
        [self configureCell_11:cell forRowAtIndexPath:indexPath];
    }

    return cell;
}

- (void)configureCell_10:(SPGLCategoryCell *)cell
      forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPGLCategoryMode *mode = [self.modeList.modeSectionArry objectAtIndex:indexPath.row];
    [cell setCategoryName:mode.strCateName tableviewTag:10];
    if(indexPath.row == currentIndexPath)
    {
        cell.label.textColor = RGBCOLOR(250, 180, 73);
        cell.label.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.label.textColor = [UIColor whiteColor];
        cell.label.backgroundColor = RGBCOLOR(60, 60, 60);
    }
    
}

- (void)configureCell_11:(SPGLCategoryCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < currentIndexArry.count)
    {
        SPGLCategoryMode *mode = [currentIndexArry objectAtIndex:indexPath.row];
        [cell setCategoryName:mode.strCateName tableviewTag:11];
        cell.label.text = mode.strCateName;

        cell.label.textColor = RGBCOLOR(75, 75, 75);
        cell.label.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 10)
    {
         currentIndexPath = (int)indexPath.row;
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:0];
        [tableView beginUpdates];
        NSIndexPath *path = [NSIndexPath indexPathForRow:oldSectionPath inSection:0];
        [indexPaths addObject:path];
        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
       
        SPGLCategoryCell *cell = (SPGLCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.label.textColor = RGBCOLOR(250, 180, 73);
        cell.label.backgroundColor = [UIColor whiteColor];
        [self.indexTableview reloadData];
        oldSectionPath = currentIndexPath;
    }
    else
    {
        SPGLCategoryMode *mode = [currentIndexArry objectAtIndex:indexPath.row];
        if (_selectBlock)
        {
            _selectBlock(mode);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(_changeBlock)
        {
            [self pushXIBName:@"SPGLSearchVC" animated:YES selector:@"setMnagerAndid:cateID:modeList:andChangeBlock:" param:self.manager,mode.strId,_WYJHModeList,_changeBlock,nil];
        }
        else [self pushXIBName:@"SPGLSearchVC" animated:YES selector:@"setMnagerAndid:cateID:" param:self.manager,mode.strId,nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.sectionTableview.delegate = nil;
    self.sectionTableview.dataSource = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
