//
//  FirstMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "FirstMode.h"

@implementation FirstMode

- (instancetype)init
{
    if(self = [super init]){
        self.ssMode = [[SaleSrlStatisticMode alloc] init];
        self.sumMode = [[SummaryStoreStockMode alloc] init];
        self.homeInfoMode = [[HomePageInfoAppMode alloc] init];
    }
    return self;
}
@end

@implementation SaleSrlStatisticMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strSaleCount, [aDataDict objectForKey:@"sale_count"]);
    BaseIntToNSString(self.strSaleCount);
    
    AssignMentID(self.strRealMoney, [aDataDict objectForKey:@"real_money"]);
    BaseFloadToNSString(self.strRealMoney);
    
    AssignMentID(self.strStockMoney, [aDataDict objectForKey:@"stock_money"]);
    BaseFloadToNSString(self.strStockMoney);
    
    AssignMentID(self.strProFitMoney, [aDataDict objectForKey:@"profit_money"]);
    BaseFloadToNSString(self.strProFitMoney);
}
@end

@implementation SummaryStoreStockMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    BaseLongLongToNSString(self.strUid);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BaseLongLongToNSString(self.strSid);
    
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strStockQty, [aDataDict objectForKey:@"stock_qty"]);
    BaseLongLongToNSString(self.strStockQty);
    
    AssignMentID(self.strStockMoney, [aDataDict objectForKey:@"stock_money"]);
    BaseFloadToNSString(self.strStockMoney);
    
    AssignMentID(self.strSaleMoney, [aDataDict objectForKey:@"sale_money"]);
    BaseFloadToNSString(self.strSaleMoney);
    
    AssignMentID(self.strJZLS, [aDataDict objectForKey:@"dayTotal"]);
    BaseFloadToNSString(self.strJZLS);
    
    AssignMentID(self.strBZLS, [aDataDict objectForKey:@"weekTotal"]);
    BaseFloadToNSString(self.strBZLS);
    
    AssignMentID(self.strBYLS, [aDataDict objectForKey:@"monthTotal"]);
    BaseFloadToNSString(self.strBYLS);
}
@end


@implementation HomePageInfoAppMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strStockWarnPCount, [aDataDict objectForKey:@"stock_warn_p_count"]);
    BaseIntToNSString(self.strStockWarnPCount);
    
    AssignMentID(self.strSaleWarnPCount, [aDataDict objectForKey:@"sale_warn_p_count"]);
    BaseIntToNSString(self.strSaleWarnPCount);
    
    AssignMentID(self.strPreviousDayTotal, [aDataDict objectForKey:@"previousDayTotal"]);
    BaseFloadToNSString(self.strPreviousDayTotal);
    
    AssignMentID(self.strPreviousWeekTotal, [aDataDict objectForKey:@"previousWeekTotal"]);
    BaseFloadToNSString(self.strPreviousWeekTotal);
    
    AssignMentID(self.strPreviousMonthTotal, [aDataDict objectForKey:@"previousMonthTotal"]);
    BaseFloadToNSString(self.strPreviousMonthTotal);
}
@end


