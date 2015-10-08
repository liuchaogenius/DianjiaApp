//
//  YDCXCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DJYDCXRows;

@interface YDCXCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelNum;
@property (strong, nonatomic) IBOutlet UILabel *lableName;
@property (strong, nonatomic) IBOutlet UILabel *labelTime;
@property (strong, nonatomic) IBOutlet UILabel *labelOdd;
@property (strong, nonatomic) IBOutlet UILabel *labelMoney;
@property (strong, nonatomic) IBOutlet UILabel *labelProfit;
@property (strong, nonatomic) IBOutlet UILabel *labelType;
@property (strong, nonatomic) IBOutlet UILabel *labelProfitDes;

@property (strong, nonatomic) IBOutlet UILabel *shifuLabel;
+ (CGFloat)heightForCell;
- (void)setCellWithMode:(DJYDCXRows *)aMode;

@end
