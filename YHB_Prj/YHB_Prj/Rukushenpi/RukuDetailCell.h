//
//  RukuDetailCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RKSPMode;
@interface RukuDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dianmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongjiaLabel;
- (void)setCellData:(RKSPMode *)aMode;
@end
