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

@interface ShangpinguanliVC ()
{
    int currentSectionIndex;
    int currentIndexPath;
    int oldSectionPath;
    NSMutableArray *currentIndexArry;
}
@property (strong, nonatomic) IBOutlet UIButton *searchBt;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UITableView *sectionTableview;
@property (strong, nonatomic) IBOutlet UITableView *indexTableview;
@property (nonatomic, strong) SPGLManager *manager;
@property (nonatomic, strong) SPGLCategoryIndexList *modeList;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sectionTableview.delegate = self;
    self.sectionTableview.dataSource = self;
    self.sectionTableview.tag = 10;
    self.sectionTableview.showsHorizontalScrollIndicator = NO;
    self.sectionTableview.showsVerticalScrollIndicator = NO;
    self.indexTableview.delegate = self;
    self.indexTableview.dataSource = self;
    self.indexTableview.tag = 11;
    
    [self.scanButton addTarget:self action:@selector(pushScanView) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBt addTarget:self action:@selector(pushSearchVc) forControlEvents:UIControlEventTouchUpInside];
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
}

#pragma mark 进入搜索页面
- (void)pushSearchVc
{
    [self pushXIBName:@"SPGLSearchVC" animated:YES selector:@"setMnager:" param:self.manager,nil];
}
#pragma mark 进入扫描条形码页面
- (void)pushScanView
{
    DJScanViewController *svc = [[DJScanViewController alloc] init];
    svc.delegate = self;
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)scanController:(UIViewController *)vc didScanedAndTransToMessage: (NSString *)message
{
    MLOG(@"%@",message);
}

- (void)needToInputNumberFromScanController:(UIViewController *)vc
{
    
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
        SPGLCategoryMode *mode = [self.modeList.modeSectionArry objectAtIndex:currentSectionIndex];
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
        [self pushXIBName:@"SPGLSearchVC" animated:YES selector:@"setMnagerAndid:cateID:" param:self.manager,mode.strId,nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
