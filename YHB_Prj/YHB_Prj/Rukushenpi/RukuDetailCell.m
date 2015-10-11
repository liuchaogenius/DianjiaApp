//
//  RukuDetailCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RukuDetailCell.h"
#import "RKSPMode.h"
@implementation RukuDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(RKSPMode *)aMode
{
    [self resetview];
    self.dianmingLabel.text = aMode.strStoreName;
    self.pinmingLabel.text = aMode.strProductName;
    self.jinjiaLabel.text = aMode.strStockPrice;
    CGFloat zongjia = [aMode.strStockNum intValue]*[aMode.strStockPrice floatValue];
    NSString *strzj = nil;
    kFloatToString(strzj, zongjia);
    self.zongjiaLabel.text = strzj;
}

- (void)resetview
{
    self.pinmingLabel.text = @"";
    self.dianmingLabel.text = @"";
    self.jinjiaLabel.text = @"";
    self.zongjiaLabel.text = @"";
}

@end
