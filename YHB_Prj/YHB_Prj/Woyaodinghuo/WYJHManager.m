//
//  WYJHManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHManager.h"
#import "NetManager.h"
#import "SVProgressHUD.h"

@interface WYJHManager()
{
    int stockSrlCurrentPage_1;
    int stockSrlCurrentPage_2;
    int stockSrlCurrentPage__1;
    NSString *strStartTime;
    NSString *strEndTime;
    NSString *strSupId;
    NSString *strAccountType;
}
@end

@implementation WYJHManager
- (void)appGetStorageSrl:(int)selId finishBlock:(void(^)(WYJHModeRows *llist))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dict setValue:[NSNumber numberWithInt:selId] forKey:@"sid"];
    if(selId == 1)
    {
        [dict setValue:[NSNumber numberWithInt:stockSrlCurrentPage_1] forKey:@"pageNo"];
    }
    else if(selId == 2)
    {
        [dict setValue:@0 forKey:@"status"];
        [dict setValue:[NSNumber numberWithInt:stockSrlCurrentPage_2] forKey:@"pageNo"];
    }
    else if(selId == 0)
    {
        [dict setValue:@1 forKey:@"status"];
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
    if(strAccountType)
    {
        [dict setValue:strAccountType forKey:@"accountType"];
    }
    [SVProgressHUD showWithStatus:kLoadingText cover:NO offsetY:64];
    [NetManager requestWith:dict apiName:@"appGetStorageSrl" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        [SVProgressHUD dismiss];
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            NSArray *arry =[dict objectForKey:@"rows"];
            if(arry && arry.count>0)
            {
                WYJHModeRows *llist = [[WYJHModeRows alloc] init];
                [llist unPacketData:dict];
                aFinishBlock(llist);
                if(selId == 1)
                {
                    stockSrlCurrentPage_1++;
                }
                else if(selId == 2)
                {
                    stockSrlCurrentPage_2++;
                }
                else if(selId == -1)
                {
                    stockSrlCurrentPage__1++;
                }
            }
            else
            {
                aFinishBlock(nil);
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
- (void)clearePageNo
{
    stockSrlCurrentPage_1 = 0;
    stockSrlCurrentPage_2 = 0;
    stockSrlCurrentPage__1 = 0;
}
#pragma mark 结账进货
- (void)appAccountSupplierStorage:(NSString *)aId
                      finishBlock:(void(^)(BOOL ret))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:aId forKey:@"id"];
    [NetManager requestWith:dict apiName:@"appAccountSupplierStorage" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

#pragma mark 收货
- (void)appStorageStockSrl:(NSString *)aId
                      finishBlock:(void(^)(BOOL ret))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:aId forKey:@"id"];
    [NetManager requestWith:dict apiName:@"appStorageStockSrl" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

- (void)appDeleteSupplierStorageSrl:(NSString *)aId
                        finishBlock:(void(^)(BOOL ret))aFinishBlock

{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:aId forKey:@"id"];
    [NetManager requestWith:dict apiName:@"appDeleteSupplierStorageSrl" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}
#pragma mark 设置筛选数据
- (void)setAccountType:(int)aType //是否已结  1-未结 2-已结
{
    if(aType > 0)
    {
        strAccountType = [NSString stringWithFormat:@"%d",aType];
    }
}

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
