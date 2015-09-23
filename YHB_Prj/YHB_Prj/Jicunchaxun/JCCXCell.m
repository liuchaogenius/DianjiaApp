//
//  JCCXCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JCCXCell.h"
#import "JCCXMode.h"
@implementation JCCXCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(JCCXMode *)aMode
{
    [self resetview];
    self.vipNumLabel.text = aMode.strVipCode;
    self.vipNameLabel.text = aMode.strVipName;
    self.pinmingLabel.text = aMode.strProductName;
    self.dianmingLabel.text = aMode.strStoreName;
    self.dqkcCountLabel.text = aMode.strSrplusSum;
    self.qhzlCountLabel.text = aMode.strSurplusNum;
    self.qhsjLabel.text = aMode.strOrderTimer;
}

- (void)resetview
{
    self.vipNumLabel.text = @" ";
    self.vipNameLabel.text = @" ";
    self.pinmingLabel.text = @"";
    self.dianmingLabel.text = @"";
    self.dqkcCountLabel.text = @"";
    self.qhzlCountLabel.text = @"";
    self.qhsjLabel.text = @"";
}

@end
