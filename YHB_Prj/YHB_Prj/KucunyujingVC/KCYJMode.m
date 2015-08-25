//
//  KCYJMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "KCYJMode.h"

@implementation KCYJMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
    
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
     BaseIntToNSString(self.strUid);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseIntToNSString(self.strSid);
    
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strWrningCount, [aDataDict objectForKey:@"warningCount"]);
    BaseIntToNSString(self.strWrningCount);
    
    AssignMentID(self.strProductId, [aDataDict objectForKey:@"product_id"]);
    BaseIntToNSString(self.strProductId);
    
    AssignMentID(self.strProductName, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strStockQty, [aDataDict objectForKey:@"stock_qty"]);
    BaseFloadToNSString(self.strStockQty);
    
    AssignMentID(self.strSaleRate, [aDataDict objectForKey:@"sale_rate"]);
    BaseFloadToNSString(self.strSaleRate);
    
    AssignMentID(self.strSaleDays, [aDataDict objectForKey:@"sale_days"]);
    BaseFloadToNSString(self.strSaleDays);
    
    AssignMentID(self.strSaleNum, [aDataDict objectForKey:@"sale_num"]);
    BaseFloadToNSString(self.strSaleNum);
    
    AssignMentID(self.strStockMoney, [aDataDict objectForKey:@"stock_money"]);
    BaseFloadToNSString(self.strStockMoney);
    
    AssignMentID(self.strSumStockMoney, [aDataDict objectForKey:@"sum_stock_money"]);
    BaseFloadToNSString(self.strSumStockMoney);
    
    AssignMentID(self.strProductItemNum, [aDataDict objectForKey:@"product_item_num"]);
    BaseIntToNSString(self.strProductItemNum);
}
@end

@implementation KCYJListMode

- (instancetype)init
{
    if(self = [super init]){
        self.kcyjModeArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strAutoCount, [aDataDict objectForKey:@"autoCount"]);
    BaseIntToNSString(self.strAutoCount);
    
    AssignMentID(self.strNeedPage, [aDataDict objectForKey:@"needPage"]);
    BaseIntToNSString(self.strNeedPage);
    
    AssignMentID(self.strOrder, [aDataDict objectForKey:@"order"]);
    BaseIntToNSString(self.strOrder);
    
    AssignMentID(self.strOrderBy, [aDataDict objectForKey:@"orderBy"]);
    BaseIntToNSString(self.strOrderBy);
    
    AssignMentID(self.strPageNo, [aDataDict objectForKey:@"pageNo"]);
    BaseIntToNSString(self.strPageNo);
    
    AssignMentID(self.strPageSize, [aDataDict objectForKey:@"pageSize"]);
    BaseIntToNSString(self.strPageSize);
    
    NSArray *arry = [aDataDict objectForKey:@"rows"];
    for(NSDictionary *dict in arry)
    {
        KCYJMode *mode = [[KCYJMode alloc] init];
        [mode unPacketData:dict];
        [self.kcyjModeArry addObject:mode];
    }
}
@end

@implementation StoreTockList

- (instancetype)init
{
    if(self = [super init]){
        self.storeStockArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSArray *)aDataDictArry
{
    if(aDataDictArry && aDataDictArry.count > 0)
    {
        for(NSDictionary *dict in aDataDictArry)
        {
            StoreTockMode *mode = [[StoreTockMode alloc] init];
            [mode unPacketData:dict];
            [self.storeStockArry addObject:mode];
        }
    }
}
@end

@implementation StoreTockMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strDayTotal, [aDataDict objectForKey:@"dayTotal"]);
    BaseIntToNSString(self.strDayTotal);
    
    AssignMentID(self.strMonthTotal, [aDataDict objectForKey:@"monthTotal"]);
    BaseIntToNSString(self.strMonthTotal);
    
    AssignMentID(self.strSaleMoney, [aDataDict objectForKey:@"sale_money"]);
    BaseFloadToNSString(self.strSaleMoney);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseIntToNSString(self.strSid);
    
    AssignMentID(self.strStockMoney, [aDataDict objectForKey:@"stock_money"]);
    BaseFloadToNSString(self.strStockMoney);
    
    AssignMentID(self.strStockQty, [aDataDict objectForKey:@"stock_qty"]);
    BaseFloadToNSString(self.strStockQty);
    
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    BaseIntToNSString(self.strUid);
    
    AssignMentID(self.strWeekTotal, [aDataDict objectForKey:@"weekTotal"]);
    BaseIntToNSString(self.strWeekTotal);
    
}
@end

