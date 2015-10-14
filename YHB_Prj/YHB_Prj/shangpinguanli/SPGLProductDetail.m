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
#import "AdView.h"
#import "CLTableViewCell.h"
#import "NetManager.h"
#import "LoginMode.h"

static const CGFloat storeTVWidth = 100;

@interface SPGLProductDetail ()<DJProductCheckViewDataSoure,UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isChecked;
    AdView * adView;
    
    UIView *_maskingView;
    UITapGestureRecognizer *_tapGR;
    UITableView *_storeTV;
    NSArray *_storeArr;
    
    NSDictionary *_storeDict;
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
@property (strong, nonatomic) NSMutableDictionary *deqCellDict;
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
    self.deqCellDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [self.scrollerview setContentSize:CGSizeMake(kMainScreenWidth, self.dianmingAndKuncunLabel.bottom+20)];
    [self createADView];

    [self reloadView];
    
    [self.xiugaishangpinBT addTarget:self action:@selector(touchXiugai) forControlEvents:UIControlEventTouchUpInside];
    [self.shangchuantupianBT addTarget:self action:@selector(touchShangchuan) forControlEvents:UIControlEventTouchUpInside];
    [self.ypdmBT addTarget:self action:@selector(touchYPDM) forControlEvents:UIControlEventTouchUpInside];
    [self.jhlsBT addTarget:self action:@selector(touchJHLS) forControlEvents:UIControlEventTouchUpInside];
    [self.pdspBT addTarget:self action:@selector(touchPDSP) forControlEvents:UIControlEventTouchUpInside];
    [self.xslsBT addTarget:self action:@selector(touchXSLS) forControlEvents:UIControlEventTouchUpInside];
    
    [self createMaskingView];
    [self touchMask];
}

- (void)reloadView
{
    self.zhekouLabel.text = [self.productMode.strActEnable isEqualToString:@"1"]?@"是":@"否";
    self.chanpinmaLabel.text = self.productMode.strProductCode;
    self.pinmingLabel.text = self.productMode.strProductName;
    self.jinjiaLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.productMode.strBuyingPrice floatValue]];
    self.kucunLabel.text = [NSString stringWithFormat:@"%.2f", [self.productMode.strStockQty floatValue]];
    self.shoujiaLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.productMode.strSalePrice floatValue]];
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
        NSArray *subArr = adView.adScrollView.subviews;
        UIImageView * imgView = (UIImageView *)[subArr objectAtIndex:i];
        if (imgView.image) {
            [arr addObject:imgView.image];
        }
        else [SVProgressHUD showErrorWithStatus:@"请等待图片显示完毕" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    if (arr.count==self.productMode.picList.count)
    {
        UploadImgViewController *vc = [[UploadImgViewController alloc] initWithUploadImgCount:3 andId:_productMode.strId andChangeBlock:^(NSArray *aPhotoArr) {
            self.productMode.picList = [aPhotoArr mutableCopy];
            [self createADView];
            _changeBlock();
        } andPicDict:_productMode.picList imgArr:arr];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    }
}

- (void)createADView
{
    if(adView)
    {
        [adView removeFromSuperview];
        adView = nil;
    }
    NSMutableArray *imgurlArry = [NSMutableArray arrayWithCapacity:0];
    for(int i=0;i<self.productMode.picList.count;i++)
    {
        SPGLProductPicMode *mode = [self.productMode.picList objectAtIndex:i];
        [imgurlArry addObject:mode.strPic];
    }
    adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, self.headImgScrollview.width, self.headImgScrollview.height)
                              imageLinkURL:imgurlArry
                       placeHoderImageName:@"placeHoder.jpg"
                      pageControlShowStyle:UIPageControlShowStyleLeft];
    adView.isNeedCycleRoll = NO;
    adView.contentMode = UIViewContentModeScaleAspectFit;
    adView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        //NSLog(@"被点中图片的索引:%ld---地址:%@",index,imageURL);
    };
    [self.headImgScrollview addSubview:adView];
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
    [self.view addSubview:_maskingView];
    [self.view addSubview:_storeTV];
    [_storeTV reloadData];
//    _isChecked = NO;
//    [[DJProductCheckViewManager sharedInstance] showCheckViewFromViewController:self withDataSource:self];
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
    id<DJCheckCartItemComponent> item = [[DJCheckCartItemComponent alloc] initWithData:_storeDict];
    
//    [item setSid:[[LoginManager shareLoginManager] getStoreId]];
//    [item setCheckId:[mode strCid]];
//    [item setProductId:[mode strId]];
//    [item setProductCode:[mode strProductCode]];
//    [item setProductName:[mode strProductName]];
//    //    item setStoreStockId:[mode strst]
//    [item setStockQuanity:[[mode strStockQty] integerValue]];
//    [item setStayQuanity:[[mode strStayQty] integerValue]];
//    //    item setCheckQuanity:
//    [item setLastCheckTime:[mode strCheckLasttime]];
//    [item setCheckState:DJCheckItemStateNotCheck];
//    [item setCheckName:[[[LoginManager shareLoginManager] getLoginMode] strUname]];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return _storeArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *clcellId = @"clCell";
        CLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:clcellId];
        if (!cell)
        {
            cell = [[CLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clcellId andWidth:storeTVWidth];
            cell.titleLabel.font = kFont12;
        }
        StoreMode *mode = _storeArr[indexPath.row];
        cell.titleLabel.text = mode.strStoreName;
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StoreMode *mode = _storeArr[indexPath.row];
    [self getProductSid:mode.strId andProductId:self.productMode.strId];
}

- (void)createMaskingView
{
    _maskingView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskingView.backgroundColor = [UIColor blackColor];
    _maskingView.alpha = 0.3;
    _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMask)];
    [_maskingView addGestureRecognizer:_tapGR];
    [self.view addSubview:_maskingView];
    
    LoginManager *loManager = [LoginManager shareLoginManager];
    _storeArr = [loManager getStoreList];
    
    CGFloat cellHeight = 30;
    CGFloat storeTVHeight = cellHeight*_storeArr.count>120?120:cellHeight*_storeArr.count;
    _storeTV = [[UITableView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2.0-storeTVWidth/2.0, _maskingView.height/2.0-storeTVHeight/2.0, storeTVWidth, storeTVHeight)];
    _storeTV.delegate =self;
    _storeTV.dataSource = self;
    _storeTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _storeTV.tableFooterView = [UIView new];
    [self.view addSubview:_storeTV];
}

- (void)touchMask
{
    [_storeTV removeFromSuperview];
    [_maskingView removeFromSuperview];
}

- (void)getProductSid:(NSString *)aSid andProductId:(NSString *)aPid
{
    _maskingView.userInteractionEnabled = NO;
    _storeTV.userInteractionEnabled = NO;
    [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
    [NetManager requestWith:@{@"sid":aSid,@"productId":aPid} apiName:@"getProductBySidForCheck" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *msg = successDict[@"msg"];
        _maskingView.userInteractionEnabled = YES;
        _storeTV.userInteractionEnabled = YES;
        [self touchMask];
        if ([msg isEqualToString:@"success"])
        {
            [SVProgressHUD dismiss];
            _storeDict = successDict[@"result"];
            _isChecked = NO;
            [[DJProductCheckViewManager sharedInstance] showCheckViewFromViewController:self withDataSource:self];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:msg cover:YES offsetY:kMainScreenHeight];
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        _maskingView.userInteractionEnabled = YES;
        _storeTV.userInteractionEnabled = YES;
        [self touchMask];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败" cover:YES offsetY:kMainScreenHeight];
    }];
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
