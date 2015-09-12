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
 *  成功扫描出了信息 或者用户手动收入了一串信息
 *
 *  @param message 扫描出的信息或输入的信息
 *
 */
- (void)scanController:(UIViewController *)vc didScanedAndTransToMessage: (NSString *)message;


@end

@interface DJScanViewController : BaseViewController

@property (nonatomic, weak) id<DJScanDelegate> delegate;

- (BOOL)startReading;

@end
