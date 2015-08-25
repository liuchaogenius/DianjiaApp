//
//  ZXBJCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KCYJMode;
@interface ZXBJCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dianmingValue;
@property (strong, nonatomic) IBOutlet UILabel *pinmingValue;
@property (strong, nonatomic) IBOutlet UILabel *dqkcValue;
@property (strong, nonatomic) IBOutlet UILabel *xsslValue;
@property (strong, nonatomic) IBOutlet UILabel *xszlValue;
@property (strong, nonatomic) IBOutlet UILabel *yjswValue;

@property (strong, nonatomic) IBOutlet UILabel *zcbValue;
- (void)setCellValue:(KCYJMode *)aMode;
@end
