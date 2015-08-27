//
//  HYLSXFCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYLSXFCell.h"

@implementation HYLSXFCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(HYGLOneMothMode *)aMode
{
    [self resetView];
    self.pinmingLabel.text = aMode.strProductName;
    self.danjiaLabel.text =  [NSString stringWithFormat:@"¥%@",aMode.strSalePrice];
    self.zhekouLabel.text = [NSString stringWithFormat:@"%@%@",aMode.strDiscountRate,@"%"];
    self.shuliangLabel.text = aMode.strSaleNum;
    self.shihouLabel.text = [NSString stringWithFormat:@"¥%@",aMode.strRealMoney];
}

- (void)resetView
{
    self.pinmingLabel.text = @"";
    self.danjiaLabel.text = @"";
    self.zhekouLabel.text = @"";
    self.shuliangLabel.text = @"";
    self.shihouLabel.text = @"";
}
@end
