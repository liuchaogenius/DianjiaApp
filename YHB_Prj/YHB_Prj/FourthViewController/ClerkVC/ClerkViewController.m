//
//  ClerkViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ClerkViewController.h"
#import "ClerkTableViewCell.h"
#import "ClerkDetailViewController.h"
#import "EmpManage.h"

@interface ClerkViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_clerkTableView;
}
@property(nonatomic, strong) EmpManage *manage;
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ClerkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员管理";
    
    _clerkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:UITableViewStylePlain];
    _clerkTableView.backgroundColor = [UIColor whiteColor];
    _clerkTableView.delegate = self;
    _clerkTableView.dataSource = self;
    _clerkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_clerkTableView];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _manage = [[EmpManage alloc] init];
    [_manage getEmpListWithFinishBlock:^(NSArray *resultArr) {
        _dataArray = [resultArr mutableCopy];
        [_clerkTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ClerkTableViewCell heightForClerkCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ClerkCell";
    ClerkTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"ClerkTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ClerkTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    cell.cellImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mine_menu_%d", (int)indexPath.row]];
    //    cell.cellTitleLabel.text = _cellTitleArray[indexPath.row];
    EmpMode *mode = _dataArray[indexPath.row];
    [cell setCellWithMode:mode];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    NSLog(@"%ld", indexPath.row);
    EmpMode *mode = _dataArray[indexPath.row];
    ClerkDetailViewController *vc= [[ClerkDetailViewController alloc] initWithMode:mode];
    [self.navigationController pushViewController:vc animated:YES];
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
