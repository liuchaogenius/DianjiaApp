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
#import "SDWebImageManager.h"

@interface WYJHDetailVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    CGRect oldframe;
}
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
@property (strong, nonatomic) IBOutlet UIButton *shouhuojieqing;

@property (strong, nonatomic) UIImage *didanImage;

@property(assign,nonatomic) BOOL isEdit;

@property(nonatomic,strong) UIView *tempTopView;

@property(nonatomic,strong) void(^changeBlock)(void);
@end

@implementation WYJHDetailVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

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
    [self settitleLabel:@"订货详情"];
    self.jinhuodanhaoLabel.text = _modeList.strSrl;
    self.riqiLabel.text = _modeList.strOrderTime;
    self.gonghuoshangLabel.text = _modeList.strSupName;
    self.zongshuliangLabel.text = _modeList.strStockNum;
    self.zongjineLabel.text = [NSString stringWithFormat:@"￥%.2f", [_modeList.strTotalRealPay floatValue]];

    [self changejieqingBT];
    
//    if([self.modeList.strStatus intValue] == 0)//未入库
//    {
//        self.xiugaiBT.hidden = NO;
//        self.shouhuoBT.hidden = NO;
//    }
//    else
    self.shouhuojieqing.hidden = YES;
    if([self.modeList.strStatus intValue] !=0)//已入库
    {
        self.xiugaiBT.hidden = YES;
        self.shouhuoBT.hidden = YES;
        self.jieqingBT.hidden = YES;
        self.shouhuojieqing.hidden = NO;
    }
    
    if (self.modeList.strCounterfoilDomain.length>0 && self.modeList.strCounterfoilUrl.length>0)
    {
        [self.didanBT setTitle:@"查看底单" forState:UIControlStateNormal];
    }
    
    [self.jieqingBT addTarget:self action:@selector(jieqingBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.shouhuoBT addTarget:self action:@selector(shouhuoBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.xiugaiBT addTarget:self action:@selector(modifyBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.didanBT addTarget:self action:@selector(didanBTItem) forControlEvents:UIControlEventTouchUpInside];
    
    [self.shouhuojieqing setTitle:@"结清" forState:UIControlStateNormal];
    if([self.modeList.strAccountType intValue] == 2)
    {
        [self.shouhuojieqing setTitle:@"已结" forState:UIControlStateNormal];
    }
    [self.shouhuojieqing addTarget:self action:@selector(jieqingBTItem) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.modeList.strCounterfoilDomain.length>0 && self.modeList.strCounterfoilUrl.length>0)
    {
        //            [SVProgressHUD showWithStatus:@"正在加载图片" cover:YES offsetY:kMainScreenHeight/2.0];
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.modeList.strCounterfoilDomain, self.modeList.strCounterfoilUrl]];
        [[SDWebImageManager sharedManager] downloadImageWithURL:imgUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            self.didanImage = image;
            //                [SVProgressHUD dismiss];
        }];
    }
    
    //self.tableview.tableHeaderView = [self getTVHeadView];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    _isEdit = NO;
}

- (void)changejieqingBT
{
    if (_isEdit==NO)
    {
        self.jieqingBT.hidden = NO;
        [self.jieqingBT setTitle:@"结清" forState:UIControlStateNormal];
        if([self.modeList.strAccountType intValue] == 2)
        {
            [self.jieqingBT setTitle:@"已结" forState:UIControlStateNormal];
        }
    }
    else
    {
        self.jieqingBT.hidden = NO;
        if (self.modeList.strCounterfoilDomain.length>0 && self.modeList.strCounterfoilUrl.length>0)
        {
            self.jieqingBT.hidden = YES;
        }
        else [self.jieqingBT setTitle:@"上传底单" forState:UIControlStateNormal];
    }
}

#pragma mark 初始化数据
- (void)setInitData:(WYJHManager *)aManager mode:(WYJHMode *)aMode modeList:(WYJHModeList *)aList changeBlock:(void(^)(void))aChangeBlock
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
    if (aChangeBlock)
    {
        _changeBlock = aChangeBlock;
    }
}

#pragma mark 结清
- (void)jieqingBTItem
{
    if (_isEdit==NO)
    {
        if ([self.modeList.strAccountType intValue] != 2)
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
                            self.modeList.strAccountType = @"2";
                            [self.jieqingBT setTitle:@"已结" forState:UIControlStateNormal];
                            [self.shouhuojieqing setTitle:@"已结" forState:UIControlStateNormal];
                            [SVProgressHUD dissmissAfter];
                        }
                        else
                        {
                            [SVProgressHUD dismiss];
                        }
                    }];
                }
            }];
        } else [SVProgressHUD showErrorWithStatus:@"已结算完成" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    else
    {
        [self plusImageClicked];
    }
}

