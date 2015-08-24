//
//  FactoryModel.m
//  YHB_Prj
//
//  Created by  striveliu on 14/12/3.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FactoryModel.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "LoginViewController.h"
@interface FactoryModel()
@property (nonatomic, strong) FirstViewController *firstVC;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) ThirdViewController *thirdVC;
@property (nonatomic, strong) FourthViewController *fourthVC;
@end
@implementation FactoryModel
+ (FactoryModel *)shareFactoryModel
{
    static FactoryModel *factoryModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(factoryModel == nil)
        {
            factoryModel = [[FactoryModel alloc] init];
        }
    });
    return factoryModel;
}

- (NSArray *)getTabbarArrys
{
    UIViewController *vc1 = [self getFirstViewController];
    UIViewController *vc2 = [self getSecondViewController];
//    UIViewController *vc3 = [self getThirdViewController];
//    UIViewController *vc4 = [self getFourthViewController];
    NSArray *arry = @[vc1,vc2];
    return arry;
}

- (UIViewController *)getFirstViewController
{
    if(!self.firstVC)
    {
        self.firstVC = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    }
    return self.firstVC;
}

- (UIViewController *)getSecondViewController
{
    if(!self.secondVC)
    {
        self.secondVC = [[SecondViewController alloc] init];
    }
    return self.secondVC;
}
- (UIViewController *)getThirdViewController
{
    if(!self.thirdVC)
    {
        self.thirdVC = [[ThirdViewController alloc] init];
    }
    return self.thirdVC;
}

- (UIViewController *)getFourthViewController
{
    if(!self.fourthVC)
    {
        self.fourthVC = [[FourthViewController alloc] init];
    }
    return self.fourthVC;
}

- (UIViewController *)getloginViewController
{
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return vc;
}
@end
