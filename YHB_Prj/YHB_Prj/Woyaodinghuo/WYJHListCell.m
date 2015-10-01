//
//  WYJHListCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHListCell.h"

@implementation WYJHListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellData:(WYJHModeList *)aMode
{
    [self resetview];
    self.gongyingshangLabel.text = aMode.strSupName;
    self.shuliangLabel.textColor = KColor;
    self.zongjineLabel.textColor = KColor;
    self.shuliangLabel.text = [NSString stringWithFormat:@"%.1f", [aMode.strStockNum floatValue]];
    self.zongjineLabel.text = [NSString stringWithFormat:@"￥%.2f", [aMode.strTotalRealPay floatValue]];
    self.danhaoLabel.text = aMode.strSrl;
    self.dianmingLabel.text = aMode.strStockName;
}

- (void)resetview
{
    self.gongyingshangLabel.text = @"";
    self.shuliangLabel.text = @"";
    self.zongjineLabel.text = @"";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
