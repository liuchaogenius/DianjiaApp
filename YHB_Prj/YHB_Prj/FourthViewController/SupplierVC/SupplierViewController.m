//
//  SupplierViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SupplierViewController.h"
#import "SupplierTableViewCell.h"

@interface SupplierViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_supplierTableView;
}
@end

@implementation SupplierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"供货商管理";
    
    _supplierTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:UITableViewStylePlain];
    _supplierTableView.backgroundColor = [UIColor whiteColor];
    _supplierTableView.delegate = self;
    _supplierTableView.dataSource = self;
    _supplierTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_supplierTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SupplierTableViewCell heightForSupplierCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SupplierCell";
    SupplierTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SupplierTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SupplierTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    cell.cellImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mine_menu_%d", (int)indexPath.row]];
    //    cell.cellTitleLabel.text = _cellTitleArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld", indexPath.row);
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
