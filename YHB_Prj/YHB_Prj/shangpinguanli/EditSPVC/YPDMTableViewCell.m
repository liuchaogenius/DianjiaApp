//
//  YPDMTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YPDMTableViewCell.h"

@interface YPDMTableViewCell()
{
    CGRect _laFrame;
}
@property(nonatomic,strong) UILabel *laMa;
@property(nonatomic,strong) UIButton *btnJian;
@property(nonatomic,strong) void(^ myBlock)(int);
@end

@implementation YPDMTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightForCell:(NSString *)str
{
    NSDictionary *strAttrbute = @{NSFontAttributeName:kFont12};
    CGSize strSize = [str boundingRectWithSize:CGSizeMake(kMainScreenWidth-50, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:strAttrbute context:nil].size;
    MLOG(@"%@", NSStringFromCGSize(strSize));
    return strSize.height+12;
}

- (CGSize)jisuangaodu:(NSString *)str
{
    NSDictionary *strAttrbute = @{NSFontAttributeName:kFont12};
    CGSize strSize = [str boundingRectWithSize:CGSizeMake(kMainScreenWidth-50, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:strAttrbute context:nil].size;
    return strSize;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {

    }
    return self;
}

- (void)setCellWithString:(NSString *)str andDeleteBlock:(void (^)(int))aDeleteBlock
{
    [self resetCell];
    
    _myBlock = aDeleteBlock;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGSize strSize = [self jisuangaodu:str];
    _laMa = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, strSize.width, strSize.height)];
    _laMa.font = kFont12;
    _laMa.numberOfLines = 0;
    _laMa.text = str;
    [self addSubview:_laMa];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, strSize.height+12-0.7, kMainScreenWidth, 0.5)];
    lineView.backgroundColor = RGBCOLOR(220, 220, 220);
    [self addSubview:lineView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-30, strSize.height/2.0+6-10, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"sp_jian"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)resetCell
{
    _myBlock = nil;
    [self removeSubviews:self];
}

- (void)touchBtn
{
    _myBlock(_row);
}

- (void)removeSubviews:(UIView *)aView
{
    while (aView.subviews.count)
    {
        UIView* child = aView.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
