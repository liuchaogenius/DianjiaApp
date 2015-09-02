//
//  SupplierManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/1.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SupplierManage.h"
#import "NetManager.h"
#import "SupplierMode.h"

//@interface SupplierManage()
//{
//    int currentPage;
//}
//
//@end

@implementation SupplierManage

- (void)getSupplierListWithFinishBlock:(void (^)(NSArray *resultArr))FBlock
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dict setValue:[NSNumber numberWithInt:currentPage] forKey:@"pageNo"];
//    [dict setValue:[NSNumber numberWithInt:20] forKey:@"pageSize"];

    [NetManager requestWith:nil apiName:@"appGetAllSupplier" method:@"POST" succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        if (successDict)
        {
            SupplierModeList *list = [[SupplierModeList alloc] init];
            [list unPacketData:successDict];
            FBlock(list.supplierList);
        }
        else
        {
            FBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        FBlock(nil);
    }];
}

- (void)changeSupplier:(SupplierMode *)amode withFinishBlock:(void(^)(NSString *aCode))FBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:amode.strAddress forKey:@"Address"];
    [dict setValue:amode.strid forKey:@"id"];
    [dict setValue:amode.strTel forKey:@"Tel"];
    [dict setValue:amode.strContact forKey:@"Contact"];
    [dict setValue:amode.strRemark forKey:@"Remark"];
    [dict setValue:amode.strSupName forKey:@"SupName"];
    [dict setValue:amode.strFax forKey:@"Fax"];
    [dict setValue:amode.strEmail forKey:@"Email"];
    [NetManager requestWith:dict apiName:@"editSupplier" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        if (successDict)
        {
            NSString *str = successDict[@"message"];
            if ([str isEqualToString:@"success"])
            {
                FBlock(@"1");
            }
            else
            {
                FBlock(nil);
            }
        }
        else
        {
            FBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        FBlock(nil);
    }];
}

- (void)deleteSupplier:(NSString *)aStrid withFinishBlock:(void (^)(NSString *))FBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:aStrid forKey:@"id"];
    [NetManager requestWith:dict apiName:@"delSupplier" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        if (successDict)
        {
            NSString *str = successDict[@"message"];
            if ([str isEqualToString:@"success"])
            {
                FBlock(@"1");
            }
            else
            {
                FBlock(nil);
            }
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
