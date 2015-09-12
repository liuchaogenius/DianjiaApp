//
//  WYJHDetailCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHDetailCell.h"
#import "WYJHMode.h"

@implementation WYJHDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellData:(WYJHMode *)mode
{
    [self resetView];
    self.pinmingLabel.text = mode.strProductName;
    self.dinghuoshuliangLabel.text = mode.strStayQty;
    self.jinjiaLabel.text = mode.strStockPrice;
    self.kucunLabel.text = mode.strStayQty;
    self.xiaojiLabel.text = mode.strShelfDys;
}

- (void)resetView
{
    self.pinmingLabel.text = @"";
    self.dinghuoshuliangLabel.text = @"";
    self.jinjiaLabel.text = @"";
    self.kucunLabel.text = @"";
    self.xiaojiLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
