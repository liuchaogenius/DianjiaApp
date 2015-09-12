//
//  WYJHDetailVC.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHDetailVC.h"
#import "WYJHMode.h"
#import "WYJHManager.h"
#import "UIAlertView+Block.h"
#import "WYJHDetailCell.h"

@interface WYJHDetailVC ()
@property (strong, nonatomic) IBOutlet UIView *tvHeadView;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *jinhuodanhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *riqiLabel;
@property (strong, nonatomic) IBOutlet UILabel *gonghuoshangLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongshuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongjineLabel;

@property (strong, nonatomic) IBOutlet UIButton *didanBT;
@property (strong, nonatomic) IBOutlet UIButton *jieqingBT;
@property (strong, nonatomic) IBOutlet UIButton *xiugaiBT;
@property (strong, nonatomic) IBOutlet UIButton *shouhuoBT;
@property (strong, nonatomic) WYJHMode *mode;
@property (strong, nonatomic) WYJHModeList *modeList;
@property (strong, nonatomic) WYJHManager *manager;
@property (strong, nonatomic) NSMutableArray *modeArry;
@end

@implementation WYJHDetailVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        kCreateMutableArry(self.modeArry);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if([self.modeList.strAccountType intValue] == 1)//未计算
    {
        self.jieqingBT.hidden = NO;
    }
    else if([self.modeList.strAccountType intValue] == 2)
    {
        self.jieqingBT.hidden = YES;
    }
    if([self.modeList.strStatus intValue] == 0)//未入库
    {
        self.xiugaiBT.hidden = NO;
        self.shouhuoBT.hidden = NO;
    }
    else if([self.modeList.strStatus intValue] == 1)//已入库
    {
        self.xiugaiBT.hidden = NO;
        self.shouhuoBT.hidden = NO;
    }
    [self.jieqingBT addTarget:self action:@selector(jieqingBT) forControlEvents:UIControlEventTouchUpInside];
    [self.shouhuoBT addTarget:self action:@selector(shouhuoBT) forControlEvents:UIControlEventTouchUpInside];
    [self.xiugaiBT addTarget:self action:@selector(modifyBTItem) forControlEvents:UIControlEventTouchUpInside];
    
    //self.tableview.tableHeaderView = [self getTVHeadView];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

#pragma mark 初始化数据
- (void)setInitData:(WYJHManager *)aManager mode:(WYJHMode *)aMode modeList:(WYJHModeList *)aList
{
    if(aManager)
    {
        self.manager = aManager;
    }
    if(aMode)
    {
        self.mode = aMode;
        [self.modeArry addObject:aMode];
    }
    if(aList)
    {
        self.modeList = aList;
    }
}

#pragma mark 结清
- (void)jieqingBTItem
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithMessage:@"确认结清货物？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertview showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 1)
        {
            [SVProgressHUD show:NO offsetY:0];
            [self.manager appAccountSupplierStorage:self.modeList.strId finishBlock:^(BOOL ret) {
                if(ret)
                {
                    [SVProgressHUD showWithStatus:@"结算完成" cover:NO offsetY:0];
                    [SVProgressHUD dissmissAfter];
                }
                else
                {
                    [SVProgressHUD dismiss];
                }
            }];
        }
    }];
}

#pragma mark 收货
- (void)shouhuoBTItem
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithMessage:@"确认收货？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertview showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 1)
        {
            [SVProgressHUD showWithStatus:@"确认中" cover:NO offsetY:0];
            [self.manager appStorageStockSrl:self.modeList.strId finishBlock:^(BOOL ret) {
                    if(ret)
                    {
                        [SVProgressHUD showWithStatus:@"完成" cover:NO offsetY:0];
                        [SVProgressHUD dissmissAfter];
                    }
                    else
                    {
                        [SVProgressHUD dismiss];
                    }
            }];
        }
    }];
}

#pragma mark 修改
- (void)modifyBTItem
{
    UIView *tempTopView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20, 34)];
    tempTopView.backgroundColor = [UIColor whiteColor];
    UIButton *searchBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tempTopView.width-50, tempTopView.height)];
    [searchBt setTitle:@"请输入商品名称/简拼/条码" forState:UIControlStateNormal];
    [searchBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    searchBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [tempTopView addSubview:searchBt];
    
    UIButton *tiaomaBt = [[UIButton alloc] initWithFrame:CGRectMake(tempTopView.width-50, 0, 50, tempTopView.height)];
    [tiaomaBt setImage:[UIImage imageNamed:@"icon_2_saoma"] forState:UIControlStateNormal];
    [tempTopView addSubview:tiaomaBt];
    
    [self.view addSubview:tempTopView];
    
    self.tableview.editing = YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeArry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108.00f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYJHDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WYJHDETAILCELL"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WYJHDetailCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(WYJHDetailCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeArry.count)
    {
        WYJHMode *mode = [self.modeArry objectAtIndex:indexPath.row];
        [cell setCellData:mode];
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLOG(@"1213");
    if(indexPath.row < self.modeArry.count)
    {
        WYJHMode *mode = [self.modeArry objectAtIndex:indexPath.row];
        [self.manager appDeleteSupplierStorageSrl:mode.strId finishBlock:^(BOOL ret) {
            
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeArry.count)
    {
    }
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
