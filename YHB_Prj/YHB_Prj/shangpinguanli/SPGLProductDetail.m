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
#import "YPDMViewController.h"
#import "SPNewViewController.h"
#import "DJProductCheckViewManager.h"
#import "DJCheckCartItemComponent.h"

@interface SPGLProductDetail ()<DJProductCheckViewDataSoure,SBPageFlowViewDataSource,SBPageFlowViewDelegate>
{
    SBPageFlowView *flowView;
    BOOL _isChecked;
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

@property (strong, nonatomic) void(^changeBlock)(void);
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
    flowView.dataSource = self;
    flowView.delegate =self;
    [flowView reloadData];
    [self reloadView];
    
    [self.xiugaishangpinBT addTarget:self action:@selector(touchXiugai) forControlEvents:UIControlEventTouchUpInside];
    [self.shangchuantupianBT addTarget:self action:@selector(touchShangchuan) forControlEvents:UIControlEventTouchUpInside];
    [self.ypdmBT addTarget:self action:@selector(touchYPDM) forControlEvents:UIControlEventTouchUpInside];
    [self.jhlsBT addTarget:self action:@selector(touchJHLS) forControlEvents:UIControlEventTouchUpInside];
    [self.pdspBT addTarget:self action:@selector(touchPDSP) forControlEvents:UIControlEventTouchUpInside];
    [self.xslsBT addTarget:self action:@selector(touchXSLS) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadView
{
    self.zhekouLabel.text = [self.productMode.strActEnable isEqualToString:@"1"]?@"是":@"否";
    self.chanpinmaLabel.text = self.productMode.strProductCode;
    self.pinmingLabel.text = self.productMode.strProductName;
    self.jinjiaLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.productMode.strBuyingPrice floatValue]];
    self.kucunLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.productMode.strStockQty floatValue]];
    self.shoujiaLabel.text = self.productMode.strSalePrice;
    self.dianmingAndKuncunLabel.text = [NSString stringWithFormat:@"    %@：库存 %@",self.productMode.strClsName,self.productMode.strStockQty];
}

- (void)touchXiugai
{
    SPEditViewController *vc = [[SPEditViewController alloc] initWithMode:_productMode changeBlock:^{
        [self reloadView];
        _changeBlock();
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchShangchuan
{
//    int count = 3-(int)_productMode.picList.count;
//    if (count==0)
//    {
//        [SVProgressHUD showErrorWithStatus:@"商品图片已满3张" cover:YES offsetY:kMainScreenHeight/2.0];
//    }
//    else
//    {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<self.productMode.picList.count; i++)
    {
        UIImageView * imgView = (UIImageView *)[flowView cellForItemAtCurrentIndex:i];
        if (imgView.image) {
            [arr addObject:imgView.image];
        }
        else [SVProgressHUD showErrorWithStatus:@"请等待图片显示完毕" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    if (arr.count==self.productMode.picList.count)
    {
        UploadImgViewController *vc = [[UploadImgViewController alloc] initWithUploadImgCount:3 andId:_productMode.strId andChangeBlock:^(NSArray *aPhotoArr) {
            self.productMode.picList = [aPhotoArr mutableCopy];
            [flowView reloadData];
            _changeBlock();
        } andPicDict:_productMode.picList imgArr:arr];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    }
}

- (void)touchYPDM
{
    YPDMViewController *vc = [[YPDMViewController alloc] initWithProductMode:_productMode changeBlock:^(SPGLProductMode *aMode) {
        self.chanpinmaLabel.text = self.productMode.strProductCode;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchPDSP
{
    _isChecked = NO;
    [[DJProductCheckViewManager sharedInstance] showCheckViewFromViewController:self withDataSource:self];
}

#pragma mark - check Delegate
- (id<DJCheckCartItemComponent>)nextItem {
    if (!_isChecked) {
        return [self itemWithProductListModel:self.productMode];
    }else {
        return nil;
    }
}

#pragma mark - adapter

- (id<DJCheckCartItemComponent>)itemWithProductListModel: (SPGLProductMode *)mode {
    id<DJCheckCartItemComponent> item = [[DJCheckCartItemComponent alloc] init];
    
    [item setSid:[[LoginManager shareLoginManager] getStoreId]];
    [item setCheckId:[mode strCid]];
    [item setProductId:[mode strId]];
    [item setProductCode:[mode strProductCode]];
    [item setProductName:[mode strProductName]];
    //    item setStoreStockId:[mode strst]
    [item setStockQuanity:[[mode strStockQty] integerValue]];
    [item setStayQuanity:[[mode strStayQty] integerValue]];
    //    item setCheckQuanity:
    [item setLastCheckTime:[mode strCheckLasttime]];
    [item setCheckState:DJCheckItemStateNotCheck];
    [item setCheckName:[[[LoginManager shareLoginManager] getLoginMode] strUname]];
    
    return item;
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
- (void)setInitData:(SPGLManager *)aManager mode:(SPGLProductMode *)aMode changeBlock:(void(^)(void))aChangeBlock
{
    self.manager = aManager;
    self.productMode = aMode;
    _changeBlock = aChangeBlock;
}
#pragma mark SBPage datasource
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index
{
//    [cell removeSubviews];
//    SPGLProductPicMode *mode = self.productMode.picList[index];
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:mode.strPicUrl]];
//    [cell addSubview:imgView];
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
        imgview = [[UIImageView alloc] initWithFrame:CGRectMake(index*(self.headImgScrollview.width/3), 0, self.headImgScrollview.width/3, self.headImgScrollview.height)];
        if (pMode.image)
            imgview.image = pMode.image;
        else
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
