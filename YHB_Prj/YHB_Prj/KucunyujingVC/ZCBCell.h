//
//  ZCBCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCYJMode.h"
@interface ZCBCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dianmingValue;
@property (strong, nonatomic) IBOutlet UILabel *KCZLValue;
@property (strong, nonatomic) IBOutlet UILabel *ZJHJValue;
@property (strong, nonatomic) IBOutlet UILabel *ZXSJValue;
- (void)setCellData:(StoreTockMode *)aMode;
@end
