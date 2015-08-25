//
//  KCYJManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "KCYJManager.h"
#import "NetManager.h"
#import "KCYJMode.h"

@interface KCYJManager()
{
    int currentPage;
    int saleWarningCurrentPage;
    KCYJListMode *kcyjModeList;
}
@end
@implementation KCYJManager

- (instancetype)init
{
    if(self = [super init]){
        kcyjModeList = [[KCYJListMode alloc] init];
    }
    return self;
}

- (void)getStockWarningDetailPageApp:(BOOL)isRefresh storeId:(NSString *)aStoreId finishBlock:(void(^)(KCYJListMode *modelist))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aStoreId)
    {
        [dict setValue:aStoreId forKey:@"sid"];
        [dict setValue:[NSNumber numberWithInt:currentPage] forKey:@"pageNo"];
        [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
        [dict setValue:@"1" forKey:@"needPage"];
    }
    if(isRefresh)
    {
        [kcyjModeList.kcyjModeArry removeAllObjects];
    }
    [NetManager requestWith:dict apiName:@"getStockWarningDetailPageApp" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if(successDict)
        {
            NSDictionary *resutlDict = [successDict objectForKey:@"result"];
            [kcyjModeList unPacketData:resutlDict];
            aFinishBlock(kcyjModeList);
            currentPage++;
        }
        else
        {
            aFinishBlock(nil);
        }
        
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}


- (void)getSalekWarningDetailPageApp:(BOOL)isRefresh storeId:(NSString *)aStoreId finishBlock:(void(^)(KCYJListMode *modelist))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aStoreId)
    {
        [dict setValue:aStoreId forKey:@"sid"];
        [dict setValue:[NSNumber numberWithInt:saleWarningCurrentPage] forKey:@"pageNo"];
        [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
        [dict setValue:@"1" forKey:@"needPage"];
    }
    if(isRefresh)
    {
        [kcyjModeList.kcyjModeArry removeAllObjects];
    }
    [NetManager requestWith:dict apiName:@"getSalekWarningDetailPageApp" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if(successDict)
        {
            NSDictionary *resutlDict = [successDict objectForKey:@"result"];
            [kcyjModeList unPacketData:resutlDict];
            aFinishBlock(kcyjModeList);
            currentPage++;
        }
        else
        {
            aFinishBlock(nil);
        }
        
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}

- (void)getStoreStockByStoreCount:(void(^)(StoreTockList *modelist))aFinishBlock
{
    [NetManager requestWith:nil apiName:@"getStoreStockByStoreCount" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSArray *dictArry = [successDict objectForKey:@"result"];
        if(dictArry && dictArry.count > 0)
        {
            StoreTockList *list = [[StoreTockList alloc] init];
            [list unPacketData:dictArry];
            aFinishBlock(list);
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
