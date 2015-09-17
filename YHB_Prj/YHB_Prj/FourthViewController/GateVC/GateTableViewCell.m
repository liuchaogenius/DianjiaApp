//
//  GateTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "GateTableViewCell.h"
#import "LoginMode.h"
@implementation GateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightForGateCell
{
    return 80;
}

- (void)setCellWithMode:(StoreMode *)aMode
{
    self.locaLabel.text = @"";
    self.nameLabel.text = @"";
    self.phoneLabel.text = @"";
    self.locaLabel.text = aMode.strContactAddr;
    self.nameLabel.text = aMode.strContactName;
    self.phoneLabel.text = aMode.strContactPhone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
