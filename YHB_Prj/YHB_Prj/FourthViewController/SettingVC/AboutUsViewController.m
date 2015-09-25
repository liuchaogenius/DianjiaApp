//
//  AboutUsViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *itemArray;
@property(strong,nonatomic) UIView *topView;
@property(strong,nonatomic) UITableView *myTV;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _itemArray = @[@"总公司：北京店佳科技有限公司",@"电话：010-57280795",@"地址：北京市朝阳区小庄路6号泰达时代中心4号楼1708室",@"分公司电话：025-87199106",@"地址：南京市江宁区将军大道55号钱宝大厦c座1206室"];
    
    [self createTopView];
    
    _myTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _myTV.delegate = self;
    _myTV.dataSource = self;
    _myTV.tableFooterView = [UIView new];
    _myTV.tableHeaderView = _topView;
//    _myTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTV];
    
}

- (void)createTopView
{
    CGFloat topViewH = 150;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topViewH)];
    [self.view addSubview:_topView];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, topViewH-0.7, kMainScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_topView addSubview:lineView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2.0-20, 15, 40, 40)];
    imgView.image = [UIImage imageNamed:@"login_icon"];
    [_topView addSubview:imgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+3, kMainScreenWidth, 16)];
    titleLabel.font = kFont10;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    titleLabel.text = [NSString stringWithFormat:@"v%@", app_Version];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, topViewH-70, kMainScreenWidth-32, 70)];
    detailLabel.text = [NSString stringWithFormat:@"     %@", @"通过店+平台，小店可以通过手机实现店铺远程管理，网店/实体店信息数据实时同步，还可以通过平台结识其他小店主，实现优惠订货、配货的全过程，店+旨在帮助小店主减少管理成本、降低进货成本，达到扶植小店，提升小店收益的最终目的。"];
    detailLabel.font = kFont11;
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = [UIColor grayColor];
    [_topView addSubview:detailLabel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = _itemArray[indexPath.row];
    cell.textLabel.font=kFont11;
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, kMainScreenWidth, 0.7)];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    [cell addSubview:lineView];
    
    return cell;
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
