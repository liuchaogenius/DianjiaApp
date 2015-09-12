//
//  JHLSTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JHLSTableViewCell.h"
#import "JHLSMode.h"

@implementation JHLSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightForCell
{
    return 108;
}

- (void)setCellWithMode:(JHLSMode *)aMode
{
    [self resetCell];
    _laName.text = aMode.strSup_name;
    _laNum.text = aMode.strStock_num;
    _laPrice.text = [NSString stringWithFormat:@"%.2f", [aMode.strStock_price floatValue]];
    _laSum.text = [NSString stringWithFormat:@"%.2f", [aMode.strStock_price floatValue]*[aMode.strStock_num floatValue]];
    _laTime.text = aMode.strAdd_date;
}

- (void)resetCell
{
    _laName.text = @"";
    _laNum.text = @"";
    _laPrice.text = @"";
    _laSum.text = @"";
    _laTime.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
