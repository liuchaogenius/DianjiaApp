//
//  WYJHListCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYJHMode.h"
@interface WYJHListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *gongyingshangLabel;
@property (strong, nonatomic) IBOutlet UILabel *shuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongjineLabel;
@property (strong, nonatomic) IBOutlet UILabel *danhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *dianmingLabel;
- (void)setCellData:(WYJHModeList *)aMode;
@end
