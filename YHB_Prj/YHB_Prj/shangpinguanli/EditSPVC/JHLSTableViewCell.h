//
//  JHLSTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHLSMode;
@interface JHLSTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *laTime;
@property (strong, nonatomic) IBOutlet UILabel *laName;
@property (strong, nonatomic) IBOutlet UILabel *laPrice;
@property (strong, nonatomic) IBOutlet UILabel *laNum;
@property (strong, nonatomic) IBOutlet UILabel *laSum;

+ (CGFloat)heightForCell;
- (void)setCellWithMode:(JHLSMode *)aMode;
@end
