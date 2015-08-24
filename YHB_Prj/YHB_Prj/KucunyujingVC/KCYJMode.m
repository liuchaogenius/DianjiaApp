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
    
}
@end
