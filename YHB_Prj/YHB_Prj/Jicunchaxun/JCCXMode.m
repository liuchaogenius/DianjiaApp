//
//  JCCXMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JCCXMode.h"

@implementation JCCXMode
- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strEmpName, [aDataDict objectForKey:@"emp_name"]);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strId);
    AssignMentID(self.strLoginName, [aDataDict objectForKey:@"login_name"]);
    
    AssignMentID(self.strOrderTimer, [aDataDict objectForKey:@"order_time"]);
    
    AssignMentID(self.strPinyinCode, [aDataDict objectForKey:@"pinyin_code"]);
    
    AssignMentID(self.strProductCode, [aDataDict objectForKey:@"product_code"]);
    BaseLongLongToNSString(self.strProductCode);
    AssignMentID(self.strProductId, [aDataDict objectForKey:@"product_id"]);
    BaseLongLongToNSString(self.strProductId);
    AssignMentID(self.strProductName, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strRemark, [aDataDict objectForKey:@"remark"]);
    
    AssignMentID(self.strStatus, [aDataDict objectForKey:@"status"]);
    BaseIntToNSString(self.strStatus);
    AssignMentID(self.strStayId, [aDataDict objectForKey:@"stay_id"]);
    BaseIntToNSString(self.strStayId);
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strSurplusNum, [aDataDict objectForKey:@"surplus_num"]);
    BaseIntToNSString(self.strSurplusNum);
    
    AssignMentID(self.strSrplusSum, [aDataDict objectForKey:@"surplus_sum"]);
    BaseIntToNSString(self.strSrplusSum);
    AssignMentID(self.strTakeNum, [aDataDict objectForKey:@"take_num"]);
    BaseIntToNSString(self.strTakeNum);
    AssignMentID(self.strTotalNum, [aDataDict objectForKey:@"total_num"]);
    BaseIntToNSString(self.strTotalNum);
    AssignMentID(self.strVipCode, [aDataDict objectForKey:@"vip_code"]);
    BaseLongLongToNSString(self.strVipCode);
    AssignMentID(self.strVipId, [aDataDict objectForKey:@"vip_id"]);
    BaseIntToNSString(self.strVipCode);
    AssignMentID(self.strVipName, [aDataDict objectForKey:@"vip_name"]);
    
    AssignMentID(self.strVipPhone, [aDataDict objectForKey:@"vip_phone"]);
}
@end

@implementation JCCXModeList

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
            JCCXMode *moce = [[JCCXMode alloc] init];
            [moce unPacketData:dict];
            [self.modeList addObject:moce];
        }
    }
}
@end




