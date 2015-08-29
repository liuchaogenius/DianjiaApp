//
//  BaseViewController.h
//  FW_Project
//
//  Created by  striveliu on 13-10-3.
//  Copyright (c) 2013年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreListView.h"
#import "LoginMode.h"
#import "LoginManager.h"
#import "SVProgressHUD.h"
@interface BaseViewController : UIViewController

@property (nonatomic, assign) CGFloat g_OffsetY;
@property (nonatomic, strong) UIImage *backgroundimg;
@property (nonatomic ,strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *storeListBT;
@property (nonatomic, strong) StoreListView *sview;

- (void)setLeftButton:(UIImage *)aImg
                title:(NSString *)aTitle
               target:(id)aTarget
               action:(SEL)aSelector;
- (void)setRightButton:(UIImage *)aImg
                 title:(NSString *)aTitle
                target:(id)aTarget
                action:(SEL)aSelector;
- (void)settitleLabel:(NSString*)aTitle;
- (void)pushView:(UIView*)aView;
- (UIViewController*)pushVCName:(NSString *)aVCName
          animated:(BOOL)animated
          selector:(NSString *)aSelecotorName
             param:(id)aParam, ...;
- (UIViewController*)pushXIBName:(NSString *)aXIBName
           animated:(BOOL)animated
           selector:(NSString *)aSelecotorName
              param:(id)aParam, ...;
- (void)popView:(UIView*)aView completeBlock:(void(^)(BOOL isComplete))aCompleteblock;

- (void)showSelectStoreButton;
/**
 *  需要显示店铺列表的需要重写这个方法
 */
- (void)obserStoreviewResult;
@end
