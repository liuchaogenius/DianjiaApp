//
//  YDCXCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YDCXCell.h"
#import "DJYDCXRows.h"

@implementation YDCXCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightForCell
{
    return 172;
}

- (void)setCellWithMode:(DJYDCXRows *)aMode
{
    self.labelMoney.text = [NSString stringWithFormat:@"%.2f", aMode.realMoney];
    self.labelNum.text = [NSString stringWithFormat:@"%d", (int)aMode.rowsIdentifier];
    self.labelOdd.text = aMode.srl;
    NSString *proStr;
    if ([aMode.profitMoney isKindOfClass:[NSString class]]) proStr = aMode.profitMoney;
    else proStr = [NSString stringWithFormat:@"%@", aMode.profitMoney];
    self.labelProfit.text = proStr;
    self.labelTime.text = aMode.orderTime;
    NSString *typeStr = aMode.status==1?@"未结清":@"已结清";
    self.labelType.text = typeStr;
    self.lableName.text = aMode.vipName;
}

- (void)resetCell
{
    self.labelMoney.text = @"";
    self.labelNum.text = @"";
    self.labelOdd.text = @"";
    self.labelProfit.text = @"";
    self.labelTime.text = @"";
    self.labelType.text = @"";
    self.lableName.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
