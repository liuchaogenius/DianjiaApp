//
//  GateTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "GateTableViewCell.h"

@implementation GateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightForGateCell
{
    return 80;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
