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
#import "SPEditViewController.h"
#import "JHLSViewController.h"
#import "UploadImgViewController.h"
#import "XSLSViewController.h"

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
    
    [self.xiugaishangpinBT addTarget:self action:@selector(touchXiugai) forControlEvents:UIControlEventTouchUpInside];
    [self.shangchuantupianBT addTarget:self action:@selector(touchShangchuan) forControlEvents:UIControlEventTouchUpInside];
    [self.ypdmBT addTarget:self action:@selector(touchYPDM) forControlEvents:UIControlEventTouchUpInside];
    [self.jhlsBT addTarget:self action:@selector(touchJHLS) forControlEvents:UIControlEventTouchUpInside];
    [self.pdspBT addTarget:self action:@selector(touchPDSP) forControlEvents:UIControlEventTouchUpInside];
    [self.xslsBT addTarget:self action:@selector(touchXSLS) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchXiugai
{
    SPEditViewController *vc = [[SPEditViewController alloc] initWithMode:_productMode];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchShangchuan
{
    int count = 3-(int)_productMode.picList.count;
    if (count==0)
    {
        [SVProgressHUD showErrorWithStatus:@"商品图片已满3张" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    else
    {
        UploadImgViewController *vc = [[UploadImgViewController alloc] initWithUploadImgCount:count];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)touchYPDM
{
    
}

- (void)touchPDSP
{
    
}

- (void)touchJHLS
{
    JHLSViewController *vc = [[JHLSViewController alloc] initWithProductId:_productMode.strId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchXSLS
{
    XSLSViewController *vc = [[XSLSViewController alloc] initWithProductId:_productMode.strId];
    [self.navigationController pushViewController:vc animated:YES];
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
