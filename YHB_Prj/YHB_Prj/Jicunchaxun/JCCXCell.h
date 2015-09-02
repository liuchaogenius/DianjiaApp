//
//  JCCXCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCCXMode;
@interface JCCXCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *pinmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *dianmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *dqkcCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *qhzlCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *qhsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *vipNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *vipNameLabel;
- (void)setCellData:(JCCXMode *)aMode;
@end
