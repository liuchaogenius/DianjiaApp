//
//  HYGLOneMothMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYGLOneMothMode.h"

@implementation HYGLOneMothMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strCardUserNum, [aDataDict objectForKey:@"card_use_num"]);
    BaseIntToNSString(self.strCardUserNum);
    
    AssignMentID(self.strDiscountRate, [aDataDict objectForKey:@"discount_rate"]);
    BaseFloadToNSString(self.strDiscountRate);
    
    AssignMentID(self.strEid, [aDataDict objectForKey:@"eid"]);
    BaseIntToNSString(self.strEid);
    
    AssignMentID(self.strEmpName, [aDataDict objectForKey:@"emp_name"]);
    
    AssignMentID(self.strid, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strid);
    
    AssignMentID(self.strLoginName, [aDataDict objectForKey:@"login_name"]);
    
    AssignMentID(self.strOrderTime, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strPayAbleMoney, [aDataDict objectForKey:@"payable_money"]);
    BaseFloadToNSString(self.strPayAbleMoney);
    
    AssignMentID(self.strProductCode, [aDataDict objectForKey:@"product_code"]);
    BaseLongLongToNSString(self.strProductCode);
    
    AssignMentID(self.strProductId, [aDataDict objectForKey:@"product_id"]);
    BaseLongLongToNSString(self.strProductId);
    
    AssignMentID(self.strProductName, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strRealMoney, [aDataDict objectForKey:@"real_money"]);
    BaseFloadToNSString(self.strRealMoney);
    
    AssignMentID(self.strSaleId, [aDataDict objectForKey:@"sale_id"]);
    BaseLongLongToNSString(self.strSaleId);
    
    AssignMentID(self.strSaleNum, [aDataDict objectForKey:@"sale_num"]);
    BaseIntToNSString(self.strSaleNum);
    
    AssignMentID(self.strSalePrice, [aDataDict objectForKey:@"sale_price"]);
    BaseFloadToNSString(self.strSalePrice);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseLongLongToNSString(self.strSid);
    
    AssignMentID(self.strSrl, [aDataDict objectForKey:@"srl"]);
    BaseLongLongToNSString(self.strSrl);
    
    AssignMentID(self.strSrlStatus, [aDataDict objectForKey:@"srl_status"]);
    BaseIntToNSString(self.strSrlStatus);
    
    AssignMentID(self.strStockPrice, [aDataDict objectForKey:@"stock_price"]);
    BaseFloadToNSString(self.strStockPrice);
    
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    BaseIntToNSString(self.strUid);
}
@end

@implementation HYGLOneMothTimeList

- (instancetype)init
{
    if(self = [super init]){
        self.oneMothDataArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)unPacketData:(NSDictionary *)aDataDict
{
    self.strOrderTime = [aDataDict objectForKey:@"order_time"];
    NSArray *arry = [aDataDict objectForKey:@"DetailList"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            HYGLOneMothMode *timeData = [[HYGLOneMothMode alloc] init];
            [timeData unPacketData:dict];
            [self.oneMothDataArry addObject:timeData];
        }
    }
}

@end

@implementation HYGLDataModeList

- (instancetype)init
{
    if(self = [super init]){
        self.HYGLDataArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)adataDict
{
    NSArray *arry = [adataDict objectForKey:@"result"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            HYGLOneMothTimeList *timeData = [[HYGLOneMothTimeList alloc] init];
            [timeData unPacketData:dict];
            [self.HYGLDataArry addObject:timeData];
        }
    }
}

@end
