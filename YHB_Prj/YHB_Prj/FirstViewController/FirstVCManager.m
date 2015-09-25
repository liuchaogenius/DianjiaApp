//
//  FirstVCManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "FirstVCManager.h"
#import "NetManager.h"
#import "LSMode.h"
#import "LSDetailMode.h"

@interface FirstVCManager()
{
    NSString *strStartTime;
    NSString *strEndTime;
}
@end

@implementation FirstVCManager

+ (FirstVCManager *)shareFirstVCManager
{
    static FirstVCManager *fm = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        fm = [[FirstVCManager alloc] init];
    });
    return fm;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.fMode = [[FirstMode alloc] init];
    }
    return self;
}

//1、	首页营业流水信息
- (void)getSaleSrlStatisticsApp:(NSString *)aStartDate
                        endDate:(NSString *)aEndDate
                    finishBlock:(void(^)(FirstMode *mode))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aStartDate)
    {
        [dict setValue:aStartDate forKey:@"startDate"];
    }
    if(aEndDate)
    {
        [dict setValue:aEndDate forKey:@"endDate"];
    }
    
    [NetManager requestWith:dict apiName:@"getSaleSrlStatisticsApp" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            [self.fMode.ssMode unPacketData:dict];
            aFinishBlock(self.fMode);
        }
        else
            aFinishBlock(nil);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}
//2、	首页库存查询
- (void)getSummaryStoreStock:(NSString *)aStoreId
                 finishBlock:(void(^)(FirstMode *mode))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aStoreId)
    {
        [dict setValue:aStoreId forKey:@"sid"];
    }
    
    [NetManager requestWith:dict apiName:@"getSummaryStoreStock" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            [self.fMode.sumMode unPacketData:dict];
            aFinishBlock(self.fMode);
        }
        else
            aFinishBlock(nil);
    } failure:^(NSDictionary *failDict, NSError *error) {
         aFinishBlock(nil);
    }];
}

//3、	首页预警数字查询
- (void)getHomePageInfoApp:(NSString *)aStoreId
               finishBlock:(void(^)(FirstMode *mode))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aStoreId)
    {
        [dict setValue:aStoreId forKey:@"sid"];
    }
    
    [NetManager requestWith:dict apiName:@"getHomePageInfoApp" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            [self.fMode.homeInfoMode unPacketData:dict];
            aFinishBlock(self.fMode);
        }
        else
            aFinishBlock(nil);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}

- (void)setStartTime:(NSString *)aStartTime
{
    strStartTime = aStartTime;
}

- (void)setEndTime:(NSString *)aEndTime
{
    strEndTime = aEndTime;
}
//获取销售流水
-(void)getSaleSrlPageApp:(void(^)(LSModeList *list))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(strStartTime)
    {
        [dict setValue:strStartTime forKey:@"startDate"];
    }
    else
    {
        [dict setValue:@"0" forKey:@"startDate"];
    }
    if(strEndTime)
    {
        [dict setValue:strEndTime forKey:@"endDate"];
    }
    [dict setValue:@"false" forKey:@"needPage"];
    [dict setValue:[NSNumber numberWithInt:0] forKey:@"pageNo"];
    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
    
    [NetManager requestWith:dict apiName:@"getSaleSrlPageApp" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSDictionary *resultDict = [successDict objectForKey:@"result"];
        if(resultDict)
        {
            LSModeList *mlist = [[LSModeList alloc] init];
            [mlist unPacketModeData:resultDict];
            aFinishBlock(mlist);
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}

//查询销售明细
- (void)getSaleSrlDetailByApp:(NSString *)aSaleId block:(void(^)(LSDetailModeList *list))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aSaleId)
    {
        [dict setValue:aSaleId forKey:@"saleId"];
    }
    [NetManager requestWith:dict apiName:@"getSaleSrlDetailByApp" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if(successDict && [successDict objectForKey:@"result"])
        {
            LSDetailModeList *dModeList = [[LSDetailModeList alloc] init];
            [dModeList unPacketData:successDict];
            aFinishBlock(dModeList);
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}
@end
