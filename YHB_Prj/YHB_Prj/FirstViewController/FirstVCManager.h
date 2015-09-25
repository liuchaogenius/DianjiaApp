//
//  FirstVCManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstMode.h"
@class LSModeList;
@class LSDetailModeList;

@interface FirstVCManager : NSObject
@property (nonatomic, strong) FirstMode *fMode;
+ (FirstVCManager *)shareFirstVCManager;

//1、	首页营业流水信息
- (void)getSaleSrlStatisticsApp:(NSString *)aStartDate endDate:(NSString *)aEndDate
                    finishBlock:(void(^)(FirstMode *mode))aFinishBlock;

//2、	首页库存查询
- (void)getSummaryStoreStock:(NSString *)aStoreId
                 finishBlock:(void(^)(FirstMode *mode))aFinishBlock;

//3、	首页预警数字查询
- (void)getHomePageInfoApp:(NSString *)aStoreId
               finishBlock:(void(^)(FirstMode *mode))aFinishBlock;

- (void)setStartTime:(NSString *)aStartTime;

- (void)setEndTime:(NSString *)aEndTime;

-(void)getSaleSrlPageApp:(void(^)(LSModeList *list))aFinishBlock;

- (void)getSaleSrlDetailByApp:(NSString *)aSaleId block:(void(^)(LSDetailModeList *list))aFinishBlock;
@end
