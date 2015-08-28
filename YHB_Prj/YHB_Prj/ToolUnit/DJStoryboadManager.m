//
//  DJStoryboadManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJStoryboadManager.h"

@interface DJStoryboadManager()

@property (nonatomic, strong) UIStoryboard *storyboard;

@end

@implementation DJStoryboadManager

+ (instancetype)sharedInstance {
    static DJStoryboadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DJStoryboadManager alloc] init];
    });
    return manager;
}

#pragma mark - getter
- (UIStoryboard *)storyboard {
    if (!_storyboard) {
        _storyboard = [UIStoryboard storyboardWithName:@"ProductCheck" bundle:[NSBundle mainBundle]];
    }
    return _storyboard;
}

- (UIViewController *)viewControllerWithName: (NSString *)name {
    return [self.storyboard instantiateViewControllerWithIdentifier:name];
}

@end
