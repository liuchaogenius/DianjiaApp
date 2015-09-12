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

@interface WYJHDetailVC ()
@property (strong, nonatomic) IBOutlet UILabel *jinhuodanhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *riqiLabel;
@property (strong, nonatomic) IBOutlet UILabel *gonghuoshangLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongshuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongjineLabel;
@property (strong, nonatomic) IBOutlet UILabel *pinmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *dinghuoshuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *kucunLabel;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *didanLabel;
@property (strong, nonatomic) IBOutlet UIButton *jieqingBT;
@property (strong, nonatomic) IBOutlet UIButton *xiugaiBT;
@property (strong, nonatomic) IBOutlet UIButton *shouhuoBT;
@property (strong, nonatomic) WYJHMode *mode;
@property (strong, nonatomic) WYJHModeList *modeList;
@property (strong, nonatomic) WYJHManager *manager;
@end

@implementation WYJHDetailVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.jinhuodanhaoLabel.text = self.modeList.strSrl;
    self.riqiLabel.text = self.modeList.strOrderTime;
    self.gonghuoshangLabel.text = self.modeList.strSupName;
    self.zongshuliangLabel.text = self.modeList.strStockNum;
    self.zongjineLabel.text = self.modeList.strTotalRealPay;
    
    self.pinmingLabel.text = self.mode.strProductName;
    self.dinghuoshuliangLabel.text = self.mode.strStayQty;
    self.jinjiaLabel.text = self.mode.strStockPrice;
    self.kucunLabel.text = self.mode.strStayQty;
    self.xiaojiLabel.text = self.mode.strShelfDys;
    if([self.modeList.strAccountType intValue] == 1)//未计算
    {
        
    }
    else if([self.modeList.strAccountType intValue] == 2)
    {
        self.xiugaiBT.hidden = YES;
        self.shouhuoBT.hidden = YES;
    }
}

#pragma mark 初始化数据
- (void)setInitData:(WYJHManager *)aManager mode:(WYJHMode *)aMode modeList:(WYJHModeList *)aList
{
    self.manager = aManager;
    self.mode = aMode;
    self.modeList = aList;
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
