//
//  VipInfoMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "VipInfoMode.h"

@implementation VipInfoMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strCardNum, [aDataDict objectForKey:@"card_num"]);
    BaseIntToNSString(self.strCardNum);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
    
    AssignMentID(self.strPortraitDomain, [aDataDict objectForKey:@"portrait_domain"]);
    
    AssignMentID(self.strPortraitUrl, [aDataDict objectForKey:@"portrait_url"]);
    
    AssignMentID(self.strQQ, [aDataDict objectForKey:@"qq"]);
    
    AssignMentID(self.strRemark, [aDataDict objectForKey:@"remark"]);
    
    AssignMentID(self.strSaleMoney, [aDataDict objectForKey:@"sale_money"]);
    BaseFloadToNSString(self.strSaleMoney);
    
    AssignMentID(self.strVipAddr, [aDataDict objectForKey:@"vip_addr"]);
    
    AssignMentID(self.strVipBirethday, [aDataDict objectForKey:@"vip_birthday"]);
    
    AssignMentID(self.strVipCode, [aDataDict objectForKey:@"vip_code"]);
    BaseLongLongToNSString(self.strVipCode);
    
    AssignMentID(self.strVipDiscount, [aDataDict objectForKey:@"vip_discount"]);
    BaseFloadToNSString(self.strVipDiscount);
    
    AssignMentID(self.strVipLevel, [aDataDict objectForKey:@"vip_level"]);
    BaseFloadToNSString(self.strVipLevel);
    
    AssignMentID(self.strVipName, [aDataDict objectForKey:@"vip_name"]);
    
    AssignMentID(self.strVipPhone, [aDataDict objectForKey:@"vip_phone"]);
    
    AssignMentID(self.strVipScore, [aDataDict objectForKey:@"vip_score"]);
    BaseLongLongToNSString(self.strVipScore);
    
    AssignMentID(self.strVipSex, [aDataDict objectForKey:@"vip_sex"]);
    if([self.strVipSex intValue] == 1)
    {
        self.strVipSex = @"男";
    }
    else if([self.strVipSex intValue] == 2)
    {
        self.strVipSex = @"女";
    }
    else
    {
        self.strVipSex = @"";
    }

    
    AssignMentID(self.strWeixin, [aDataDict objectForKey:@"weixin"]);
    
    self.isHasRemark = [[aDataDict objectForKey:@"ishaveRemark"] boolValue];
    
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif
@end

@implementation VipInfoList

- (instancetype)init
{
    if(self = [super init]){
        self.modeList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSArray *)aDataArry
{
    if(aDataArry && aDataArry.count>0)
    {
        for(NSDictionary *dict in aDataArry)
        {
            VipInfoMode *mode = [[VipInfoMode alloc] init];
            [mode unPacketData:dict];
            [self.modeList addObject:mode];
        }
    }
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif
@end

