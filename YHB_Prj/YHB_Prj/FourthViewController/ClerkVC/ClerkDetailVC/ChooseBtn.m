//
//  ChooseBtn.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ChooseBtn.h"

@interface ChooseBtn()
{
    UIView *_chooseView;
}

@end

@implementation ChooseBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        CGFloat height = frame.size.height;
        self.layer.cornerRadius = height/2.0;
        self.layer.borderWidth = 1;
        
        _chooseView = [[UIView alloc] initWithFrame:CGRectMake(height/2.0-4, height/2.0-4, 8, 8)];
        _chooseView.layer.cornerRadius = 4;
        _chooseView.backgroundColor = KColor;
        _chooseView.hidden = YES;
        [self addSubview:_chooseView];
    }
    return self;
}

- (void)becomeChoose
{
    _chooseView.hidden = NO;
    self.layer.borderColor = [KColor CGColor];
}

- (void)becomeHidden
{
    _chooseView.hidden = YES;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
}

@end
