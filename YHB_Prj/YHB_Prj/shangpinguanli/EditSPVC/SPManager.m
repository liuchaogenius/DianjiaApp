//
//  SPManager.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPManager.h"
#import "NetManager.h"

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
