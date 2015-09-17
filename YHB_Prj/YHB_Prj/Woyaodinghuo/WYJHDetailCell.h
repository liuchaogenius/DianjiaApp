//
//  WYJHDetailCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYJHMode;
@interface WYJHDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *pinmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *dinghuoshuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *kucunLabel;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel;

- (void)setCellData:(WYJHMode *)mode;
- (void)setCellRow:(int)aRow andTouchBlock:(void(^)(int))aBlock;
@end
