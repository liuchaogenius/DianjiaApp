//
//  RKSPCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKSPMode.h"

@interface RKSPCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dianmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongyingshangLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinhuoPrice;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
- (void)setCellData:(RKSPMode *)aMode;
@end
