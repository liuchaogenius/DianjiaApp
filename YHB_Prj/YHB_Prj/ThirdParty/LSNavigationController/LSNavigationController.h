//
//  LSNavigationController.h
//  Hubanghu
//
//  Created by  striveliu on 14-11-11.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSNavigationController : UINavigationController<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
/**
* 滑动返回是否可用
*/
@property (nonatomic) BOOL swipeBackEnable;

-(void)setSwipeBackEnable:(BOOL)enable;

- (void)pushVCName:(NSString *)aVCName
          animated:(BOOL)animated
          selector:(NSString *)aSelecotorName
             param:(id)aParam, ...;

- (void)pushXIBName:(NSString *)aXIBName
           animated:(BOOL)animated
           selector:(NSString *)aSelecotorName
              param:(id)aParam, ...;
@end
