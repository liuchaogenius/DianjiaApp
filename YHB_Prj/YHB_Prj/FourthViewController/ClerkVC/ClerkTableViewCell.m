//
//  ClerkTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ClerkTableViewCell.h"

@implementation ClerkTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightForClerkCell
{
    return 100;
}

- (void)setCellWithMode:(EmpMode *)aMode
{
    self.nameLabel.text = @"";
    self.locaLabel.text = @"";
    self.numLabel.text = @"";
    self.jobLabel.text = @"";
    self.phoneLabel.text = @"";

    self.nameLabel.text = aMode.stremp_name;
    self.numLabel.text = aMode.strlogin_name;
    self.jobLabel.text = aMode.stremp_type_name;
    self.phoneLabel.text = aMode.strphone;
    self.locaLabel.text = aMode.strstore_name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
