//
//  RKSPCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RKSPCell.h"

@implementation RKSPCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(RKSPMode *)aMode zhongCount:(int)aCount
{
    [self resetView];
    self.dianmingLabel.text = aMode.strStoreName;
    self.gongyingshangLabel.text = aMode.strSupName;
    self.jinhuoPrice.text = aMode.strStockPrice;
    self.descLabel.text = [NSString stringWithFormat:@"总计%d种商品，共%@件",aCount,aMode.strStockNum];
}

- (void)resetView
{
    self.dianmingLabel.text = @"";
    self.gongyingshangLabel.text = @"";
    self.jinhuoPrice.text = @"";
    self.descLabel.text = [NSString stringWithFormat:@"总计0种商品，共0件"];
}
@end
