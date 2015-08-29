//
//  DJProductCheckManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckManager.h"
#import "NetManager.h"
#import "DJProductCheckSrlResult.h"

@implementation DJProductCheckManager
+ (void)getProductCheckSrlWithSid:(NSString *)sid
                          PageNum: (NSInteger)pageNum
                         pageSize: (NSInteger)pageSize
                        beginTime: (NSString *)begin
                          endTime: (NSString *)end
                          success: (successHandler)sHandler
                             fail: (failHandler)failHandler
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(pageNum),@"pageNo",@(pageSize),@"pageSize",@YES,@"needPage",sid?:@"0",@"sid",nil];
    if (begin) {
        [postDic setObject:begin forKey:@"beginTime"];
    }
    if (end) {
        [postDic setObject:end forKey:@"endTime"];
    }
    
    [NetManager requestWith:postDic apiName:@"getProductCheckSrlPage" method:@"POST" succ:^(NSDictionary *successDict) {
        NSLog(@"%@",successDict);
        if ([successDict[@"msg"] isEqualToString:@"success"]) {
            NSDictionary *result = successDict[@"result"];
            DJProductCheckSrlResult *resultModel = [[DJProductCheckSrlResult alloc] initWithDictionary:result];
            if (sHandler) {
                sHandler(resultModel);
            }
        }else {
            if (failHandler) {
                failHandler(successDict[@"msg"]);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        if (failHandler) {
            failHandler(@"");
        }
    }];
}

@end
