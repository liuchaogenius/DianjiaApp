//
//  ViewInteraction.m
//  YOChangeWord
//
//  Created by  striveliu on 14-9-2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "ViewInteraction.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "UIImage+ImageEffects.h"

@implementation ViewInteraction

+ (void)viewPushViewcontroller:(UIViewController*)aViewcontroller
{
//    AppDelegate *del = [UIApplication sharedApplication].delegate;
//    UINavigationController *currentNav = del.rootvc;
//    [currentNav pushViewController:aViewcontroller animated:YES];
}

+ (void)viewPresentAnimationFromBottom:(UIView*)aFromView
                                toView:(UIView*)aToView
{

    AppDelegate *del = [UIApplication sharedApplication].delegate;
    UIWindow *window = del.window;
    CGRect endRect = CGRectMake(0, 0, window.width, window.height);
    CGRect startRect = CGRectMake(0,
                           CGRectGetHeight(aFromView.frame),
                           CGRectGetWidth(aFromView.bounds),
                           CGRectGetHeight(aFromView.bounds));
    
    CGPoint transformedPoint = CGPointApplyAffineTransform(startRect.origin, aToView.transform);
    aToView.frame = CGRectMake(transformedPoint.x, transformedPoint.y, startRect.size.width, startRect.size.height);
    
    [window addSubview:aToView];
    [UIView animateWithDuration:0.2 animations:^{
        window.rootViewController.view.transform = CGAffineTransformScale(window.rootViewController.view.transform, 0.8, 0.8);
        
        aToView.frame = CGRectMake(0,0,
                                             CGRectGetWidth(endRect),
                                             CGRectGetHeight(endRect));
        
    } completion:^(BOOL finished) {
        aToView.frame = endRect;
        
    }];
    
}

+ (void)viewDissmissAnimationToBottom:(UIView*)aToView
                        completeBlock:(void(^)(BOOL isComplete))aCompleteblock
{
    CGRect endRect = CGRectMake(0,
                                CGRectGetHeight(aToView.frame),
                                CGRectGetWidth(aToView.bounds),
                                CGRectGetHeight(aToView.bounds));
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    UINavigationController *navRoot = (UINavigationController *)del.window.rootViewController;
    [UIView animateWithDuration:0.2 animations:^{
        navRoot.view.transform = CGAffineTransformIdentity;
        aToView.frame = endRect;
    } completion:^(BOOL finished) {
        aCompleteblock(finished);
    }];
}


+ (void)viewPresentAnimationFromRight:(UIView*)aFromView
                                toView:(UIView*)aToView
{
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    UIWindow *window = del.window;
    CGRect endRect = CGRectMake(0, 0, window.width, window.height);
    CGRect startRect = CGRectMake(CGRectGetWidth(aFromView.frame),
                                  0,
                                  CGRectGetWidth(aFromView.bounds),
                                  CGRectGetHeight(aFromView.bounds));
    
    CGPoint transformedPoint = CGPointApplyAffineTransform(startRect.origin, aToView.transform);
    aToView.frame = CGRectMake(transformedPoint.x, transformedPoint.y, startRect.size.width, startRect.size.height);
    
    [window addSubview:aToView];
    [UIView animateWithDuration:0.2 animations:^{
        window.rootViewController.view.transform = CGAffineTransformScale(window.rootViewController.view.transform, 0.8, 0.8);
        
        aToView.frame = CGRectMake(0,0,
                                   CGRectGetWidth(endRect),
                                   CGRectGetHeight(endRect));
        
    } completion:^(BOOL finished) {
        aToView.frame = endRect;
        
    }];
    
}

+ (void)viewDissmissAnimationToRight:(UIView*)aToView
                            isRemove:(BOOL)aIsRemove
                       completeBlock:(void(^)(BOOL isComplete))aCompleteblock
{
    CGRect endRect = CGRectMake(CGRectGetWidth(aToView.frame),
                                0,
                                CGRectGetWidth(aToView.bounds),
                                CGRectGetHeight(aToView.bounds));
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    UINavigationController *navRoot = (UINavigationController *)del.window.rootViewController;
    [UIView animateWithDuration:0.2 animations:^{
        navRoot.view.transform = CGAffineTransformIdentity;
        aToView.frame = endRect;
    } completion:^(BOOL finished) {
        if(aIsRemove)
        {
            [aToView removeFromSuperview];
        }
        aCompleteblock(finished);
    }];
}

+ (void)viewPresentAnimationFromLeft:(UIView*)aFromView
                               toView:(UIView*)aToView
{
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    UIWindow *window = del.window;
    UIImage *bgImg = [ViewInteraction screenshotMH:window];
    bgImg = [bgImg applyDarkEffect];
    aToView.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    CGRect endRect = CGRectMake(0, 0, window.width, window.height);
    CGRect startRect = CGRectMake(-CGRectGetWidth(aFromView.frame),
                                  0,
                                  CGRectGetWidth(aFromView.bounds),
                                  CGRectGetHeight(aFromView.bounds));
    
    CGPoint transformedPoint = CGPointApplyAffineTransform(startRect.origin, aToView.transform);
    aToView.frame = CGRectMake(transformedPoint.x, transformedPoint.y, startRect.size.width, startRect.size.height);
    
    [window addSubview:aToView];
    [UIView animateWithDuration:0.2 animations:^{
        //window.rootViewController.view.transform = CGAffineTransformScale(window.rootViewController.view.transform, 0.8, 0.8);
        
        aToView.frame = CGRectMake(0,0,
                                   CGRectGetWidth(endRect),
                                   CGRectGetHeight(endRect));
        
    } completion:^(BOOL finished) {
        aToView.frame = endRect;
        
    }];
    
}

+ (void)viewDissmissAnimationToLeft:(UIView*)aToView
                           isRemove:(BOOL)aIsRemove
                      completeBlock:(void(^)(BOOL isComplete))aCompleteblock
{
    CGRect endRect = CGRectMake(-CGRectGetWidth(aToView.frame),
                                0,
                                CGRectGetWidth(aToView.bounds),
                                CGRectGetHeight(aToView.bounds));

   // UINavigationController *navRoot = (UINavigationController *)del.window.rootViewController;
    [UIView animateWithDuration:0.2 animations:^{
        //navRoot.view.transform = CGAffineTransformIdentity;
        aToView.frame = endRect;
    } completion:^(BOOL finished) {
        if(aIsRemove)
        {
            [aToView removeFromSuperview];
        }
        aCompleteblock(finished);
    }];
}

+ (UIImage *)screenshotMH:(UIView *)aView
{
    UIImage *img = nil;
    if(aView)
    {
        UIGraphicsBeginImageContextWithOptions(aView.bounds.size, NO, [UIScreen mainScreen].scale);
        if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [aView drawViewHierarchyInRect:aView.bounds afterScreenUpdates:YES];
        } else {
            [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return img;
}

@end
