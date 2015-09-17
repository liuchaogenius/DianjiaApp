//
//  WYJHMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHMode.h"

@implementation WYJHMode
- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strAddDate, [aDataDict objectForKey:@"add_date"]);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
    AssignMentID(self.strMakeDate, [aDataDict objectForKey:@"make_date"]);
    
    AssignMentID(self.strProductCode, [aDataDict objectForKey:@"product_code"]);
    
    AssignMentID(self.strProductId, [aDataDict objectForKey:@"product_id"]);
    BaseLongLongToNSString(self.strProductId);
    AssignMentID(self.strProductName, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strSalePrice, [aDataDict objectForKey:@"sale_price"]);
    BaseFloadToNSString(self.strSalePrice);
    AssignMentID(self.strShelfDys, [aDataDict objectForKey:@"shelf_dys"]);
    BaseIntToNSString(self.strShelfDys);
    AssignMentID(self.strStayQty, [aDataDict objectForKey:@"stay_qty"]);
    BaseIntToNSString(self.strStayQty);
    AssignMentID(self.strStockNum, [aDataDict objectForKey:@"stock_num"]);
    BaseIntToNSString(self.strStockNum);
    AssignMentID(self.strStockPrice, [aDataDict objectForKey:@"stock_price"]);
    BaseFloadToNSString(self.strStockPrice);
    AssignMentID(self.strStockQty, [aDataDict objectForKey:@"stock_qty"]);
    BaseIntToNSString(self.strStockQty);
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strSupId, [aDataDict objectForKey:@"sup_id"]);
    BaseLongLongToNSString(self.strSupId);
    
    AssignMentID(self.strSupName, [aDataDict objectForKey:@"sup_name"]);
    
}
@end


@implementation WYJHModeList

- (instancetype)init
{
    if(self = [super init]){
        self.modeListArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strAccountType, [aDataDict objectForKey:@"account_type"]);
    BaseIntToNSString(self.strAccountType);
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
    AssignMentID(self.strOrderFromName, [aDataDict objectForKey:@"order_from_name"]);
    
    AssignMentID(self.strOrderTime, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseLongLongToNSString(self.strSid);
    AssignMentID(self.strSrl, [aDataDict objectForKey:@"srl"]);
    
    AssignMentID(self.strStatus, [aDataDict objectForKey:@"status"]);
    BaseIntToNSString(self.strStatus);
    AssignMentID(self.strStatusStr, [aDataDict objectForKey:@"statusStr"]);
    
    AssignMentID(self.strStockNum, [aDataDict objectForKey:@"stock_num"]);
    BaseIntToNSString(self.strStockNum);
    AssignMentID(self.strStockName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strSupid, [aDataDict objectForKey:@"sup_id"]);
    BaseLongLongToNSString(self.strSupid);
    AssignMentID(self.strSupName, [aDataDict objectForKey:@"sup_name"]);
    
    AssignMentID(self.strEmpStockId, [aDataDict objectForKey:@"emp_stock_id"]);
    BaseLongLongToNSString(self.strEmpStockId);
    
    AssignMentID(self.strTotalRealPay, [aDataDict objectForKey:@"total_real_pay"]);
    BaseFloadToNSString(self.strTotalRealPay);
    NSArray *detailList = [aDataDict objectForKey:@"detailList"];
    if(detailList && detailList.count > 0)
    {
        for(NSDictionary *dict in detailList)
        {
            WYJHMode *mode = [[WYJHMode alloc] init];
            [mode unPacketData:dict];
            [self.modeListArry addObject:mode];
        }
    }
}

@end

@implementation WYJHModeRows
- (instancetype)init
{
    if(self = [super init]){
        self.modeRowsArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *rows = [aDataDict objectForKey:@"rows"];
    if(rows && rows.count > 0)
    {
        for(NSDictionary *dict in rows)
        {
            WYJHModeList *modeList = [[WYJHModeList alloc] init];
            [modeList unPacketData:dict];
            [self.modeRowsArry addObject:modeList];
        }
    }
}
@end

