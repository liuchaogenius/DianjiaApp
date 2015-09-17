//
//  DateSelectVC.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface DateSelectVC : BaseViewController
- (void)getUserSetTimer:(void(^)(NSString *sTimer, NSString *eTimer,NSString *ssTimer,NSString *seTimer, int btid))aBlock;
@end
