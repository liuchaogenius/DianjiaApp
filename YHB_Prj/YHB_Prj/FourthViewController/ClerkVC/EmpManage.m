//
//  EmpManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/2.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "EmpManage.h"
#import "NetManager.h"
#import "EmpMode.h"

@implementation EmpManage

- (void)getEmpListWithFinishBlock:(void (^)(NSArray *))FBlock
{
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    //    [dict setValue:[NSNumber numberWithInt:currentPage] forKey:@"pageNo"];
    //    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];
    
    [NetManager requestWith:nil apiName:@"getAllEmpByUid" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        if (successDict)
        {
            EmpModeList *list = [[EmpModeList alloc] init];
            [list unPacketData:successDict];
            FBlock(list.empList);
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
