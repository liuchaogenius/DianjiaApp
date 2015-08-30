//
//  DJProductCheckViewManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckViewManager.h"
#import "DJStoryboadManager.h"
#import "DJProductCheckVC.h"
#import <objc/runtime.h>

static void *const kVCKey;

@implementation DJProductCheckViewManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)showCheckViewFromViewController:(UIViewController *)fromVC {
    DJProductCheckVC *vc = (DJProductCheckVC *)[[DJStoryboadManager sharedInstance] viewControllerWithName:@"DJProductCheckVC"];
    vc.view.layer.cornerRadius = 5.;
    vc.view.frame = CGRectMake(20., 30, kMainScreenWidth-40., 360);
    [fromVC.view addSubview:[self dimViewWithViewController:vc]];
    [fromVC.view addSubview:vc.view];
    [fromVC addChildViewController:vc];
}


- (UIView *)dimViewWithViewController: (UIViewController *)vc {
    UIView *dimView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    dimView.backgroundColor = [UIColor blackColor];
    dimView.alpha = 0.7;
    [dimView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)]];
    dispatch_block_t handler= ^(){
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    };
    objc_setAssociatedObject(dimView, &kVCKey, [handler copy], OBJC_ASSOCIATION_COPY);
    
    return dimView;
}

- (void)dismiss: (UIGestureRecognizer *)gr {
    dispatch_block_t handler = objc_getAssociatedObject(gr.view, &kVCKey);
    if (handler) {
        handler();
    }
    [gr.view removeFromSuperview];
}

@end
