//
//  ProblemGoodsCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/6.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ProblemGoodsCell.h"
#import "SPGLProductMode.h"

@implementation ProblemGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightForCell
{
    return 110;
}

- (void)setCellWithMode:(SPGLProductMode *)aMode
{
    [self resetCell];
    self.labelInPrice.text=[NSString stringWithFormat:@"%.2f",[aMode.strBuyingPrice floatValue]];
    self.labelName.text=aMode.strProductName;
    self.labelNum.text=[NSString stringWithFormat:@"%.f",[aMode.strStayQty floatValue]];
    self.labelOdd.text=[NSString stringWithFormat:@"%.f",[aMode.strProductCode floatValue]];
    self.labelOutPrice.text=[NSString stringWithFormat:@"%.2f",[aMode.strSalePrice floatValue]];
//    self.labelStatus.text=@"";
    self.labelType.text=aMode.strClsName;
}

- (void)resetCell
{
    self.labelInPrice.text=@"";
    self.labelName.text=@"";
    self.labelNum.text=@"";
    self.labelOdd.text=@"";
    self.labelOutPrice.text=@"";
    self.labelStatus.text=@"未完成";
    self.labelType.text=@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
