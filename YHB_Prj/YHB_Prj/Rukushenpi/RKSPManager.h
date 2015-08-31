//
//  RKSPManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RKSPModeListList;
@interface RKSPManager : NSObject

- (void)appGetProductStockSrl:(int)selId finishBlock:(void(^)(RKSPModeListList *llist))aFinishBlock;
- (void)setStartTime:(NSString *)aStartTime;

- (void)setEndTime:(NSString *)aEndTime;

- (void)setSupIdTime:(NSString *)aSupId;

- (void)appGetProductStockDetail:(NSString *)aProductId status:(NSString *)aStatus;
@end
