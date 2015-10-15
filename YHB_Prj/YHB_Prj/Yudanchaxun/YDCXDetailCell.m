//
//  YDCXDetailCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YDCXDetailCell.h"
#import "DJYDCXDetailList.h"

@implementation YDCXDetailCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightForCell
{
    return 90;
}

- (void)setCellWithMode:(DJYDCXDetailList *)aMode
{
    [self resetCell];
    self.labelName.text = aMode.productName;
    self.labelNum.text = [NSString stringWithFormat:@"%.f", aMode.saleNum];
    self.labelPri.text = [NSString stringWithFormat:@"%.2f", aMode.salePrice];
    self.labelSum.text = [NSString stringWithFormat:@"￥%.2f", [aMode.realMoney floatValue]];
    self.labelZhe.text = [NSString stringWithFormat:@"%.2f%%", aMode.discountRate];
}

- (void)resetCell
{
    self.labelName.text = @"";
    self.labelNum.text = @"";
    self.labelPri.text = @"";
    self.labelSum.text = @"";
    self.labelZhe.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
