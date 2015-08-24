//
//  KCYJManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "KCYJManager.h"
#import "NetManager.h"
@interface KCYJManager()
{
    int currentPage;
}
@end
@implementation KCYJManager
- (void)getStockWarningDetailPageApp:(BOOL)isRefresh storeId:(NSString *)aStoreId
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aStoreId)
    {
        [dict setValue:aStoreId forKey:@"sid"];
        [dict setValue:[NSNumber numberWithInt:currentPage] forKey:@"pageNo"];
        [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
        [dict setValue:@"1" forKey:@"needPage"];
    }
    [NetManager requestWith:dict apiName:@"getStockWarningDetailPageApp" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}
@end
