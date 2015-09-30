//
//  JCCXDetailCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/30.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCCXDetailMode.h"

@interface JCCXDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *quhuoshijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *quhuoshuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
- (void)setCellData:(JCCXDetailMode *)aMode;
@end
