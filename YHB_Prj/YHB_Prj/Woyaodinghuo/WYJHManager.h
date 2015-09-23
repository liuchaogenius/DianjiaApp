//
//  WYJHManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYJHMode.h"

@interface WYJHManager : NSObject
- (void)appGetStorageSrl:(int)selId finishBlock:(void(^)(WYJHModeRows *llist))aFinishBlock;
- (void)setAccountType:(int)aType; //是否已结  1-未结 2-已结
- (void)setStartTime:(NSString *)aStartTime;
- (void)clearePageNo;
- (void)setEndTime:(NSString *)aEndTime;
- (void)setSupIdTime:(NSString *)aSupId;
- (void)appAccountSupplierStorage:(NSString *)aId //结清
                      finishBlock:(void(^)(BOOL ret))aFinishBlock;
- (void)appStorageStockSrl:(NSString *)aId
               finishBlock:(void(^)(BOOL ret))aFinishBlock;

- (void)appDeleteSupplierStorageSrl:(NSString *)aId //删除
                        finishBlock:(void(^)(BOOL ret))aFinishBlock;
@end
