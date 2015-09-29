//
//  RKSPManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RKSPModeListList;
typedef NS_ENUM(NSInteger, rukuDataType) {
    enum_weishenhe=1,
    enum_yishenhe=2,
    enum_all=-1,
};
@interface RKSPManager : NSObject

- (void)appGetProductStockSrl:(int)selId finishBlock:(void(^)(RKSPModeListList *llist))aFinishBlock;

- (void)resetPage;

- (void)setStartTime:(NSString *)aStartTime;

- (void)setEndTime:(NSString *)aEndTime;

- (void)setSupIdTime:(NSString *)aSupId;

- (void)appGetProductStockDetail:(NSString *)aProductId status:(NSString *)aStatus;
@end
