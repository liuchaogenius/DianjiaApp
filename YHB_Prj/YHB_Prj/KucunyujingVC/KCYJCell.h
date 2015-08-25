//
//  KCYJCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCYJMode.h"

@interface KCYJCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dianmingValue;
@property (strong, nonatomic) IBOutlet UILabel *pinmingValue;
@property (strong, nonatomic) IBOutlet UILabel *dqkcValue;
@property (strong, nonatomic) IBOutlet UILabel *xsslValue;
@property (strong, nonatomic) IBOutlet UILabel *xszlValue;
@property (strong, nonatomic) IBOutlet UILabel *yjswValue;

- (void)setCellValue:(KCYJMode *)aMode;
@end
