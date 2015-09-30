//
//  JCCXDetailMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/30.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "JCCXDetailMode.h"

@implementation JCCXDetailMode
- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.stremp_name, [aDataDict objectForKey:@"emp_name"]);
    
    AssignMentID(self.strid, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strid);
    AssignMentID(self.strlogin_name, [aDataDict objectForKey:@"login_name"]);
    
    AssignMentID(self.strorder_time, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strpinyin_code, [aDataDict objectForKey:@"pinyin_code"]);
    BaseLongLongToNSString(self.strpinyin_code);
    
    AssignMentID(self.strproduct_code, [aDataDict objectForKey:@"product_code"]);
    BaseLongLongToNSString(self.strproduct_code);
    AssignMentID(self.strproduct_id, [aDataDict objectForKey:@"product_id"]);
    BaseLongLongToNSString(self.strproduct_id);
    AssignMentID(self.strproduct_name, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strremark, [aDataDict objectForKey:@"remark"]);
    
    AssignMentID(self.strstatus, [aDataDict objectForKey:@"status"]);
    BaseIntToNSString(self.strstatus);
    
    AssignMentID(self.strstay_id, [aDataDict objectForKey:@"stay_id"]);
    BaseLongLongToNSString(self.strstay_id);
    
    AssignMentID(self.strstore_name, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strsurplus_num, [aDataDict objectForKey:@"surplus_num"]);
    BaseIntToNSString(self.strsurplus_num);
    
    AssignMentID(self.strsurplus_sum, [aDataDict objectForKey:@"surplus_sum"]);
    BaseIntToNSString(self.strsurplus_sum);
    
    AssignMentID(self.strtake_num, [aDataDict objectForKey:@"take_num"]);
    BaseIntToNSString(self.strtake_num);
    AssignMentID(self.strtotal_num, [aDataDict objectForKey:@"total_num"]);
    BaseIntToNSString(self.strtotal_num);
    AssignMentID(self.strvip_code, [aDataDict objectForKey:@"vip_code"]);
    
    AssignMentID(self.strvip_id, [aDataDict objectForKey:@"vip_id"]);
    BaseIntToNSString(self.strvip_id);
    
    AssignMentID(self.strvip_name, [aDataDict objectForKey:@"vip_name"]);
    
    AssignMentID(self.strvip_phone, [aDataDict objectForKey:@"vip_phone"]);
    
}
@end

@implementation JCCXDetailModeList

- (instancetype)init
{
    if(self = [super init]){
        self.modeList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSArray *)aDataDictArry
{
    if(aDataDictArry && aDataDictArry.count>0)
    {
        for(NSDictionary *dict in aDataDictArry)
        {
            JCCXDetailMode *moce = [[JCCXDetailMode alloc] init];
            [moce unPacketData:dict];
            [self.modeList addObject:moce];
        }
    }
}
@end
