//
//  FirstViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "FirstViewController.h"
#import "LSNavigationController.h"
#import "DateSelectVC.h"
#import "FirstVCManager.h"
#import "FirstMode.h"
#import "LoginManager.h"
#import "DJStoryboadManager.h"
@interface FirstViewController ()
{
    __weak FirstViewController *weakself;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *headDate_Label;
@property (strong, nonatomic) IBOutlet UIButton *head_rbt;
@property (strong, nonatomic) IBOutlet UILabel *headYYEPrice_Label;
@property (strong, nonatomic) IBOutlet UILabel *headYYEDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *headZLRPrice_Label;
@property (strong, nonatomic) IBOutlet UILabel *headZDSValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *middleZKCValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *middleZCBValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *thirdZRLSValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *thirdSZLSValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *thirdSYLSValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *thirdJRLSValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *thirdBZLSValue_Label;
@property (strong, nonatomic) IBOutlet UILabel *thirdBYLSValue_Label;
@property (strong, nonatomic) IBOutlet UIButton *bottom_kcjg_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_sprk_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_sppd_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_spgl_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_zxdd_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_chcx_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_hygl_BT;
@property (strong, nonatomic) IBOutlet UIButton *bottom_wydh_BT;

@property (strong, nonatomic) DateSelectVC *dateVC;
@property (strong, nonatomic) FirstVCManager *manager;
@property (strong, nonatomic) NSString *strStartTime;
@property (strong, nonatomic) NSString *strEndTime;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    weakself = self;
    self.strStartTime = @"0";
    self.strEndTime = nil;
    [self settitleLabel:@"首页test"];
    self.manager = [[FirstVCManager alloc] init];
    [self showSelectStoreButton];
    CGFloat height = self.bottom_zxdd_BT.bottom;
    
    [self.scrollView setContentSize:CGSizeMake(kMainScreenWidth, height+20)];
    
    [self.head_rbt addTarget:self action:@selector(head_rbtItem:) forControlEvents:UIControlEventTouchUpInside];
    [self requestHomeData];
    [self.bottom_kcjg_BT addTarget:self action:@selector(kcyj_ButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom_hygl_BT addTarget:self action:@selector(hygl_ButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom_sppd_BT addTarget:self action:@selector(sppd_ButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom_sprk_BT addTarget:self action:@selector(rksp_buttonItem) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom_chcx_BT addTarget:self action:@selector(jccx_buttonItem) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    //同步其他地方更改选中店铺
    [super viewWillAppear:animated];
    StoreMode *selectStore = [[LoginManager shareLoginManager] currentSelectStore];
    NSString *title = [self valueForKeyPath:@"titleLabel.text"];
    if (selectStore && ![selectStore.strStoreName isEqualToString: title]) {
        [self settitleLabel:selectStore.strStoreName];
        [self requestHomeData];
    }
}

#pragma mark 获取首页数据
- (void)requestHomeData
{
    [self.manager getHomePageInfoApp:[[LoginManager shareLoginManager] getStoreId] finishBlock:^(FirstMode *mode) {
        if(mode)
        {
            self.thirdZRLSValue_Label.text = mode.homeInfoMode.strPreviousDayTotal;
            self.thirdSZLSValue_Label.text = mode.homeInfoMode.strPreviousWeekTotal;
            self.thirdSYLSValue_Label.text = mode.homeInfoMode.strPreviousMonthTotal;
        }
    }];
    [self.manager getSaleSrlStatisticsApp:self.strStartTime endDate:self.strEndTime finishBlock:^(FirstMode *mode) {
        if(mode)
        {
            self.headYYEPrice_Label.text = mode.ssMode.strRealMoney;
            self.headZLRPrice_Label.text = mode.ssMode.strProFitMoney;
            self.headZDSValue_Label.text = mode.ssMode.strSaleCount;
        }
    }];
    [self.manager getSummaryStoreStock:[[LoginManager shareLoginManager] getStoreId] finishBlock:^(FirstMode *mode) {
        if(mode)
        {
            self.middleZKCValue_Label.text = mode.sumMode.strStockQty;
            self.middleZCBValue_Label.text = mode.sumMode.strStockMoney;
            
            self.thirdJRLSValue_Label.text = mode.sumMode.strJZLS;
            self.thirdBZLSValue_Label.text = mode.sumMode.strBZLS;
            self.thirdBYLSValue_Label.text = mode.sumMode.strBYLS;
        }
    }];
}
#pragma mark Head 部分 日期按钮的事件及页面操作回调
- (void)head_rbtItem:(UIButton *)abt
{
    self.dateVC = (DateSelectVC *)[self pushXIBName:@"DateSelectVC" animated:YES selector:nil param:nil];
    [self obserDateVCValue];
}

- (void)obserDateVCValue
{
    [self.dateVC getUserSetTimer:^(NSString *sTimer, NSString *eTimer,NSString *ssTimer,NSString *seTimer,int tag) {
        if(tag>=0)
        {
            weakself.headDate_Label.text = seTimer;
            sTimer = [NSString stringWithFormat:@"%d",tag];
        }
        else
        {
            weakself.headDate_Label.text = [NSString stringWithFormat:@"%@--%@",ssTimer,seTimer];
        }
        weakself.strStartTime = sTimer;
        weakself.strEndTime = eTimer;
        [self requestHomeData];
    }];
}

#pragma mark 重新baseview中得方法获取点击店铺list的回调
- (void)obserStoreviewResult
{
    [self.sview didSelectStoreMode:^(StoreMode *aMode) {
        MLOG(@"sview====sview");
        if(aMode)
        {
            [weakself settitleLabel:aMode.strStoreName];
            [weakself.sview removeFromSuperview];
            weakself.sview = nil;
            [weakself requestHomeData];
        }
    }];
}

#pragma mark 获取用户选择的开始时间和结束时间
- (NSString *)getStartTime
{
    return self.strStartTime;
}
- (NSString *)getEndTime
{
    return self.strEndTime;
}
#pragma mark 库存预警按钮点击
- (void)kcyj_ButtonItem
{
    [self pushXIBName:@"KCYJViewController" animated:YES selector:nil param:nil];
}

#pragma mark 会员管理
- (void)hygl_ButtonItem
{
    [self pushXIBName:@"HYGLViewController" animated:YES selector:nil param:nil];
}

#pragma mark 商品盘点
- (void)sppd_ButtonItem
{
    UIViewController *vc = [[DJStoryboadManager sharedInstance] viewControllerWithName:@"DJProductCheckListVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 入库审批
- (void)rksp_buttonItem
{
    [self pushXIBName:@"RuKushenpinVC" animated:YES selector:nil param:nil];
}

#pragma mark 寄存查询
- (void)jccx_buttonItem
{
    [self pushXIBName:@"JCCXViewController" animated:YES selector:nil param:nil];
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
