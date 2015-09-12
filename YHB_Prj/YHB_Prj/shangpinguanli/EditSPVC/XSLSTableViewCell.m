//
//  XSLSTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "XSLSTableViewCell.h"
#import "XSLSMode.h"

@implementation XSLSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightForCell
{
    return 108;
}

- (void)setCellWithMode:(XSLSMode *)aMode
{
    [self resetCell];
    _laNum.text = aMode.strSale_num;
    _laPrice.text = [NSString stringWithFormat:@"%.2f", [aMode.strSale_price floatValue]];
    _laPro.text = [NSString stringWithFormat:@"%@%%", aMode.strDiscount_rate];
    _laSum.text = [NSString stringWithFormat:@"%.2f", [aMode.strPayable_money floatValue]];
    _laTime.text = aMode.strOrder_time;
    _laLiu.text = aMode.strSrl;
}

- (void)resetCell
{
    _laNum.text = @"";
    _laPrice.text = @"";
    _laPro.text = @"";
    _laSum.text = @"";
    _laTime.text = @"";
    _laLiu.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
