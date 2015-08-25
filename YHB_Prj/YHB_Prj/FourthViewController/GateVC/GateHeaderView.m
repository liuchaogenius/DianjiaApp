//
//  GateHeaderView.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "GateHeaderView.h"
#define cellHeight 30

@interface GateHeaderView()
{
    UILabel *_textLabel;
    UILabel *_titleLabel;
}

@end

@implementation GateHeaderView

+ (CGFloat)HeightForGateHeaderView
{
    return cellHeight;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        [self createView];
    }
    return self;
}

- (void)createView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, cellHeight)];
    bgView.backgroundColor = RGBCOLOR(220, 220, 220);
    [self addSubview:bgView];
    
    kCreateLabel(_textLabel, CGRectMake(15, cellHeight/2.0-8, 30, 16), 12, [UIColor blackColor], @"店名:");
    [self addSubview:_textLabel];
    
    kCreateLabel(_titleLabel, CGRectMake(50, _textLabel.top, 150, 16), 12, [UIColor blackColor], @"团结湖烟酒店");
    [self addSubview:_titleLabel];
}

@end
