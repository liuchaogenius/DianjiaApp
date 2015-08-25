//
//  KCYJManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KCYJListMode;
@class StoreTockList;
@interface KCYJManager : NSObject
- (void)getStockWarningDetailPageApp:(BOOL)isRefresh storeId:(NSString *)aStoreId finishBlock:(void(^)(KCYJListMode *modelist))aFinishBlock;
/**
 *  滞销预警
 *
 *  @param isRefresh
 *  @param aStoreId
 *  @param aFinishBlock
 */
- (void)getSalekWarningDetailPageApp:(BOOL)isRefresh storeId:(NSString *)aStoreId finishBlock:(void(^)(KCYJListMode *modelist))aFinishBlock;

- (void)getStoreStockByStoreCount:(void(^)(StoreTockList *modelist))aFinishBlock;
@end
