//
//  RKSPMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RKSPMode.h"

@implementation RKSPMode

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
    
    AssignMentID(self.strProductId, [aDataDict objectForKey:@"product_id"]);
    BaseLongLongToNSString(self.strProductId);
    
    AssignMentID(self.strProductName, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strSalePrice, [aDataDict objectForKey:@"sale_price"]);
    BaseFloadToNSString(self.strSalePrice);
    
    AssignMentID(self.strShelfDys, [aDataDict objectForKey:@"shelf_dys"]);
    BaseIntToNSString(self.strShelfDys);
    
    AssignMentID(self.strStayQty, [aDataDict objectForKey:@"stay_qty"]);
    BaseLongLongToNSString(self.strStayQty);
    
    AssignMentID(self.strStockNum, [aDataDict objectForKey:@"stock_num"]);
    BaseLongLongToNSString(self.strStockNum);
    
    AssignMentID(self.strStockPrice, [aDataDict objectForKey:@"stock_price"]);
    BaseFloadToNSString(self.strStockPrice);
    
    AssignMentID(self.strStockQty, [aDataDict objectForKey:@"stock_qty"]);
    BaseLongLongToNSString(self.strStockQty);
    
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strSupName, [aDataDict objectForKey:@"sup_name"]);
    
}
@end

@implementation RKSPModeList

- (instancetype)init
{
    if(self = [super init]){
        self.rksModeArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strId);
    
    AssignMentID(self.strOrderTime, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strStatus, [aDataDict objectForKey:@"status"]);
    BaseIntToNSString(self.strStatus);
    
    AssignMentID(self.strStatusDesc, [aDataDict objectForKey:@"statusStr"]);
    AssignMentID(self.strCounterfoilUrl, [aDataDict objectForKey:@"counterfoil_url"]);
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    AssignMentID(self.strSupId, [aDataDict objectForKey:@"sup_id"]);
    BaseLongLongToNSString(self.strSupId);
    AssignMentID(self.strSupName, [aDataDict objectForKey:@"sup_name"]);
    
    AssignMentID(self.strTotalRealPay, [aDataDict objectForKey:@"total_real_pay"]);
    BaseFloadToNSString(self.strTotalRealPay);
    
    AssignMentID(self.strStockNum, [aDataDict objectForKey:@"stock_num"]);
    BaseLongLongToNSString(self.strStockNum);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseLongLongToNSString(self.strSid);
    
    NSArray *arry = [aDataDict objectForKey:@"detailList"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            RKSPMode *timeData = [[RKSPMode alloc] init];
            [timeData unPacketData:dict];
            [self.rksModeArry addObject:timeData];
        }
    }
}

@end

@implementation RKSPModeListList

- (instancetype)init
{
    if(self = [super init]){
        self.rksModeArryArry = [NSMutableArray arrayWithCapacity:0];
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
            RKSPModeList *timeData = [[RKSPModeList alloc] init];
            [timeData unPacketData:dict];
            [self.rksModeArryArry addObject:timeData];
        }
    }
}


@end



