//
//  SPKCTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPKCTableViewCell.h"

@interface SPKCTableViewCell()

@property(nonatomic,strong) UILabel *mendianLabel;
@end

@implementation SPKCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightForCell
{
    return 50;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self createView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createView
{
    _mendianLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    _mendianLabel.font = kFont12;
    _mendianLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_mendianLabel];
    
    _countTf = [[UITextField alloc] initWithFrame:CGRectMake(20, _mendianLabel.bottom, kMainScreenWidth-40, 25)];
    _countTf.font = kFont12;
    _countTf.placeholder = @"0";
    _countTf.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_countTf];
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.3, kMainScreenWidth, 0.5)];
//    lineView.backgroundColor = [UIColor blackColor];
//    [self addSubview:lineView];
}

- (void)setCell:(NSString *)aStr
{
    _mendianLabel.text = aStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
