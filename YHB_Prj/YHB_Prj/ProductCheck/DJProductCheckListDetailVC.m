//
//  DJProductCheckListDetailVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckListDetailVC.h"
#import "DJProductCheckListCell.h"

@interface DJProductCheckListDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *desNumLabel;

@end

@implementation DJProductCheckListDetailVC

#pragma mark - getter and setter
- (UILabel *)desNumLabel {
    if (!_desNumLabel) {
        _desNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kMainScreenHeight-20., 200, 20)];
        _desNumLabel.font = kFont12;
        _desNumLabel.text = @"总共盘点1种";
    }
    return _desNumLabel;
}

#pragma marl - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.desNumLabel];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJProductCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List" forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
