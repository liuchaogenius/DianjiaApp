//
//  SetTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SetTableViewCell.h"

static const float setCellHeight = 50;

@implementation SetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithImgName:(NSString *)aImgName title:(NSString *)aTitle
{
    if (self = [super init])
    {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (setCellHeight-16)/2.0, 17, 16)];
        iconView.image = [UIImage imageNamed:aImgName];
        [self addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+3, iconView.top, 150, 16)];
        titleLabel.text = aTitle;
        titleLabel.font = kFont12;
        [self addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom+2, kMainScreenWidth-titleLabel.left-20, 0.8)];
        lineView.backgroundColor = RGBCOLOR(220, 220, 220);
        [self addSubview:lineView];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(lineView.right+2, (setCellHeight-10)/2.0, 6, 10)];
        rightView.image = [UIImage imageNamed:@"rightArrow"];
        [self addSubview:rightView];
    }
    return self;
}

+ (CGFloat)heightForSetCell
{
    return setCellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
