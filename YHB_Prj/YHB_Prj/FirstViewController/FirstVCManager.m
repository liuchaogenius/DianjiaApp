//
//  FirstVCManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "FirstVCManager.h"
#import "NetManager.h"


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
@end
