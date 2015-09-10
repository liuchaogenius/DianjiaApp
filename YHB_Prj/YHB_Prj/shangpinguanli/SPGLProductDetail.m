//
//  SPGLProductDetail.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLProductDetail.h"
#import "SPGLManager.h"
#import "SPGLProductMode.h"
#import "UIImageView+WebCache.h"
@interface SPGLProductDetail ()
{
    SBPageFlowView *flowView;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (strong, nonatomic) IBOutlet UIView *headImgScrollview;
@property (strong, nonatomic) IBOutlet UILabel *chanpinmaLabel;
@property (strong, nonatomic) IBOutlet UILabel *pinmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *kucunLabel;
@property (strong, nonatomic) IBOutlet UILabel *shoujiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekouLabel;
@property (strong, nonatomic) IBOutlet UIButton *xiugaishangpinBT;
@property (strong, nonatomic) IBOutlet UIButton *shangchuantupianBT;
@property (strong, nonatomic) IBOutlet UIButton *ypdmBT;
@property (strong, nonatomic) IBOutlet UIButton *jhlsBT;
@property (strong, nonatomic) IBOutlet UIButton *pdspBT;
@property (strong, nonatomic) IBOutlet UIButton *xslsBT;
@property (strong, nonatomic) IBOutlet UILabel *dianmingAndKuncunLabel;
@property (strong, nonatomic) SPGLProductMode *productMode;
@property (strong, nonatomic) SPGLManager *manager;
@end

@implementation SPGLProductDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
//        self.manager = [[SPGLManager alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"商品详情"];
    [self.scrollerview setContentSize:CGSizeMake(kMainScreenWidth, self.dianmingAndKuncunLabel.bottom+20)];
    flowView = [[SBPageFlowView alloc] initWithFrame:CGRectMake(0, 0, self.headImgScrollview.width, self.headImgScrollview.height)];
    [self.headImgScrollview addSubview:flowView];
    self.chanpinmaLabel.text = self.productMode.strProductCode;
    self.pinmingLabel.text = self.productMode.strProductName;
    self.jinjiaLabel.text = self.productMode.strBuyingPrice;
    self.kucunLabel.text = self.productMode.strStayQty;
    self.shoujiaLabel.text = self.productMode.strSalePrice;
    self.dianmingAndKuncunLabel.text = [NSString stringWithFormat:@"    %@：库存 %@",self.productMode.strClsName,self.productMode.strStockQty];
}

#pragma mark 设置初始化数据
- (void)setInitData:(SPGLManager *)aManager mode:(SPGLProductMode *)aMode
{
    self.manager = aManager;
    self.productMode = aMode;
}
#pragma mark SBPage datasource
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index
{
}

- (NSInteger)numberOfPagesInFlowView:(SBPageFlowView *)flowView
{
    return self.productMode.picList.count;
}
- (CGSize)sizeForPageInFlowView:(SBPageFlowView *)flowView
{
    return CGSizeMake(self.headImgScrollview.width/3, self.headImgScrollview.height);
}

// Reusable cells
- (UIView *)flowView:(SBPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    UIImageView *imgview = nil;
    if(index < self.productMode.picList.count)
    {
        SPGLProductPicMode *pMode = [self.productMode.picList objectAtIndex:index];
        imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.headImgScrollview.width/3, self.headImgScrollview.height)];
        [imgview sd_setImageWithURL:[NSURL URLWithString:pMode.strPic] placeholderImage:nil];
    }
    return imgview;
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
