//
//  RKSPManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RKSPManager.h"
#import "NetManager.h"
#import "RKSPMode.h"
@interface RKSPManager()
{
    int stockSrlCurrentPage;
    NSString *strStartTime;
    NSString *strEndTime;
    NSString *strSupId;
}
@end
@implementation RKSPManager
- (void)appGetProductStockSrl:(int)selId finishBlock:(void(^)(RKSPModeListList *llist))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:[NSNumber numberWithInt:selId] forKey:@"sid"];
    [dict setValue:[NSNumber numberWithInt:stockSrlCurrentPage] forKey:@"pageNo"];
    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
    [dict setValue:@"1" forKey:@"needPage"];
    if(strStartTime)
    {
        [dict setValue:strStartTime forKey:@"BeginDate"];
    }
    if(strEndTime)
    {
        [dict setValue:strEndTime forKey:@"EndDate"];
    }
    if(strSupId)
    {
        [dict setValue:strSupId forKey:@"supId"];
    }
    [NetManager requestWith:dict apiName:@"appGetProductStockSrl" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            RKSPModeListList *llist = [[RKSPModeListList alloc] init];
            [llist unPacketData:dict];
            aFinishBlock(llist);
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        {
            aFinishBlock(nil);
        }
    }];
}

//获取入库单详情
- (void)appGetProductStockDetail:(NSString *)aProductId status:(NSString *)aStatus
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:aProductId forKey:@"sid"];
    [dict setValue:[NSNumber numberWithInt:0] forKey:@"pageNo"];
    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
    [dict setValue:@"0" forKey:@"needPage"];
    [dict setValue:aStatus forKey:@"status"];
    [NetManager requestWith:dict apiName:@"appGetProductStockDetail" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}
#pragma mark 设置筛选数据
- (void)setStartTime:(NSString *)aStartTime
{
    strStartTime = aStartTime;
}

- (void)setEndTime:(NSString *)aEndTime
{
    strEndTime = aEndTime;
}

- (void)setSupIdTime:(NSString *)aSupId
{
    strSupId = aSupId;
}
@end
