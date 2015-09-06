//
//  ProblemGoodsManager.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/6.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ProblemGoodsManager.h"
#import "NetManager.h"
#import "PGResult.h"

@interface ProblemGoodsManager()
{
    int _currentPage;
}

@end

@implementation ProblemGoodsManager

-(void)getProblemGoodsListWithFinishBlock:(void (^)(NSArray *))FBlock isRefresh:(BOOL)isRefresh
{
    if (isRefresh==YES) _currentPage=0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@20 forKey:@"pageSize"];
    [dict setValue:[NSNumber numberWithInt:_currentPage] forKey:@"pageNo"];
    [dict setValue:@"true" forKey:@"needPage"];
   

    [NetManager requestWith:dict apiName:@"getProblemProductList" method:@"POST" succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        NSString *str = successDict[@"message"];
        if ([str isEqualToString:@"success"])
        {
            NSDictionary *resultDict = successDict[@"result"];
            PGResult *result = [PGResult modelObjectWithDictionary:resultDict];
            _currentPage++;
            FBlock(result.rows);
        }
        else
        {
            FBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        FBlock(nil);
    }];
}

@end
