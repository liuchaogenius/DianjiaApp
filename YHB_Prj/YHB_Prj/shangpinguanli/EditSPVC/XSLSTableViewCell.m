//
//  XSLSTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "XSLSTableViewCell.h"

@implementation XSLSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightForCell
{
    return 82;
}

- (void)resetCell
{
    _laNum.text = @"";
    _laPrice.text = @"";
    _laPro.text = @"";
    _laSum.text = @"";
    _laTime.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
