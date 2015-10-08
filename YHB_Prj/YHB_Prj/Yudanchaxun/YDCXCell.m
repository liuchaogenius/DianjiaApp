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
    self.labelMoney.text = [NSString stringWithFormat:@"￥%.2f", [aMode.payrelMoney floatValue]];
    self.labelNum.text = [NSString stringWithFormat:@"%.f", aMode.rowsIdentifier];
    self.labelOdd.text = aMode.srl;
    NSString *proStr = [NSString stringWithFormat:@"￥%.2f", [aMode.profitMoney floatValue]];
    
    self.labelTime.text = aMode.orderTime;
    NSString *typeStr = aMode.status==1?@"未结清":@"已结清";
    if(aMode.status == 1)
    {
        self.labelProfitDes.hidden = YES;
        self.labelProfit.hidden = YES;
        self.shifuLabel.text = @"应付：";
    }
    else
    {
        self.labelProfitDes.hidden = NO;
        self.labelProfit.hidden = NO;
        self.labelProfit.text = proStr;
        self.shifuLabel.text = @"实付：";
    }
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
