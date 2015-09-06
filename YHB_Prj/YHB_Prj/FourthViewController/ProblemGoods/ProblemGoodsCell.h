//
//  ProblemGoodsCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/6.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PGRows;
@interface ProblemGoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelOdd;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelInPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelOutPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelNum;
@property (strong, nonatomic) IBOutlet UILabel *labelType;

+ (CGFloat)heightForCell;
- (void)resetCell;
- (void)setCellWithMode:(PGRows *)aMode;
@end
