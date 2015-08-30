//
//  DJProductSearchBar.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJProductSearchBar : UIView

- (void)setNeedShowSearchVCHandler: (dispatch_block_t)showSearchHandler andShowScanVCHandler: (dispatch_block_t)showScanHandler;

@end
