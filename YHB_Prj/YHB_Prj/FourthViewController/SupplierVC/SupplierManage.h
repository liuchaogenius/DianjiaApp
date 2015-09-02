//
//  SupplierManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/1.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SupplierMode;
@interface SupplierManage : NSObject

- (void)getSupplierListWithFinishBlock:(void (^)(NSArray *resultArr))aBlock;
- (void)changeSupplier:(SupplierMode *)amode withFinishBlock:(void(^)(NSString *aCode))FBlock;
- (void)deleteSupplier:(NSString *)aStrid withFinishBlock:(void(^)(NSString *aCode))FBlock;
@end
