//
//  KCYJViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "KCYJViewController.h"
#import "LoginManager.h"
#import "KCYJMode.h"
#import "KCYJManager.h"
#import "KCYJMode.h"
#import "KCYJCell.h"
#import "ZXBJCell.h"
#import "ZCBCell.h"

@interface KCYJViewController ()
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIButton *head_kuyjBT;
@property (strong, nonatomic) IBOutlet UIButton *head_zxbjBT;
@property (strong, nonatomic) IBOutlet UIButton *head_zkcBT;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong) UILabel *bottomDesc;

@property(nonatomic, strong)KCYJManager *manager;
@property(nonatomic, strong) NSMutableArray *kcyjMutArry;
@property(nonatomic, strong) NSMutableArray *zxyjMutArry;
@property(nonatomic, strong) NSMutableArray *zkcMutArry;
@property(nonatomic, assign) int pageType; //0 是库存预警 1 库存滞销 2总库存
@end

@implementation KCYJViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[KCYJManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.kcyjMutArry = [NSMutableArray arrayWithCapacity:0];
    self.zxyjMutArry = [NSMutableArray arrayWithCapacity:0];
    self.zkcMutArry = [NSMutableArray arrayWithCapacity:0];
    [self.head_kuyjBT addTarget:self action:@selector(kcyjBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.head_zxbjBT addTarget:self action:@selector(zxyjBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.head_zkcBT addTarget:self action:@selector(zkcBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self createTableview];
    [self.manager getStockWarningDetailPageApp:YES storeId:[[LoginManager shareLoginManager] getStoreId] finishBlock:^(KCYJListMode *modelist) {
        if(modelist && modelist.kcyjModeArry && modelist.kcyjModeArry.count>0)
        {
            [self.kcyjMutArry addObjectsFromArray:modelist.kcyjModeArry] ;
            [self.tableview reloadData];
        }
    }];
}

- (void)createTableview
{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, kMainScreenWidth, self.view.height-self.headView.height)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];//[UIColor colorWithHexValue:kMSColorBC5];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    //self.tableview.tableHeaderView = [self createTableviewHeadview];
    [self.view addSubview:self.tableview];
}
#pragma mark 顶部三个按钮事件函数
- (void)kcyjBTItem
{
    self.pageType = 0;
    if(self.kcyjMutArry.count == 0)
    {
        [self.manager getStockWarningDetailPageApp:YES storeId:[[LoginManager shareLoginManager] getStoreId] finishBlock:^(KCYJListMode *modelist) {
            if(modelist && modelist.kcyjModeArry && modelist.kcyjModeArry.count>0)
            {
                [self.tableview setContentOffset:CGPointMake(0, 0)];
                [self.kcyjMutArry addObjectsFromArray:modelist.kcyjModeArry];
                [self.tableview reloadData];
            }
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)zxyjBTItem
{
    self.pageType = 1;
    if(self.zxyjMutArry.count == 0)
    {
        [self.manager getSalekWarningDetailPageApp:YES storeId:[[LoginManager shareLoginManager] getStoreId] finishBlock:^(KCYJListMode *modelist) {
            if(modelist && modelist.kcyjModeArry && modelist.kcyjModeArry.count>0)
            {
                [self.tableview setContentOffset:CGPointMake(0, 0)];
                [self.zxyjMutArry addObjectsFromArray:modelist.kcyjModeArry];
                [self.tableview reloadData];
            }
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)zkcBTItem
{
    self.pageType = 2;
    if(self.zkcMutArry.count == 0)
    {
        [self.manager getStoreStockByStoreCount:^(StoreTockList *modelist) {
            if(modelist && modelist.storeStockArry && modelist.storeStockArry.count>0)
            {
                [self.zkcMutArry addObjectsFromArray:modelist.storeStockArry];
                [self.tableview reloadData];
            }
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
#pragma mark 显示和隐藏底部滞销商品的
- (void)showBottomBar:(NSString *)aPNum stockMoney:(NSString *)aStockMoney
{
    if(self.bottomDesc == nil)
    {
        self.bottomDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bottom-44, kMainScreenWidth, 44)];
        self.bottomDesc.backgroundColor = [UIColor whiteColor];
        self.bottomDesc.font = kFont16;
        self.bottomDesc.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.bottomDesc];
    }
    self.bottomDesc.text = [NSString stringWithFormat:@"总计共有%@种商品滞销，总成本%@元",aPNum,aStockMoney];
}

#pragma mark tableview delegate datesource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if(self.pageType == 0)
    {
        height = 144;
    }
    else if(self.pageType == 1)
    {
        height = 195;
    }
    else
    {
        height = 107;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if(self.pageType == 0)
    {
        count = self.kcyjMutArry.count;
    }
    else if(self.pageType == 1)
    {
        count = self.zxyjMutArry.count;
    }
    else
    {
        count = self.zkcMutArry.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.pageType == 0)
    {
        KCYJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kcyuviewtableviewcell"];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KCYJCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        if(indexPath.row< self.kcyjMutArry.count){
            KCYJMode *mode = [self.kcyjMutArry objectAtIndex:indexPath.row];
            [cell setCellValue:mode];
        }
        return cell;
    }
    else if(self.pageType == 1)
    {
        ZXBJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZXBJiewtableviewcell"];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ZXBJCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        if(indexPath.row< self.zxyjMutArry.count){
            KCYJMode *mode = [self.zxyjMutArry objectAtIndex:indexPath.row];
            [cell setCellValue:mode];
        }
        
        return cell;
    }
    else
    {
        ZCBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZCBCellJiewtableviewcell"];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ZCBCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        if(indexPath.row< self.kcyjMutArry.count){
            StoreTockMode *mode = [self.zkcMutArry objectAtIndex:indexPath.row];
            [cell setCellData:mode];
        }
        
        return cell;

    }
    

    return nil;
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
