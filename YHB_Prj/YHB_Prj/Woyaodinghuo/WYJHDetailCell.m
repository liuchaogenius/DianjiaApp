//
//  WYJHDetailCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHDetailCell.h"
#import "WYJHMode.h"

@interface WYJHDetailCell()
@property(nonatomic,assign) int row;
@property(nonatomic,strong) void(^ myBlock)(int);
@end

@implementation WYJHDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellData:(WYJHMode *)mode
{
    [self resetView];
    self.pinmingLabel.text = mode.strProductName;
    self.dinghuoshuliangLabel.text = mode.strStockNum;
    self.jinjiaLabel.text = [NSString stringWithFormat:@"￥%.2f", [mode.strStockPrice floatValue]];
    self.kucunLabel.text = mode.strStockQty;
    self.xiaojiLabel.text = [NSString stringWithFormat:@"￥%.2f", [mode.strStockPrice floatValue]*[mode.strStockNum floatValue]];
}

- (void)resetView
{
    self.pinmingLabel.text = @"";
    self.dinghuoshuliangLabel.text = @"";
    self.jinjiaLabel.text = @"";
    self.kucunLabel.text = @"";
    self.xiaojiLabel.text = @"";
}

- (void)setCellRow:(int)aRow andTouchBlock:(void (^)(int))aBlock
{
    _row = aRow;
    _myBlock = aBlock;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _myBlock(_row);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
