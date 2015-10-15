//
//  SettingViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SettingViewController.h"
#import "SetTableViewCell.h"
#import "NetManager.h"
#import "FBViewController.h"
#import "AboutUsViewController.h"
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, cellType){
    cellTypeAbout=0,
//    cellTypeRecommend,
//    cellTypeFeedBack,
    cellTypeCheckNew
};

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *_updateUrl;
}
@property(nonatomic, strong) UITableView *setTV;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) UIButton *logoutBtn;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleArray = @[@"关于我们",@"检查新版本"];//,@"意见反馈",@"推荐给朋友"
    
    _setTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _setTV.delegate = self;
    _setTV.dataSource = self;
    _setTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_setTV];
    
    CGFloat cellH = [SetTableViewCell heightForSetCell];
    UIColor *btnColor = KColor;
    CGFloat btnWidth = 260;
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-2*cellH)];
    _logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth-btnWidth)/2.0, tableFooterView.bottom-40-20, btnWidth, 40)];
    [_logoutBtn addTarget:self action:@selector(touchLogout) forControlEvents:UIControlEventTouchDown];
    [_logoutBtn setTitleColor:btnColor forState:UIControlStateNormal];
    _logoutBtn.layer.borderColor = [btnColor CGColor];
    _logoutBtn.layer.cornerRadius = 5;
    _logoutBtn.titleLabel.font = kFont13;
    _logoutBtn.layer.borderWidth = 1.5;
    [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [tableFooterView addSubview:_logoutBtn];

    _setTV.tableFooterView = tableFooterView;
}

- (void)touchLogout
{
    [self.navigationController popViewControllerAnimated:NO];
    [[AppDelegate shareAppdelegate] logout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SetTableViewCell heightForSetCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imgName = [NSString stringWithFormat:@"set_%ld", indexPath.row];
    NSString *title = _titleArray[indexPath.row];
    SetTableViewCell *cell = [[SetTableViewCell alloc] initWithImgName:imgName title:title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case cellTypeAbout:
        {
            AboutUsViewController *vc = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
//        case cellTypeRecommend:
//        {
////            NSString *textToShare = @"请大家登录《iOS云端与网络通讯》服务网站。";
////            UIImage *imageToShare = [UIImage imageNamed:@"login_icon"];
//            NSURL *urlToShare = [NSURL URLWithString:@"http://www.dianjia001.com"];
//            NSArray *activityItems = @[urlToShare];//textToShare, imageToShare,
//            
//            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
//                                                                                    applicationActivities:nil];
//            //不出现在活动项目
//            activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                                 UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
//            [self presentViewController:activityVC animated:TRUE completion:nil];
//            break;
//        }
//        case cellTypeFeedBack:
//        {
//            FBViewController *vc = [[FBViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//            break;
//        }
        case cellTypeCheckNew:
        {
            [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            CFShow((__bridge CFTypeRef)(infoDictionary));
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            [dict setObject:app_Version forKey:@"v_code"];
            [dict setObject:@1 forKey:@"sys_type"];
            [NetManager requestWith:dict apiName:@"getVersionInfo" method:@"POST" succ:^(NSDictionary *successDict) {
//                MLOG(@"%@", successDict);
                NSDictionary *resultDict = successDict[@"result"];
                int vid = [resultDict[@"id"] intValue];
                if (vid==0) [SVProgressHUD showSuccessWithStatus:@"当前是最新版本,无需更新" cover:YES offsetY:kMainScreenHeight/2.0];
                else
                {
                    [SVProgressHUD dismiss];
                    _updateUrl = [NSString stringWithFormat:@"%@%@", resultDict[@"pathDomain"], resultDict[@"pathUrl"]];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否现在去更新" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    [alertView show];
                }
            } failure:^(NSDictionary *failDict, NSError *error) {
                
            }];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
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
