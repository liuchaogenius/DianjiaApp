//
//  AppDelegate.h
//  yihaobu
//
//  Created by  striveliu on 14-10-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootTabBarController *rootvc;
- (void)changeWindowRootviewcontroller;
+ (AppDelegate *)shareAppdelegate;
- (void)logout;
@end

