//
//  YDCXDetailCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DJYDCXDetailList;

@interface YDCXDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelNum;
@property (strong, nonatomic) IBOutlet UILabel *labelZhe;
@property (strong, nonatomic) IBOutlet UILabel *labelSum;
@property (strong, nonatomic) IBOutlet UILabel *labelPri;

+ (CGFloat)heightForCell;
- (void)setCellWithMode:(DJYDCXDetailList *)aMode;
@end
