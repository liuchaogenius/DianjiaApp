//
//  DJProductCheckViewManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJProductCheckVC.h"
#import "DJCheckCartItemComponent.h"

@interface DJProductCheckViewManager : NSObject

+ (instancetype)sharedInstance;

//@property (nonatomic, weak) id<DJProductCheckViewDataSoure> delegate;

- (void)showCheckViewFromViewController: (UIViewController *)vc
                         withDataSource: (id<DJProductCheckViewDataSoure>)dataSource;


@end
