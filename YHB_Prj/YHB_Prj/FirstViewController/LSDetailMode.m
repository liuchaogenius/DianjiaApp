//
//  LSDetailMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "LSDetailMode.h"

@implementation LSDetailMode
- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strcard_use_num, [aDataDict objectForKey:@"card_use_num"]);
    
    AssignMentID(self.strdiscount_rate, [aDataDict objectForKey:@"discount_rate"]);
    BaseFloadToNSString(self.strdiscount_rate);
    AssignMentID(self.streid, [aDataDict objectForKey:@"eid"]);
    BaseIntToNSString(self.strid);
    AssignMentID(self.strid, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strid);
    AssignMentID(self.strpayable_money, [aDataDict objectForKey:@"payable_money"]);
    BaseFloadToNSString(self.strpayable_money);
    AssignMentID(self.strproduct_code, [aDataDict objectForKey:@"product_code"]);
    
    AssignMentID(self.strproduct_id, [aDataDict objectForKey:@"product_id"]);
    
    AssignMentID(self.strproduct_name, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strreal_money, [aDataDict objectForKey:@"real_money"]);
    BaseFloadToNSString(self.strreal_money);
    AssignMentID(self.strsale_id, [aDataDict objectForKey:@"sale_id"]);
    
    AssignMentID(self.strsale_num, [aDataDict objectForKey:@"sale_num"]);
    BaseIntToNSString(self.strsale_num);
    AssignMentID(self.strsale_price, [aDataDict objectForKey:@"sale_price"]);
    BaseFloadToNSString(self.strsale_price);
    AssignMentID(self.strsid, [aDataDict objectForKey:@"sid"]);
    
    AssignMentID(self.strsrl, [aDataDict objectForKey:@"srl"]);
    
    AssignMentID(self.strsrl_status, [aDataDict objectForKey:@"srl_status"]);
    
    AssignMentID(self.strstock_price, [aDataDict objectForKey:@"stock_price"]);
    BaseFloadToNSString(self.strstock_price);
    AssignMentID(self.struid, [aDataDict objectForKey:@"uid"]);
    
}
@end

@implementation LSDetailModeList

- (instancetype)init
{
    if(self = [super init]){
        self.modeArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *arry = [aDataDict objectForKey:@"result"];
    if(arry && arry.count >0)
    {
        for(NSDictionary *dict in arry)
        {
            LSDetailMode *mode = [[LSDetailMode alloc] init];
            [mode unPacketData:dict];
            [self.modeArry addObject:mode];
        }
    }
}
@end






