//
//  SPGLManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLManager.h"
#import "NetManager.h"

@implementation SPGLManager
- (void)getAllProductCls:(void(^)(SPGLCategoryIndexList *list))aFinishBlock
{
    [NetManager requestWith:nil apiName:@"getAllProductCls" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSArray *aryy = [successDict objectForKey:@"result"];
        if(aryy && aryy.count > 0)
        {
            SPGLCategoryIndexList *list = [[SPGLCategoryIndexList alloc] init];
            [list unPacketData:aryy];
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

- (void)getProductListByClsApp:(NSString*)aId
                   finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aId)
    {
        [dict setValue:aId forKey:@"queryCid"];
        [dict setValue:[NSNumber numberWithInt:0] forKey:@"pageNo"];
        [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
        [dict setValue:@"false" forKey:@"needPage"];
    }
    [NetManager requestWith:dict apiName:@"getProductListByClsApp" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if([successDict objectForKey:@"result"])
        {
            SPGLProductList *list = [[SPGLProductList alloc] init];
            [list unPacketData:[successDict objectForKey:@"result"]];
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

- (void)getProductListByKeywordApp:(NSString*)aKeyword
                   finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aKeyword)
    {
        [dict setValue:aKeyword forKey:@"queryName"];
        [dict setValue:[NSNumber numberWithInt:0] forKey:@"pageNo"];
        [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
        [dict setValue:@"false" forKey:@"needPage"];
    }
    [NetManager requestWith:dict apiName:@"getProductListByKeywordApp" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if([successDict objectForKey:@"result"])
        {
            SPGLProductList *list = [[SPGLProductList alloc] init];
            [list unPacketData:[successDict objectForKey:@"result"]];
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

- (void)getProductListByCodeApp:(NSString*)aKeyword
                       finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aKeyword)
    {
        [dict setValue:aKeyword forKey:@"queryName"];
        [dict setValue:[NSNumber numberWithInt:0] forKey:@"pageNo"];
        [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
        [dict setValue:@"false" forKey:@"needPage"];
    }
    [NetManager requestWith:dict apiName:@"getProductListByCodeApp" method:@"post" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if([successDict objectForKey:@"result"])
        {
            SPGLProductList *list = [[SPGLProductList alloc] init];
            [list unPacketData:[successDict objectForKey:@"result"]];
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
