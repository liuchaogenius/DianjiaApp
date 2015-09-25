//
//  FourthViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FourthViewController.h"
#import "FourthTableViewCell.h"
#import "GateViewController.h"
#import "ClerkViewController.h"
#import "SupplierViewController.h"
#import "TenantViewController.h"
#import "SettingViewController.h"
#import "SDImageCache.h"
#import "LoginManager.h"
#import "SDWebImageManager.h"
#import "NetManager.h"
#import "ProblemGoodsViewController.h"
#import "ScanVC.h"
#import "CLTableViewCell.h"
#import "LoginMode.h"


#define userFace @"userFace"

static const CGFloat storeTVWidth = 100;

typedef enum : NSUInteger {
    cellTypeTenant = 0,//商户
    cellTypeGate,//门店
    cellTypeClerk,//店员
    cellTypeSupplier,//供货商
    cellTypeOption,//设置
    cellTypeNull,
    cellTypeScan,//快速扫描
    cellTypeMatter//问题商品
} cellType;

@interface FourthViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    UITableView *_mineTableView;
    UIImageView *_topImgView;
    UIImageView *_topMengView;
    NSArray *_cellTitleArray;
    
    UILabel *_userNameLabel;//姓名
    UILabel *_userComLabel;//公司
    UILabel *_userProLabel;//信誉
    UIButton *_userImgBtn;//头像按钮
    UIView *_proBgView;//星星的bgView
    
    UIView *_maskingView;
    UITapGestureRecognizer *_tapGR;
    UITableView *_storeTV;
    NSArray *_storeArr;
    
    //设置页面的view宽度
    CGFloat viewWidth;
}
@end

@implementation FourthViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [self reloadView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)reloadView
{
    //设置页面的view宽度
    viewWidth = kMainScreenWidth;
    
    LoginMode *mode = [[LoginManager shareLoginManager] getLoginMode];
    
    CGFloat topImgViewH = viewWidth/320*206;
    _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, topImgViewH)];
    _topImgView.image = [UIImage imageNamed:@"mine_bg_1"];
    
    CGFloat mengViewH = viewWidth/320*176;
    _topMengView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topImgView.height-mengViewH, viewWidth, mengViewH)];
    _topMengView.image = [UIImage imageNamed:@"mine_bg_1_meng"];
    [_topImgView addSubview:_topMengView];
    
    CGFloat originX = 15;
    CGFloat interval = 10;
    NSString *comName =mode.strCompanyName?mode.strCompanyName:@"";
    NSString *comStr = [NSString stringWithFormat:@"公司名称:%@", comName];
    kCreateLabel(_userComLabel, CGRectMake(originX, topImgViewH-30, viewWidth-2*originX, 17), 14, [UIColor whiteColor], comStr);
    [_topImgView addSubview:_userComLabel];
    
    NSString *userStr = [NSString stringWithFormat:@"掌柜:%@", mode.strNickName];
    kCreateLabel(_userNameLabel, CGRectMake(originX, _userComLabel.top-17-interval, viewWidth/2.0-originX-10, 17), 14, [UIColor whiteColor], userStr);
    [_topImgView addSubview:_userNameLabel];
    
    //字体
    CGFloat stringWidth = [@"信用:" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont14,NSFontAttributeName, nil]].width;
    
    kCreateLabel(_userProLabel, CGRectMake(viewWidth/2.0, _userNameLabel.top, stringWidth, 17), 14, [UIColor whiteColor], @"信用:");
    [_topImgView addSubview:_userProLabel];
    
    _proBgView = [[UIView alloc] initWithFrame:CGRectMake(_userProLabel.right, _userProLabel.top+3.5, 100, 11)];
    [_topImgView addSubview:_proBgView];
    for (int i=0; i<5; i++)
    {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(15*i, 0, 13, 11)];
        starImg.image = [UIImage imageNamed:@"mine_icon_2"];
        [_proBgView addSubview:starImg];
    }
    [self setStarCount:[mode.strCreditRating floatValue]];
    
    CGFloat imgWidth = 59;
    _userImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX, _userNameLabel.top-50-imgWidth, imgWidth, imgWidth)];
    [_userImgBtn setImage:[UIImage imageNamed:@"mine_icon_1"] forState:UIControlStateNormal];
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:userFace])
    {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:userFace];
        [_userImgBtn setImage:image forState:UIControlStateNormal];
    }
    else
    {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@", mode.strFaceDomain,mode.strFaceUrl];
        [manager downloadImageWithURL:[NSURL URLWithString:imgUrl]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 if (image) {
                                     [[SDImageCache sharedImageCache] storeImage:image
                                                                          forKey:userStr
                                                                          toDisk:YES];
                                     [_userImgBtn setImage:image forState:UIControlStateNormal];
                                 }
                             }];
    }
    _userImgBtn.layer.cornerRadius = imgWidth/2.0;
    _userImgBtn.layer.masksToBounds = YES;
    [_userImgBtn addTarget:self action:@selector(plusImageClicked) forControlEvents:UIControlEventTouchUpInside];
    _topImgView.userInteractionEnabled = YES;
    [_topImgView addSubview:_userImgBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"我的"];
    
    [self reloadView];
    
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, kMainScreenHeight-64-49)];
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
    _mineTableView.tableHeaderView = _topImgView;
    _mineTableView.tableFooterView = [UIView new];
    _mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mineTableView];
    
    _cellTitleArray = @[@"商户管理", @"门店管理", @"店员管理", @"供货商管理", @"设置", @"", @"快速扫描", @"问题商品"];
    
    [self createMaskingView];
    [self.view bringSubviewToFront:_mineTableView];
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
    _storeTV = [[UITableView alloc] initWithFrame:CGRectMake(viewWidth/2.0-storeTVWidth/2.0, _maskingView.height/2.0-storeTVHeight/2.0, storeTVWidth, storeTVHeight)];
    _storeTV.delegate =self;
    _storeTV.dataSource = self;
    _storeTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _storeTV.tableFooterView = [UIView new];
    [self.view addSubview:_storeTV];
}

