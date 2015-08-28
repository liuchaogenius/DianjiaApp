//
//  DJStoryboadManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJStoryboadManager : NSObject

+ (instancetype)sharedInstance;

- (UIViewController *)viewControllerWithName: (NSString *)name;

@end
