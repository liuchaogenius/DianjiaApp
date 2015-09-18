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
#import "WYJHEditViewController.h"
#import "NetManager.h"

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
//@property (strong, nonatomic) WYJHMode *mode;
@property (strong, nonatomic) WYJHModeList *modeList;
@property (strong, nonatomic) WYJHManager *manager;
//@property (strong, nonatomic) NSMutableArray *modeArry;

@property(assign,nonatomic) BOOL isEdit;

@property(nonatomic,strong) UIView *tempTopView;
@end

@implementation WYJHDetailVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
//        kCreateMutableArry(self.modeArry);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.jinhuodanhaoLabel.text = _modeList.strSrl;
    self.riqiLabel.text = _modeList.strOrderTime;
    self.gonghuoshangLabel.text = _modeList.strSupName;
    self.zongshuliangLabel.text = _modeList.strStockNum;
    self.zongjineLabel.text = [NSString stringWithFormat:@"%.2f", [_modeList.strTotalRealPay floatValue]];

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
    [self.jieqingBT addTarget:self action:@selector(jieqingBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.shouhuoBT addTarget:self action:@selector(shouhuoBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.xiugaiBT addTarget:self action:@selector(modifyBTItem) forControlEvents:UIControlEventTouchUpInside];
    
    //self.tableview.tableHeaderView = [self getTVHeadView];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    _isEdit = NO;
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
//        self.mode = aMode;
//        [self.modeArry addObject:aMode];
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
    if (_isEdit==YES)
    {
        NSMutableDictionary *dict = [self getModelDict];
        [NetManager requestWith:dict apiName:@"appSubmitSupplierStorage" method:@"POST" succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict[@"msg"]);
            if ([successDict[@"msg"] isEqualToString:@"success"])
            {
                [_xiugaiBT setTitle:@"修改" forState:UIControlStateNormal];
                [_tempTopView removeFromSuperview];
                [self.tableview setEditing:NO animated:NO];
            }
            else [SVProgressHUD showErrorWithStatus:@"修改错误" cover:YES offsetY:kMainScreenHeight/2.0];
        }failure:^(NSDictionary *failDict, NSError *error) {
            
        }];
    }
    else
    {
        _tempTopView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20, 34)];
        _tempTopView.backgroundColor = [UIColor whiteColor];
        UIButton *searchBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _tempTopView.width-50, _tempTopView.height)];
        [searchBt setTitle:@"请输入商品名称/简拼/条码" forState:UIControlStateNormal];
        [searchBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        searchBt.titleLabel.font = [UIFont systemFontOfSize:13];
        [_tempTopView addSubview:searchBt];
        
        UIButton *tiaomaBt = [[UIButton alloc] initWithFrame:CGRectMake(_tempTopView.width-50, 0, 50, _tempTopView.height)];
        [tiaomaBt setImage:[UIImage imageNamed:@"icon_2_saoma"] forState:UIControlStateNormal];
        [_tempTopView addSubview:tiaomaBt];
        
        [self.view addSubview:_tempTopView];
        
        [self.tableview setEditing:YES animated:NO];
        [_xiugaiBT setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    _isEdit = !_isEdit;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeList.modeListArry.count;
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
//    if(indexPath.row < self.modeArry.count)
//    {
        WYJHMode *mode = [self.modeList.modeListArry objectAtIndex:indexPath.row];
        [cell setCellData:mode];
        [cell setCellRow:(int)indexPath.row andTouchBlock:^(int aRow) {
            if(indexPath.row < self.modeList.modeListArry.count && _isEdit==YES)
            {
                WYJHMode *mode = [self.modeList.modeListArry objectAtIndex:indexPath.row];
                WYJHEditViewController *vc= [[WYJHEditViewController alloc] initWithMode:mode modeList:_modeList andChangeBlock:^{
                    [self.tableview reloadData];
                    MLOG(@"%@, %@", mode, _modeList);
                    self.zongshuliangLabel.text = _modeList.strStockNum;
                    self.zongjineLabel.text = [NSString stringWithFormat:@"%.2f", [_modeList.strTotalRealPay floatValue]];
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
//    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLOG(@"1213");
    if(indexPath.row < self.modeList.modeListArry.count)
    {
        WYJHMode *mode = [self.modeList.modeListArry objectAtIndex:indexPath.row];
        [self.manager appDeleteSupplierStorageSrl:mode.strId finishBlock:^(BOOL ret) {
            
        }];
    }
}

- (NSMutableDictionary *)getModelDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@0 forKey:@"empStockSrlId"];
    
    NSMutableDictionary *srlDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [srlDict setValue:_modeList.strSid forKey:@"sid"];
    [srlDict setValue:_modeList.strId forKey:@"id"];
    [srlDict setValue:_modeList.strSrl forKey:@"srl"];
    [srlDict setValue:[_modeList.strStockName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"store_name"];
    [srlDict setValue:_modeList.strSupid forKey:@"sup_id"];
    [srlDict setValue:[_modeList.strSupName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"sup_name"];
    [srlDict setValue:_modeList.strTotalRealPay forKey:@"total_real_pay"];
    [srlDict setValue:_modeList.strOrderTime forKey:@"order_time"];
    [srlDict setValue:[_modeList.strOrderFromName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"order_from_name"];
    [srlDict setValue:_modeList.strStatus forKey:@"status"];
    [srlDict setValue:[_modeList.strStatusStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"statusStr"];
    [srlDict setValue:_modeList.strAccountType forKey:@"account_type"];
    [srlDict setValue:_modeList.strStockNum forKey:@"stock_num"];

    NSMutableArray *detailArray = [NSMutableArray arrayWithCapacity:0];
    for (WYJHMode *mode in _modeList.modeListArry)
    {
        NSDictionary *aDict = [self getDictfromMode:mode];
        [detailArray addObject:aDict];
    }
    [srlDict setValue:detailArray forKey:@"detailList"];
    
    [dict setValue:@[srlDict] forKey:@"srlList"];
    
    return dict;
}

- (NSMutableDictionary *)getDictfromMode:(WYJHMode *)aMode
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [dict setValue:aMode.strId forKey:@"id"];
    [dict setValue:aMode.strProductId forKey:@"product_id"];
    [dict setValue:aMode.strStockPrice forKey:@"stock_price"];
    [dict setValue:aMode.strSalePrice forKey:@"sale_price"];
    [dict setValue:aMode.strStockNum forKey:@"stock_num"];
    [dict setValue:[aMode.strProductName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"product_name"];
    [dict setValue:aMode.strMakeDate forKey:@"make_date"];
    [dict setValue:aMode.strShelfDys forKey:@"shelf_dys"];
    [dict setValue:[aMode.strStoreName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"store_name"];
    [dict setValue:aMode.strAddDate forKey:@"add_date"];
    [dict setValue:[aMode.strSupName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"sup_name"];
    [dict setValue:aMode.strStockNum forKey:@"storage_num"];
    [dict setValue:aMode.strStayQty forKey:@"stay_qty"];


    return dict;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
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
