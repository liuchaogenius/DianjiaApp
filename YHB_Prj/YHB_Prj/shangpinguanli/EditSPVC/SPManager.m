//
//  SPManager.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPManager.h"
#import "NetManager.h"
#import "JHLSMode.h"
#import "XSLSMode.h"

@implementation SPManager

- (void)saveOrUpdateDict:(NSDictionary *)aDict finishBlock:(void (^)(NSString *))FBlock;
{
    [NetManager requestWith:aDict apiName:@"saveOrUpdateProduct" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *code = successDict[@"RErrorInfo"];
        MLOG(@"%@", code);
    } failure:^(NSDictionary *failDict, NSError *error) {
        FBlock(nil);
    }];
}

@end

@interface JHLSManager()
{
    int currentPage;
}
@end

@implementation JHLSManager

- (void)appGetProductStockDetail:(NSString *)aProductId finishBlock:(void (^)(NSArray *))FBlock isRefresh:(BOOL)aBool
{
    if (aBool) currentPage=0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:aProductId forKey:@"productId"];
    [dict setObject:@0 forKey:@"status"];
    [dict setObject:@-1 forKey:@"orderFrom"];
    [dict setObject:@(currentPage) forKey:@"pageNo"];
    [dict setObject:@20 forKey:@"pageSize"];
    [dict setObject:@"true" forKey:@"needPage"];
    [NetManager requestWith:dict apiName:@"appGetProductStockDetail" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *code = successDict[@"msg"];
        if ([code isEqualToString:@"success"] && code)
        {
            NSDictionary *dictResult = successDict[@"result"];
            JHLSList *list = [[JHLSList alloc] init];
            [list unPacketData:dictResult];
            FBlock(list.productList);
        }
        else FBlock(nil);
    } failure:^(NSDictionary *failDict, NSError *error) {
        FBlock(nil);
    }];
}

@end

@interface XSLSManager()
{
    int currentPage;
}
@end

@implementation XSLSManager

- (void)getSaleHisByProductIdApp:(NSString *)aProductId finishBlock:(void (^)(NSArray *))FBlock isRefresh:(BOOL)aBool
{
    if (aBool) currentPage=0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:aProductId forKey:@"product_id"];
    [dict setObject:@(currentPage) forKey:@"pageNo"];
    [dict setObject:@20 forKey:@"pageSize"];
    [dict setObject:@"true" forKey:@"needPage"];
    [NetManager requestWith:dict apiName:@"getSaleHisByProductIdApp" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *code = successDict[@"msg"];
        MLOG(@"%@", successDict[@"RErrorInfo"]);
        if ([code isEqualToString:@"success"] && code)
        {
            NSDictionary *dictResult = successDict[@"result"];
            XSLSList *list = [[XSLSList alloc] init];
            [list unPacketData:dictResult];
            FBlock(list.productList);
        }
        else FBlock(nil);
    } failure:^(NSDictionary *failDict, NSError *error) {
        FBlock(nil);
    }];

}

@end
