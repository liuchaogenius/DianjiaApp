//
//  LSCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSMode.h"
@interface LSCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dianmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *lsdanhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *xiaoshouStatus;
@property (strong, nonatomic) IBOutlet UILabel *shifuLabel;
@property (strong, nonatomic) IBOutlet UILabel *lirunLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderTimerLabel;
- (void)setCellData:(LSMode *)aMode;
@end
