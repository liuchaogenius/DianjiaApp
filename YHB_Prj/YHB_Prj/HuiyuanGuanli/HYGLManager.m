//
//  HYGLManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYGLManager.h"
#import "NetManager.h"
#import "VipInfoMode.h"
#import "HYGLOneMothMode.h"
#import "SVProgressHUD.h"

@implementation HYGLManager
- (void)appGetAllVip:(void(^)(VipInfoList *modeList))aFinishBlock
{
    [SVProgressHUD showWithStatus:kLoadingText cover:NO offsetY:64];
    [NetManager requestWith:nil apiName:@"appGetAllVip" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        [SVProgressHUD dismiss];
        if(successDict)
        {
            NSArray *arry = [successDict objectForKey:@"result"];
            if(arry && arry.count > 0)
            {
                VipInfoList *list = [[VipInfoList alloc] init];
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
        [SVProgressHUD dismiss];
         aFinishBlock(nil);
    }];
}

- (void)appGetVipDetailByVid:(NSString *)aVipId
                 finishBlock:(void(^)(VipInfoMode *mode))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:aVipId forKey:@"id"];
    [SVProgressHUD showWithStatus:kLoadingText cover:NO offsetY:64];
    [NetManager requestWith:dict apiName:@"appGetVipDetailByVid" method:@"POST" succ:^(NSDictionary *successDict) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            VipInfoMode *mode = [[VipInfoMode alloc] init];
            [mode unPacketData:dict];
            aFinishBlock(mode);
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        [SVProgressHUD dismiss];
        aFinishBlock(nil);
    }];
}

- (void)getVipSaleOneMonth:(NSString *)aVipId
               finishBlock:(void(^)(HYGLDataModeList *mode))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:aVipId forKey:@"id"];
    [NetManager requestWith:dict apiName:@"getVipSaleOneMonth" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if(successDict)
        {
            HYGLDataModeList *mode = [[HYGLDataModeList alloc] init];
            [mode unPacketData:successDict];
            aFinishBlock(mode);
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFinishBlock(nil);
    }];
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif

@end
