//
//  ViewInteraction.h
//  YOChangeWord
//
//  Created by  striveliu on 14-9-2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewInteraction : NSObject

+ (void)viewPresentAnimationFromBottom:(UIView*)aFromView
                                toView:(UIView*)aToView;
+ (void)viewDissmissAnimationToBottom:(UIView*)aToView
                        completeBlock:(void(^)(BOOL isComplete))aCompleteblock;

+ (void)viewPresentAnimationFromRight:(UIView*)aFromView
                               toView:(UIView*)aToView;

+ (void)viewDissmissAnimationToRight:(UIView*)aToView
                            isRemove:(BOOL)aIsRemove
                       completeBlock:(void(^)(BOOL isComplete))aCompleteblock;

+ (void)viewPresentAnimationFromLeft:(UIView*)aFromView
                              toView:(UIView*)aToView;

+ (void)viewDissmissAnimationToLeft:(UIView*)aToView
                           isRemove:(BOOL)aIsRemove
                      completeBlock:(void(^)(BOOL isComplete))aCompleteblock;

+ (void)viewPushViewcontroller:(UIViewController*)aViewcontroller;



@end
