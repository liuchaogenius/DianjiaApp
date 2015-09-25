//
//  LSDetailCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "LSDetailCell.h"

@implementation LSDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(LSDetailMode *)aMode
{
    [self resetView];
    self.liushuidanhaoLabel.text = aMode.strsrl;
    self.pinmingLabel.text = aMode.strproduct_name;
    self.danjiaLabel.text = [NSString stringWithFormat:@"¥%@",aMode.strsale_price];
    self.zhekouLabel.text = [NSString stringWithFormat:@"%@%@",aMode.strdiscount_rate,@"%"];
    self.shuliangLabel.text = aMode.strsale_num;
    self.shishouLabel.text = [NSString stringWithFormat:@"¥%@",aMode.strreal_money];
    
}

- (void)resetView
{
    self.liushuidanhaoLabel.text = @"";
    self.pinmingLabel.text = @"";
    self.danjiaLabel.text = @"";
    self.zhekouLabel.text = @"";
    self.shuliangLabel.text = @"";
    self.shishouLabel.text = @"";
}
@end
