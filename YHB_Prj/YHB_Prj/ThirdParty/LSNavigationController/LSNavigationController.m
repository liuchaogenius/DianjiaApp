//
//  LSNavigationController.m
//  Hubanghu
//
//  Created by  striveliu on 14-11-11.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "LSNavigationController.h"
#import "SloppySwiper.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface LSNavigationController ()
{
}
@property (nonatomic, strong) SloppySwiper *swipper;
@end

@implementation LSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setSwipeBackEnable:NO];

    // Do any additional setup after loading the view.
    __weak LSNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
        if (kSystemVersion >= 8) {
            self.swipper = [[SloppySwiper alloc] initWithNavigationController:self];
            self.delegate = self.swipper;
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (id)getIvarObject:(NSString *)ivarName target:(id)aTarget
{
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([aTarget class], &outCount);
    NSString *propertyName = nil;
    for(int i=0; i<outCount; i++)
    {
        Ivar ivar = vars[i];
        const char *cVarName = ivar_getName(ivar);
        propertyName = [[NSString alloc] initWithCString:cVarName encoding:NSUTF8StringEncoding];
        NSString *instanceVar = [NSString stringWithFormat:@"_%@",ivarName];
        if([propertyName compare:ivarName] == 0 || [propertyName compare:instanceVar] == 0)
        {
            break;
        }
        else
        {
            propertyName = nil;
        }
    }
    id resultid = nil;
    if(propertyName)
    {
        resultid = [aTarget valueForKey:propertyName];
    }
    return resultid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)setSwipeBackEnable:(BOOL)enable {
    _swipeBackEnable = enable;
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = enable;
        self.swipper.panRecognizer.enabled = enable;
    }
}


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [viewController viewWillAppear:animated];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
