//
//  SupplierViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
@class SupplierMode;
@interface SupplierViewController : BaseViewController

- (instancetype)initWithSelectBlock:(void(^)(SupplierMode *mode))aBlock;

@end
