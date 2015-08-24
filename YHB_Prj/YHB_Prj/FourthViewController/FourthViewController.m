//
//  FourthViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FourthViewController.h"
#import "FourthTableViewCell.h"

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
}
@end

@implementation FourthViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"我的"];
    
    CGFloat topImgViewH = kMainScreenWidth/320*206;
    _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topImgViewH)];
    _topImgView.image = [UIImage imageNamed:@"mine_bg_1"];
    
    CGFloat mengViewH = kMainScreenWidth/320*176;
    _topMengView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topImgView.height-mengViewH, kMainScreenWidth, mengViewH)];
    _topMengView.image = [UIImage imageNamed:@"mine_bg_1_meng"];
    [_topImgView addSubview:_topMengView];
    
    CGFloat originX = 15;
    CGFloat interval = 10;
    kCreateLabel(_userComLabel, CGRectMake(originX, topImgViewH-30, kMainScreenWidth-2*originX, 17), 14, [UIColor whiteColor], @"公司名称:好邻居贸易公司");
    [_topImgView addSubview:_userComLabel];
    
    kCreateLabel(_userNameLabel, CGRectMake(originX, _userComLabel.top-17-interval, kMainScreenWidth/2.0-originX-10, 17), 14, [UIColor whiteColor], @"掌柜:昵称重复");
    [_topImgView addSubview:_userNameLabel];
    
    CGFloat stringWidth = [@"信用:" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont14,NSFontAttributeName, nil]].width;
    
    kCreateLabel(_userProLabel, CGRectMake(kMainScreenWidth/2.0, _userNameLabel.top, stringWidth, 17), 14, [UIColor whiteColor], @"信用:");
    [_topImgView addSubview:_userProLabel];
    
    _proBgView = [[UIView alloc] initWithFrame:CGRectMake(_userProLabel.right, _userProLabel.top+3.5, 100, 11)];
    [_topImgView addSubview:_proBgView];
    [self setStarCount:5];
    
    CGFloat imgWidth = 59;
    _userImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX, _userNameLabel.top-50-imgWidth, imgWidth, imgWidth)];
    [_userImgBtn setImage:[UIImage imageNamed:@"mine_icon_1"] forState:UIControlStateNormal];
    _userImgBtn.layer.cornerRadius = imgWidth/2.0;
    _userImgBtn.layer.masksToBounds = YES;
    [_userImgBtn addTarget:self action:@selector(plusImageClicked) forControlEvents:UIControlEventTouchUpInside];
    _topImgView.userInteractionEnabled = YES;
    [_topImgView addSubview:_userImgBtn];
    
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-49)];
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
    _mineTableView.tableHeaderView = _topImgView;
    _mineTableView.tableFooterView = [UIView new];
    _mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mineTableView];
    
    _cellTitleArray = @[@"商户管理", @"门店管理", @"店员管理", @"供货商管理", @"设置", @"", @"快速扫描", @"问题商品"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellTitleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5)
    {
        return 10;
    }
    return [FourthTableViewCell heightForFourthCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kMainScreenWidth-50, 0.5)];
        lineView.backgroundColor = RGBCOLOR(220, 220, 220);
        [cell addSubview:lineView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FourthTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row!=5)
    {
        cell.cellImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mine_menu_%d", (int)indexPath.row]];
        cell.cellTitleLabel.text = _cellTitleArray[indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MLOG(@"%ld", indexPath.row);
}

- (void)setStarCount:(int)aCount
{
    [self removeSubviews:_proBgView];
    for (int i=0; i<aCount; i++)
    {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(15*i, 0, 13, 11)];
        starImg.image = [UIImage imageNamed:@"mine_icon_2"];
        [_proBgView addSubview:starImg];
    }
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
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_userImgBtn setImage:image forState:UIControlStateNormal];
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
