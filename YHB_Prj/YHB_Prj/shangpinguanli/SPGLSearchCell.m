//
//  SPGLSearchCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLSearchCell.h"
#import "UIImageView+WebCache.h"

@implementation SPGLSearchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellData:(SPGLProductMode *)aMode
{
    NSString *picurl = nil;
    if(aMode.picList && aMode.picList.count>0)
    {
        SPGLProductPicMode *pic = [aMode.picList objectAtIndex:0];
        picurl = pic.strPic;
    }
    [self.headUrl sd_setImageWithURL:[NSURL URLWithString:picurl] placeholderImage:nil];
    
    self.pinming.text = aMode.strProductName;
    self.jinjiaLabel.text = aMode.strBuyingPrice;
    self.kucunlabel.text = [NSString stringWithFormat:@"%.2f", [aMode.strStockQty floatValue]];
    self.shoujiaLabel.text = aMode.strSalePrice;
    self.zhekouLabel.text = aMode.strSaleUnit;
}
- (void)resetView
{
    [self.headUrl setImage:nil];
    self.pinming.text = @"";
    self.jinjiaLabel.text = @"";
    self.kucunlabel.text = @"";
    self.shoujiaLabel.text = @"";
    self.zhekouLabel.text = @"";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