#pragma mark 底单
- (void)didanBTItem
{
    if (_isEdit==NO)
    {
        if (self.didanImage)
        {
            [self showImage:self.didanImage];
        }
    }
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
                        self.modeList.strStatusStr = @"1";
                        _changeBlock();
                        [self.navigationController popViewControllerAnimated:YES];
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
        self.shouhuoBT.hidden=NO;
        NSMutableDictionary *dict = [self getModelDict];
        
        [NetManager requestWith:dict apiName:@"appSubmitSupplierStorage" method:@"POST" succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict[@"msg"]);
            if ([successDict[@"msg"] isEqualToString:@"success"])
            {
                [SVProgressHUD showSuccessWithStatus:@"修改成功" cover:YES offsetY:kMainScreenHeight/2.0];
                [_xiugaiBT setTitle:@"修改" forState:UIControlStateNormal];
                [_tempTopView removeFromSuperview];
                [self.tableview setEditing:NO animated:NO];
                
                _isEdit = !_isEdit;
                [self changejieqingBT];
            }
            else [SVProgressHUD showErrorWithStatus:@"修改错误" cover:YES offsetY:kMainScreenHeight/2.0];
        }failure:^(NSDictionary *failDict, NSError *error) {
            
        }];
    }
    else
    {
        self.shouhuoBT.hidden=YES;
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
        
        [searchBt addTarget:self action:@selector(touchSearch) forControlEvents:UIControlEventTouchUpInside];
        [tiaomaBt addTarget:self action:@selector(touchSearch) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_tempTopView];
        
        [self.tableview setEditing:YES animated:NO];
        [_xiugaiBT setTitle:@"完成" forState:UIControlStateNormal];
        
        _isEdit = !_isEdit;
        [self changejieqingBT];
    }
}

- (void)touchSearch
{
    void(^changeBlock)(WYJHModeList *) = ^(WYJHModeList *modelList){
        _modeList = modelList;
        [self.tableview reloadData];
        self.zongshuliangLabel.text = _modeList.strStockNum;
        self.zongjineLabel.text = [NSString stringWithFormat:@"%.2f", [_modeList.strTotalRealPay floatValue]];
    };
    [self pushXIBName:@"ShangpinguanliVC" animated:YES selector:@"setModeList:andChangeBlock:" param:_modeList,changeBlock,nil];
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
                } canNull:NO];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
//    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MLOG(@"1213");
//    if(indexPath.row < self.modeList.modeListArry.count)
//    {
//        WYJHMode *mode = [self.modeList.modeListArry objectAtIndex:indexPath.row];
//        [self.manager appDeleteSupplierStorageSrl:mode.strId finishBlock:^(BOOL ret) {
//            
//        }];
//    }
    WYJHMode *mode = [self.modeList.modeListArry objectAtIndex:indexPath.row];
    _modeList.strStockNum = [NSString stringWithFormat:@"%d", (int)([_modeList.strStockNum floatValue]-[mode.strStockNum floatValue])];
    
    _modeList.strTotalRealPay = [NSString stringWithFormat:@"%f", [_modeList.strTotalRealPay floatValue]- [mode.strStockNum floatValue]*[mode.strStockPrice floatValue]];
    [self.modeList.modeListArry removeObjectAtIndex:indexPath.row];
    [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableview reloadData];
    MLOG(@"%@, %@", mode, _modeList);
    self.zongshuliangLabel.text = _modeList.strStockNum;
    self.zongjineLabel.text = [NSString stringWithFormat:@"%.2f", [_modeList.strTotalRealPay floatValue]];

    _changeBlock();
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
    
    if (self.modeList.strCounterfoilDomain.length>0 && self.modeList.strCounterfoilUrl.length>0)
    {
        [srlDict setObject:_modeList.strCounterfoilUrl forKey:@"counterfoil_url"];
        [srlDict setObject:_modeList.strCounterfoilDomain forKey:@"counterfoil_domain"];
    }

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

#pragma mark 调用相机
- (void)plusImageClicked
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        
        if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) { // 从相册选择
            //            if ([UIImagePickerController isPhotoLibraryAvailable]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            picker.allowsEditing=YES;
            if (kSystemVersion>7) {
                picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self presentViewController:picker animated:YES completion:nil];
            //            }
        } else if (buttonIndex == UIImagePickerControllerSourceTypeCamera) { // 拍照
            //            if ([UIImagePickerController canTakePhoto]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            NSString *requiredMediaType = (__bridge NSString *)kUTTypeMovie;
            //            picker.mediaTypes = [[NSArray alloc] initWithObjects:requiredMediaType, nil];
            picker.delegate = self;
            picker.allowsEditing=YES;

            if (kSystemVersion>7) {
                picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self presentViewController:picker animated:YES completion:nil];
            //            }
        }
    }
    
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage * oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 保存图片到相册中
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(oriImage, self,selectorToCall, NULL);
    }
    self.didanImage = image;
    [NetManager uploadImg:image parameters:@{@"id":_modeList.strId} apiName:@"uploadStockSrlPic" uploadUrl:nil uploadimgName:nil progressBlock:nil succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *msg = successDict[@"msg"];
        if ([msg isEqualToString:@"success"])
        {
            NSDictionary *dict = successDict[@"result"];
            _modeList.strCounterfoilDomain = dict[@"counterfoil_domain"];
            _modeList.strCounterfoilUrl = dict[@"counterfoil_url"];
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.didanBT setTitle:@"查看底单" forState:UIControlStateNormal];
//        [self.didanBT setImage:self.didanImage forState:UIControlStateNormal];
    }];
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
        paramImage = nil;
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}

-(void)showImage:(UIImage *)aImage{
    UIImage *image=aImage;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=CGRectMake(-1, kMainScreenHeight, 1, 1);
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
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
