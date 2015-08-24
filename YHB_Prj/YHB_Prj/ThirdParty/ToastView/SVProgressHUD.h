//
//  SVProgressHUD.h
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVProgressHUD
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

enum {
    SVProgressHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    SVProgressHUDMaskTypeClear, // don't allow
    SVProgressHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    SVProgressHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger SVProgressHUDMaskType;

@interface SVProgressHUD : UIView

//isCovernavr  是否覆盖navgationbar  如果需要遮盖 offsety 是要便宜的Y值即 navgationbar的高度
+ (void)show:(BOOL)isCoverNavbar offsetY:(int)offsetY;
+ (void)showWithStatus:(NSString*)status cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;

+ (void)showSuccessWithStatus:(NSString*)string cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;
+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;
+ (void)showErrorWithStatus:(NSString *)string cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;
+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration cover:(BOOL)isCoverNavbar offsetY:(int)offsetY;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

+ (void)dismiss; // simply dismiss the HUD with a fade+scale out animation
+ (void)dismissWithSuccess:(NSString*)successString; // also displays the success icon image
+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithError:(NSString*)errorString; // also displays the error icon image
+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds;

+ (BOOL)isVisible;

@end
