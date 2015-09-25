//
//  LSMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "LSMode.h"

@implementation LSMode
- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strBank_payed, [aDataDict objectForKey:@"bank_payed"]);
    BaseFloadToNSString(self.strBank_payed);
    AssignMentID(self.strCard_payed, [aDataDict objectForKey:@"card_payed"]);
    BaseFloadToNSString(self.strCard_payed);
    AssignMentID(self.strCash_payed, [aDataDict objectForKey:@"cash_payed"]);
    BaseFloadToNSString(self.strCash_payed);
    AssignMentID(self.strCreditId, [aDataDict objectForKey:@"creditId"]);
    BaseIntToNSString(self.strCreditId);
    AssignMentID(self.strDiscount_rate, [aDataDict objectForKey:@"discount_rate"]);
    BaseFloadToNSString(self.strDiscount_rate);
    AssignMentID(self.strEid, [aDataDict objectForKey:@"eid"]);
    
    AssignMentID(self.strEmp_name, [aDataDict objectForKey:@"emp_name"]);
    
    AssignMentID(self.strEndOrderTime, [aDataDict objectForKey:@"endOrderTime"]);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    
    AssignMentID(self.strIsScore, [aDataDict objectForKey:@"isScore"]);
    
    AssignMentID(self.strLogin_name, [aDataDict objectForKey:@"login_name"]);
    
    AssignMentID(self.strOrder_class, [aDataDict objectForKey:@"order_class"]);
    
    AssignMentID(self.strOrder_time, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strOrder_type, [aDataDict objectForKey:@"order_type"]);
    
    AssignMentID(self.strPayable_money, [aDataDict objectForKey:@"payable_money"]);
    BaseFloadToNSString(self.strPayable_money);
    AssignMentID(self.strPayment, [aDataDict objectForKey:@"payment"]);
    
    AssignMentID(self.strPayrel_money, [aDataDict objectForKey:@"payrel_money"]);
    BaseFloadToNSString(self.strPayrel_money);
    AssignMentID(self.strPayrel_money_sum, [aDataDict objectForKey:@"payrel_money_sum"]);
    BaseFloadToNSString(_strPayrel_money_sum);
    AssignMentID(self.strProfit_money, [aDataDict objectForKey:@"profit_money"]);
    BaseFloadToNSString(_strProfit_money);
    AssignMentID(self.strReal_money, [aDataDict objectForKey:@"real_money"]);
    BaseFloadToNSString(self.strReal_money);
    AssignMentID(self.strSco_cost, [aDataDict objectForKey:@"sco_cost"]);
    
    AssignMentID(self.strSco_payed, [aDataDict objectForKey:@"sco_payed"]);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    
    AssignMentID(self.strSrl, [aDataDict objectForKey:@"srl"]);
    
    AssignMentID(self.strStatus, [aDataDict objectForKey:@"status"]);
    
    AssignMentID(self.strStock_money, [aDataDict objectForKey:@"stock_money"]);
    BaseFloadToNSString(self.strStock_money);
    AssignMentID(self.strStore_name, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strThird_payed, [aDataDict objectForKey:@"third_payed"]);
    
    AssignMentID(self.strTicket_payed, [aDataDict objectForKey:@"ticket_payed"]);
    
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    
    AssignMentID(self.strVip_code, [aDataDict objectForKey:@"vip_code"]);
    
    AssignMentID(self.strVip_id, [aDataDict objectForKey:@"vip_id"]);
    
    AssignMentID(self.strVip_name, [aDataDict objectForKey:@"vip_name"]);
    
    AssignMentID(self.strVip_score, [aDataDict objectForKey:@"vip_score"]);
    
    AssignMentID(self.strVip_score_type, [aDataDict objectForKey:@"vip_score_type"]);
    
}
@end


@implementation LSModeList

- (instancetype)init
{
    if(self = [super init]){
        self.modeArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketModeData:(NSDictionary *)aDict
{
    NSArray *arry = [aDict objectForKey:@"rows"];
    if(aDict && arry && arry.count>0)
    {
        for(NSDictionary *dict in arry)
        {
            LSMode *mode = [[LSMode alloc] init];
            [mode unPacketData:dict];
            [self.modeArry addObject:mode];
        }
    }
}

@end






