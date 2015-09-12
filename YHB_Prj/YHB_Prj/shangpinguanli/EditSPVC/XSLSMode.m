//
//  XSLSMode.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "XSLSMode.h"

@implementation XSLSMode

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strCard_use_num, [aDataDict objectForKey:@"card_use_num"]);
    BaseIntToNSString(self.strCard_use_num);
    
    AssignMentID(self.strDiscount_rate, [aDataDict objectForKey:@"discount_rate"]);
    BaseIntToNSString(self.strDiscount_rate);
    
    AssignMentID(self.strEid, [aDataDict objectForKey:@"eid"]);
    BaseIntToNSString(self.strEid);
    
    AssignMentID(self.strEmp_name, [aDataDict objectForKey:@"emp_name"]);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
    
    AssignMentID(self.strLogin_name, [aDataDict objectForKey:@"login_name"]);
    BaseIntToNSString(self.strLogin_name);
    
    AssignMentID(self.strOrder_time, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strPayable_money, [aDataDict objectForKey:@"payable_money"]);
    BaseLongLongToNSString(self.strPayable_money);
    
    AssignMentID(self.strProduct_code, [aDataDict objectForKey:@"product_code"]);
    
    AssignMentID(self.strProduct_id, [aDataDict objectForKey:@"product_id"]);
    BaseLongLongToNSString(self.strProduct_id);
    
    AssignMentID(self.strProduct_name, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strReal_money, [aDataDict objectForKey:@"real_money"]);
    
    AssignMentID(self.strSale_id, [aDataDict objectForKey:@"sale_id"]);
    BaseLongLongToNSString(self.strSale_id);
    
    AssignMentID(self.strSale_num, [aDataDict objectForKey:@"sale_num"]);
    BaseLongLongToNSString(self.strSale_num);
    
    AssignMentID(self.strSale_price, [aDataDict objectForKey:@"sale_price"]);
    BaseLongLongToNSString(self.strSale_price);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseFloadToNSString(self.strSid);
    
    AssignMentID(self.strSrl, [aDataDict objectForKey:@"srl"]);
//    BaseFloadToNSString(self.strSrl);
    
    AssignMentID(self.strSrl_status, [aDataDict objectForKey:@"srl_status"]);
    BaseFloadToNSString(self.strSrl_status);
    
    AssignMentID(self.strStock_price, [aDataDict objectForKey:@"stock_price"]);
    
    AssignMentID(self.strStore_name, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    BaseFloadToNSString(self.strUid);
}

@end

@implementation XSLSList

- (instancetype)init
{
    if(self = [super init]){
        self.productList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *arry = [aDataDict objectForKey:@"rows"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            XSLSMode *mode = [[XSLSMode alloc] init];
            [mode unPacketData:dict];
            [self.productList addObject:mode];
        }
    }
}

@end

