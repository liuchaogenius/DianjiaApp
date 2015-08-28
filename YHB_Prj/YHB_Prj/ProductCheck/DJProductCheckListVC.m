//
//  DJProductCheckListVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckListVC.h"
#import "DJProductCheckListCell.h"

@interface DJProductCheckListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DJProductCheckListVC

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJProductCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
