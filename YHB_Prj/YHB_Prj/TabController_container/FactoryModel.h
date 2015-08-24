//
//  FactoryModel.h
//  YHB_Prj
//
//  Created by  striveliu on 14/12/3.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactoryModel : NSObject
+ (FactoryModel *)shareFactoryModel;
- (NSArray *)getTabbarArrys;
- (UIViewController *)getFirstViewController;
- (UIViewController *)getSecondViewController;
- (UIViewController *)getThirdViewController;
- (UIViewController *)getFourthViewController;
- (UIViewController *)getloginViewController;
@end
