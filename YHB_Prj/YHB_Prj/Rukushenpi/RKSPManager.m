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
#import "SVProgressHUD.h"

@interface RKSPManager()
{
    int stockSrlCurrentPage_1;
    int stockSrlCurrentPage_2;
    int stockSrlCurrentPage__1;
    NSString *strStartTime;
    NSString *strEndTime;
    NSString *strSupId;
}
@end
@implementation RKSPManager
- (void)appGetProductStockSrl:(int)selId finishBlock:(void(^)(RKSPModeListList *llist))aFinishBlock
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:[NSNumber numberWithInt:selId] forKey:@"status"];
    if(selId == enum_weishenhe)
    {
        [dict setValue:[NSNumber numberWithInt:stockSrlCurrentPage_1] forKey:@"pageNo"];
    }
    else if(selId == enum_yishenhe)
    {
        [dict setValue:[NSNumber numberWithInt:stockSrlCurrentPage_2] forKey:@"pageNo"];
    }
    else if(selId == enum_all)
    {
        [dict setValue:[NSNumber numberWithInt:stockSrlCurrentPage__1] forKey:@"pageNo"];
    }
    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
    [dict setValue:@"false" forKey:@"needPage"];
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
    [SVProgressHUD showWithStatus:kLoadingText cover:NO offsetY:64];
    [NetManager requestWith:dict apiName:@"appGetProductStockSrl" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        [SVProgressHUD dismiss];
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict && [dict objectForKey:@"rows"])
        {
            RKSPModeListList *llist = [[RKSPModeListList alloc] init];
            [llist unPacketData:dict];
            aFinishBlock(llist);
            if(selId == enum_weishenhe)
            {
                stockSrlCurrentPage_1++;
            }
            else if(selId == enum_yishenhe)
            {
                stockSrlCurrentPage_2++;
            }
            else if(selId == enum_all)
            {
                stockSrlCurrentPage__1++;
            }
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        {
            [SVProgressHUD dismiss];
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
    [dict setValue:@"false" forKey:@"needPage"];
    [dict setValue:aStatus forKey:@"status"];
    [SVProgressHUD showWithStatus:kLoadingText cover:NO offsetY:64];
    [NetManager requestWith:dict apiName:@"appGetProductStockDetail" method:@"post" succ:^(NSDictionary *successDict) {
        [SVProgressHUD dismiss];
        MLOG(@"%@",successDict);
    } failure:^(NSDictionary *failDict, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)resetPage
{
    stockSrlCurrentPage_1 = 0;

    stockSrlCurrentPage_2 = 0;

    stockSrlCurrentPage__1 = 0;
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