- (void)touchMask
{
    [self.view bringSubviewToFront:_mineTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_mineTableView)
    {
        return _cellTitleArray.count;
    }
    else
    {
        return _storeArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_mineTableView)
    {
        if (indexPath.row==5)
        {
            return 10;
        }
        return [FourthTableViewCell heightForFourthCell];
    }
    else
    {
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_mineTableView)
    {
        if (indexPath.row != 5)
        {
            static NSString *cellId = @"FourthCell";
            FourthTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:@"FourthTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
                cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            }
            
            return cell;
        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, viewWidth-50, 0.5)];
            lineView.backgroundColor = RGBCOLOR(220, 220, 220);
            [cell addSubview:lineView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else
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
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FourthTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_mineTableView)
    {
        if(indexPath.row!=5)
        {
            cell.cellImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mine_menu_%d", (int)indexPath.row]];
            cell.cellTitleLabel.text = _cellTitleArray[indexPath.row];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_mineTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        switch (indexPath.row) {
            case cellTypeTenant:
            {
                TenantViewController *vc = [[TenantViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case cellTypeGate:
            {
                GateViewController *vc = [[GateViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case cellTypeClerk:
            {
                ClerkViewController *vc = [[ClerkViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case cellTypeSupplier:
            {
                SupplierViewController *vc = [[SupplierViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case cellTypeOption:
            {
                SettingViewController *vc = [[SettingViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case cellTypeScan:
            {
                [self.view bringSubviewToFront:_maskingView];
                [self.view bringSubviewToFront:_storeTV];
                break;
            }
            case cellTypeMatter:
            {
                ProblemGoodsViewController *vc = [[ProblemGoodsViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        StoreMode *mode = _storeArr[indexPath.row];
        [self.view bringSubviewToFront:_mineTableView];
        ScanVC *vc = [[ScanVC alloc] initWithMode:mode];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setStarCount:(float)aCount
{
    if (aCount - (int)aCount>0)
    {
        int i = (int)aCount;
        float j = aCount-i;
        _proBgView.width = i*15+j*13;
        _proBgView.layer.masksToBounds = YES;
    }
    else
    {
        _proBgView.width = aCount*15;
        _proBgView.layer.masksToBounds = YES;
    }
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (void)removeSubviews:(UIView *)aView
{
    while (aView.subviews.count)
    {
        UIView* child = aView.subviews.lastObject;
        [child removeFromSuperview];
    }
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
            picker.allowsEditing = YES;
            if (kSystemVersion>7) {
                picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self presentViewController:picker animated:YES completion:nil];
            //            }
        } else if (buttonIndex == UIImagePickerControllerSourceTypeCamera) { // 拍照
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;
            if (kSystemVersion>7) {
                picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_userImgBtn setImage:image forState:UIControlStateNormal];
    [[SDImageCache sharedImageCache] storeImage:image
                                         forKey:userFace
                                         toDisk:YES];
    [NetManager uploadImg:image parameters:nil apiName:@"uploadUserFacePic" uploadUrl:nil uploadimgName:nil progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        MLOG(@"%f", (float)totalBytesExpectedToWrite/totalBytesWritten);
    } succ:^(NSDictionary *successDict) {
        MLOG(@"1");
    } failure:^(NSDictionary *failDict, NSError *error) {
        MLOG(@"2");
    }];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage * oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 保存图片到相册中
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(oriImage, self,selectorToCall, NULL);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
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
