//
//  LSCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "LSCell.h"

@implementation LSCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(LSMode *)aMode
{
    [self resetView];
    self.orderTimerLabel.text = aMode.strOrder_time;
    self.dianmingLabel.text = aMode.strStore_name;
    self.lsdanhaoLabel.text = aMode.strSrl;
    NSString *strStatus = nil;
    if([aMode.strStatus intValue] == 2)
    {
        strStatus = @"退货";
    }
    else
    {
        strStatus = @"正常";
    }
    self.xiaoshouStatus.text = strStatus;
    self.shifuLabel.text = aMode.strReal_money;
    self.lirunLabel.text = aMode.strProfit_money;
}

- (void)resetView
{
    self.orderTimerLabel.text = @"";
    self.dianmingLabel.text = @"";
    self.lsdanhaoLabel.text = @"";
    self.xiaoshouStatus.text = @"";
    self.shifuLabel.text = @"";
    self.lirunLabel.text = @"";
}

@end
