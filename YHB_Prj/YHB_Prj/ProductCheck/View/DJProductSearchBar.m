//
//  DJProductSearchBar.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductSearchBar.h"
#define kIconWidth 30.

@interface DJProductSearchBar()

@property (nonatomic, copy) dispatch_block_t showSearchHandler;
@property (nonatomic, copy) dispatch_block_t showScanHandler;

@end

@implementation DJProductSearchBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUI];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(10, 0, kMainScreenWidth-20, 40.);
    }
    return self;
}

- (void)setNeedShowSearchVCHandler:(dispatch_block_t)showSearchHandler andShowScanVCHandler:(dispatch_block_t)showScanHandler {
    self.showSearchHandler = showSearchHandler;
    self.showScanHandler = showScanHandler;
}

- (void)setUI{
    UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(5., 0, kMainScreenWidth-15. - 40, self.height)];
    [textButton setTitle:@"请输入商品名称/简拼/条码" forState:UIControlStateNormal];
    textButton.backgroundColor = [UIColor clearColor];
    textButton.titleLabel.font = kFont14;
    [textButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    textButton.userInteractionEnabled = YES;
    [textButton addTarget:self action:@selector(touchSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:textButton];
    
    UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(textButton.right, (self.height-kIconWidth)/2., kIconWidth, kIconWidth)];
    [icon setImage:[UIImage imageNamed:@"mine_menu_6"] forState:UIControlStateNormal];
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon addTarget:self action:@selector(touchScanItem) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:icon];
    
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowRadius = 2.;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kMainScreenWidth-20., 40.)];
    self.layer.shadowPath = path.CGPath;
    self.clipsToBounds= NO;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    //self.layer.borderWidth = 2.0;
    self.layer.shadowOpacity = 1.;
}

- (void)touchScanItem{
    if (self.showScanHandler) {
        self.showScanHandler();
    }
}

- (void)touchSearchBar:(UIButton *)sender {
    if (self.showSearchHandler) {
        self.showSearchHandler();
    }
}
     
@end
