//
//  WYJHEditViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/16.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
@class WYJHMode;
@class WYJHModeList;
@interface WYJHEditViewController : BaseViewController

- (instancetype)initWithMode:(WYJHMode *)aMode modeList:(WYJHModeList *)aList andChangeBlock:(void(^)(void))aBlock canNull:(BOOL)aBool;

@end
