//
//  SupplierTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SupplierTableViewCell.h"
#import "SupplierMode.h"

@implementation SupplierTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightForSupplierCell
{
    return 140;
}

- (void)setCellWithSupplierMode:(SupplierMode *)aMode
{
    [self resetCell];
    self.nameLabel.text = aMode.strSupName;
    self.contactLabel.text = aMode.strContact;
    self.phoneLabel.text = aMode.strTel;
    self.mailLabel.text = aMode.strEmail;
    self.chuanzhenLabel.text = aMode.strFax;
    self.locaLabel.text = aMode.strAddress;
}

- (void)resetCell
{
    self.nameLabel.text = @"";
    self.contactLabel.text = @"";
    self.phoneLabel.text = @"";
    self.mailLabel.text = @"";
    self.chuanzhenLabel.text = @"";
    self.locaLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
