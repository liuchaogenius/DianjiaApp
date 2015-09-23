//
//  HYDetailViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYDetailViewController.h"
#import "VipInfoMode.h"
#import "UIImageView+WebCache.h"
#import "HYGLManager.h"
#import "HYXFJLListViewController.h"

@interface HYDetailViewController ()
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (strong, nonatomic) IBOutlet UIView *middleview;
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *vipNum;
@property (strong, nonatomic) IBOutlet UILabel *saleMoney;
@property (strong, nonatomic) IBOutlet UILabel *cikaLabel;
@property (strong, nonatomic) IBOutlet UILabel *jifenLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *oneMothSaleRemark;
@property (strong, nonatomic) IBOutlet UIButton *chakanlishiBT;
@property (strong, nonatomic) IBOutlet UIButton *bodadianhuaBT;
@property (strong, nonatomic) IBOutlet UIButton *fasongduanxinBT;
@property (strong, nonatomic) IBOutlet UIButton *jifenduihuanBT;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (nonatomic, strong) VipInfoMode *mode;
@property (nonatomic, strong) HYGLManager *manager;
@end

@implementation HYDetailViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[HYGLManager alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"会员详情"];
    self.headImgView.layer.cornerRadius = self.headImgView.width/2;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.mode.strPortraitUrl] placeholderImage:[UIImage imageNamed:@"hyList_head_defalut"]];
    self.nameLabel.text = self.mode.strVipName;
    self.vipNum.text = self.mode.strVipCode;
    self.saleMoney.text = self.mode.strSaleMoney;
    self.cikaLabel.text = self.mode.strCardNum;
    self.jifenLabel.text = self.mode.strVipScore;
    self.phoneLabel.text = self.mode.strVipPhone;
    self.birthdayLabel.text = self.mode.strVipBirethday;
    self.sexLabel.text = self.mode.strVipSex;
    self.addressLabel.text = self.mode.strVipAddr;
    [self.manager appGetVipDetailByVid:self.mode.strId finishBlock:^(VipInfoMode *fmode) {
        if(fmode)
        {
            self.mode = fmode;
            [self refreshView];
        }
    }];
    [self.bodadianhuaBT addTarget:self action:@selector(systemTelItem) forControlEvents:UIControlEventTouchUpInside];
    [self.fasongduanxinBT addTarget:self action:@selector(sysSmsItem) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 设置数据
- (void)setDetailData:(id)aMode
{
    self.mode = aMode;
}

- (void)refreshView
{
    self.nameLabel.text = self.mode.strVipName;
    self.vipNum.text = self.mode.strVipCode;
    self.saleMoney.text = self.mode.strSaleMoney;
    self.cikaLabel.text = self.mode.strCardNum;
    self.jifenLabel.text = self.mode.strVipScore;
    self.phoneLabel.text = self.mode.strVipPhone;
    self.birthdayLabel.text = self.mode.strVipBirethday;
    self.sexLabel.text = self.mode.strVipSex;
    self.addressLabel.text = self.mode.strVipAddr;
#ifdef DEBUG
    [self.chakanlishiBT addTarget:self action:@selector(pushHistoryOrderVC) forControlEvents:UIControlEventTouchUpInside];
#endif
    if(self.mode.isHasRemark)
    {
        self.oneMothSaleRemark.text = @"有记录";
        [self.chakanlishiBT addTarget:self action:@selector(pushHistoryOrderVC) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        self.chakanlishiBT.hidden = YES;
    }
}

- (void)pushHistoryOrderVC
{
    [self pushXIBName:@"HYXFJLListViewController" animated:YES selector:@"setDetailData:" param:self.mode,nil];
}
#pragma mark 拨打电话功能和发送短信
- (void)systemTelItem
{
    NSString *strTel = [NSString stringWithFormat:@"telprompt://%@",self.mode.strVipPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strTel]];
}
- (void)sysSmsItem
{
    NSString *strTel = [NSString stringWithFormat:@"sms://%@",self.mode.strVipPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strTel]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
