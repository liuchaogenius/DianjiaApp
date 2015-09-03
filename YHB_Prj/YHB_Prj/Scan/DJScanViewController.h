//
//  DJScanViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@protocol DJScanDelegate<NSObject>

/**
 *  扫描出信息的徽标
 *
 *  @param message 扫描出的信息
 *
 */
- (void)scanController:(UIViewController *)vc didScanedAndTransToMessage: (NSString *)message;

/**
 *  用户点击了手工输入码
 */
- (void)needToInputNumberFromScanController:(UIViewController *)vc;

@end

@interface DJScanViewController : BaseViewController

@property (nonatomic, weak) id<DJScanDelegate> delegate;

- (BOOL)startReading;

@end
