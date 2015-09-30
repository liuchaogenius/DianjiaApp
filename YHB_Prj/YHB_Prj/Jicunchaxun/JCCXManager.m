//
//  JCCXManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JCCXManager.h"
#import "NetManager.h"
#import "LoginManager.h"
#import "JCCXMode.h"
#import "JCCXDetailMode.h"
@interface JCCXManager()
{
    int currentPage_1;
    int currentPage_2;
    NSString *strVipId;
    NSString *strStartTime;
    NSString *strEndTime;
}
@end
@implementation JCCXManager

- (void)appGetProductStaySrl:(int)aStatus finishBlock:(void(^)(JCCXModeList *list))aFinishBlock //状态 1-未取完 2-已取完
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:[NSNumber numberWithInt:aStatus] forKey:@"status"];
    if(aStatus == 1)
    {
        [dict setValue:[NSNumber numberWithInt:currentPage_1] forKey:@"pageNo"];
    }
    else
    {
        [dict setValue:[NSNumber numberWithInt:currentPage_2] forKey:@"pageNo"];
    }
    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
    [dict setValue:@"false" forKey:@"needPage"]; //[NSNumber numberWithInt:0]
    if(strVipId)
    {
        [dict setValue:strVipId forKey:@"vipId"];
    }
    if(strStartTime)
    {
        [dict setValue:strStartTime forKey:@"BeginDate"];
    }
    if(strEndTime)
    {
        [dict setValue:strEndTime forKey:@"EndDate"];
    }
    [dict setObject:[[LoginManager shareLoginManager] getStoreId] forKey:@"sid"];
    [NetManager requestWith:dict apiName:@"getProductStaySrlApp" method:@"POST"
                       succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
                           if([successDict objectForKey:@"result"])
                           {
                               NSArray *rows = [[successDict objectForKey:@"result"] objectForKey:@"rows"];
                               if(rows && rows.count>0)
                               {
                                   JCCXModeList *list = [[JCCXModeList alloc] init];
                                   [list unPacketData:rows];
                                   if(aStatus == 1)
                                   {
                                       currentPage_1++;
                                   }
                                   else
                                   {
                                       currentPage_2++;
                                   }
                                   aFinishBlock(list);
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
        aFinishBlock(nil);
    }];
}

- (void)appGetProductStayDetail:(NSString *)aStayId finishBlock:(void(^)(JCCXDetailModeList *list))aFinishBlock
{
    if(aStayId)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setValue:aStayId forKey:@"stayId"];
        [NetManager requestWith:dict apiName:@"appGetProductStayDetail" method:@"post" succ:^(NSDictionary *successDict) {
            MLOG(@"%@",successDict);
            if(successDict)
            {
                NSArray *arry = [successDict objectForKey:@"result"];
                if(arry && arry.count>0)
                {
                    JCCXDetailModeList *list = [[JCCXDetailModeList alloc] init];
                    [list unPacketData:arry];
                    aFinishBlock(list);
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
            aFinishBlock(nil);
        }];
    }
    else
    {
        aFinishBlock(nil);
    }
}

- (void)setCurrentVipid:(NSString *)aVipId
{
    strVipId = aVipId;
}

- (void)setStartTime:(NSString *)aStartTime
{
    strStartTime = aStartTime;
}

- (void)setEndTime:(NSString *)aEndTime
{
    strEndTime = aEndTime;
}

@end
