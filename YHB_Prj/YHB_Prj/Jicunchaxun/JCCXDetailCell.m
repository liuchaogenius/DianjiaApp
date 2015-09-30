//
//  JCCXDetailCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/30.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "JCCXDetailCell.h"

@implementation JCCXDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(JCCXDetailMode *)aMode
{
    [self resetView];
    self.productNameLabel.text = aMode.strproduct_name;
    self.quhuoshijianLabel.text = aMode.strorder_time;
    self.quhuoshuliangLabel.text = aMode.strtake_num;
}

- (void)resetView
{
    self.productNameLabel.text = @"";
    self.quhuoshijianLabel.text = @"";
    self.quhuoshuliangLabel.text = @"";
}
@end
