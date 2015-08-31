//
//  CLTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "CLTableViewCell.h"

@implementation CLTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)aWidth
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aWidth, 30)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, aWidth, 0.5)];
        lineView.backgroundColor = RGBCOLOR(220, 220, 220);
        [self addSubview:lineView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
