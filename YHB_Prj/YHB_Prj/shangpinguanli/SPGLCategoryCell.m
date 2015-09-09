//
//  SPGLCategoryCell.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLCategoryCell.h"

@implementation SPGLCategoryCell
@synthesize label;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setCategoryName:(NSString *)aName tableviewTag:(int)aTag
{
    if(label)
    {
        [label removeFromSuperview];
        label = nil;
    }
    if(aTag == 10)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 103*(kMainScreenWidth/320), 44)];
    }
    else
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 215*(kMainScreenWidth/320), 44)];
    }
    label.text = aName;
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    
    if(line)
    {
        [line removeFromSuperview];
        line = nil;
    }
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 44-0.5, label.width, 0.5)];
    line.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
