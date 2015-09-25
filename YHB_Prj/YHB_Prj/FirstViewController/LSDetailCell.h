//
//  LSDetailCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDetailMode.h"

@interface LSDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *liushuidanhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *pinmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekouLabel;
@property (strong, nonatomic) IBOutlet UILabel *shuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *shishouLabel;

- (void)setCellData:(LSDetailMode *)aMode;
@end
