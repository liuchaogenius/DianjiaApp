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

- (void)setCellData:(WYJHMode *)aMode
{
    [self resetview];
    self.gongyingshangLabel.text = aMode.strSupName;
    self.shuliangLabel.text = aMode.strStockQty;
    self.zongjineLabel.text = aMode.strStockPrice;
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
