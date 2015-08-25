//
//  ZCBCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ZCBCell.h"

@implementation ZCBCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(StoreTockMode *)aMode
{
    [self resetView];
    self.dianmingValue.text = aMode.strStoreName;
    self.KCZLValue.text = aMode.strStockQty;
    self.ZJHJValue.text = aMode.strStockMoney;
    self.ZXSJValue.text = aMode.strSaleMoney;
}

- (void)resetView
{
    self.dianmingValue.text = @"";
    self.KCZLValue.text = @"";
    self.ZJHJValue.text = @"";
    self.ZXSJValue.text = @"";
}
@end
