//
//  SupplierDetailViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
@class SupplierMode;

@interface SupplierDetailViewController : BaseViewController

- (instancetype)initWithSupplierMode:(SupplierMode *)aMode withDeleteBlock:(void(^)(void))aDeleteBlock withChangeBlock:(void(^)(SupplierMode *aMode))aChangeBlock;

@end
