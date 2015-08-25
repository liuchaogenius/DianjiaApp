//
//  ZXBJCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ZXBJCell.h"
#import "KCYJMode.h"

@implementation ZXBJCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellValue:(KCYJMode *)aMode
{
    [self resetview];
    self.dianmingValue.text = aMode.strStoreName;
    self.pinmingValue.text = aMode.strProductName;
    self.dqkcValue.text = aMode.strStockQty;
    self.xsslValue.text = aMode.strSaleRate;
    self.xszlValue.text = aMode.strSaleNum;
    self.yjswValue.text = aMode.strSaleDays;
    self.zcbValue.text = aMode.strSumStockMoney;
}

- (void)resetview
{
    self.dianmingValue.text = @"";
    self.pinmingValue.text = @"";
    self.dqkcValue.text = @"";
    self.xsslValue.text = @"";
    self.xszlValue.text = @"";
    self.yjswValue.text = @"";
    self.zcbValue.text = @"";
}

@end
