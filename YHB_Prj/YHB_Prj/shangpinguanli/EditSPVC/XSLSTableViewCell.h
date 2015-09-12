//
//  XSLSTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XSLSMode;
@interface XSLSTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *laTime;
@property (strong, nonatomic) IBOutlet UILabel *laPrice;
@property (strong, nonatomic) IBOutlet UILabel *laNum;
@property (strong, nonatomic) IBOutlet UILabel *laPro;
@property (strong, nonatomic) IBOutlet UILabel *laSum;
@property (strong, nonatomic) IBOutlet UILabel *laLiu;
+ (CGFloat)heightForCell;
- (void)setCellWithMode:(XSLSMode *)aMode;
@end
