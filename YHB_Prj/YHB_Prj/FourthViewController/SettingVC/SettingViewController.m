//
//  SettingViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SettingViewController.h"
#import "SetTableViewCell.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *setTV;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) UIButton *logoutBtn;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleArray = @[@"关于我们",@"推荐给朋友",@"意见反馈",@"检查新版本"];
    
    _setTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _setTV.delegate = self;
    _setTV.dataSource = self;
    _setTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_setTV];
    
    CGFloat cellH = [SetTableViewCell heightForSetCell];
    UIColor *btnColor = [UIColor orangeColor];
    CGFloat btnWidth = 200;
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-4*cellH)];
    _logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth-btnWidth)/2.0, tableFooterView.bottom-40-50, btnWidth, 40)];
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
    NSLog(@"%s", __func__);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    MLOG(@"%ld", indexPath.row);
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
