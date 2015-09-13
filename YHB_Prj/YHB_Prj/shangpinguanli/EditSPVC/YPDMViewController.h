//
//  YPDMViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
@class SPGLProductMode;
@interface YPDMViewController : BaseViewController

- (instancetype)initWithProductMode:(SPGLProductMode *)aMode changeBlock:(void(^)(SPGLProductMode *))aChangeBlcok;

@end
