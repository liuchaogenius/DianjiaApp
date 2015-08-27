//
//  HYLSXFCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGLOneMothMode.h"

@interface HYLSXFCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *pinmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekouLabel;
@property (strong, nonatomic) IBOutlet UILabel *shuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *shihouLabel;
- (void)setCellData:(HYGLOneMothMode *)aMode;
@end
