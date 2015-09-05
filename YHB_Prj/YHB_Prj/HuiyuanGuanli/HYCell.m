//
//  HYCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYCell.h"
#import "VipInfoMode.h"
#import "UIImageView+WebCache.h"
@implementation HYCell
@synthesize isSelect;
- (void)awakeFromNib {
    // Initialization code
    [self.selectButton addTarget:self action:@selector(selectButtomItem) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(VipInfoMode *)aMode isSelect:(BOOL)aIsSelect indexpath:(int)aIndex
{
    [self reseteView];
    self.headImgView.layer.cornerRadius = self.headImgView.width/2;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:aMode.strPortraitUrl] placeholderImage:[UIImage imageNamed:@"hyList_head_defalut"]];
    self.vipNum.text = aMode.strVipCode;
    self.vipName.text = aMode.strVipName;
    self.vipPhone.text = aMode.strVipPhone;
    self.vipScore.text = aMode.strVipScore;
    isSelect = aIsSelect;
    self.cellIndex = aIndex;
    if(isSelect == YES)
    {
        [self.selectButton setImage:[UIImage imageNamed:@"hyList_icon"] forState:UIControlStateNormal];
    }
    else
    {
        [self.selectButton setImage:[UIImage imageNamed:@"hyList_icon_nor"] forState:UIControlStateNormal];
    }
    if(aIndex < 0)
    {
        self.selectButton.hidden = YES;
    }
}

- (void)selectButtomItem
{
    isSelect = !isSelect;
    if(isSelect == YES)
    {
        [self.selectButton setImage:[UIImage imageNamed:@"hyList_icon"] forState:UIControlStateNormal];
    }
    else
    {
        [self.selectButton setImage:[UIImage imageNamed:@"hyList_icon_nor"] forState:UIControlStateNormal];

    }
    if(okButtonTarget && okButtonItemAction && [okButtonTarget respondsToSelector:okButtonItemAction])
    {
        IMP imp = [okButtonTarget methodForSelector:okButtonItemAction];
        void (*func)(id,SEL,id) = (void *)imp;
        func(okButtonTarget,okButtonItemAction,self);
    }
}

- (void)addSelectButtonItemCallBack:(id)aTarget
                         action:(SEL)aSelector
{
    okButtonTarget = aTarget;
    okButtonItemAction = aSelector;
}

- (void)reseteView
{
    [self.headImgView setImage:nil];
    self.vipNum.text = @"";
    self.vipName.text = @"";
    self.vipPhone.text = @"";
    self.vipScore.text = @"";
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif
@end
