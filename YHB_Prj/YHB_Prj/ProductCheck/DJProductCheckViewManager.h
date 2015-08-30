//
//  DJProductCheckViewManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJCheckCartItemComponent.h"

@interface DJProductCheckViewManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<DJCheckCartItemComponent> delegate;

- (void)showCheckViewFromViewController: (UIViewController *)vc;

@end
