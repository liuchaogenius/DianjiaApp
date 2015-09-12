//
//  DJInputCodeViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^successInputHandler)(NSString *codeStr);

@interface DJInputCodeViewController : BaseViewController

@property (nonatomic, copy) successInputHandler sHandler;

@end
