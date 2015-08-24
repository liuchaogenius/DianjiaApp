//
//  LoginMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//
#import "LoginMode.h"

@implementation LoginMode

- (instancetype)init
{
    if(self = [super init]){
        self.storeList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strAddDate, [aDataDict objectForKey:@"add_date"]);
    
    AssignMentID(self.strAreaCode, [aDataDict objectForKey:@"area_code"]);
    BasLongLongToNSString(self.strAreaCode);
    
    AssignMentID(self.strCityCode, [aDataDict objectForKey:@"city_code"]);
    BasLongLongToNSString(self.strCityCode);
    
    AssignMentID(self.strCompanyName, [aDataDict objectForKey:@"company_name"]);
    
    AssignMentID(self.strContactAddr, [aDataDict objectForKey:@"contact_addr"]);
    
    AssignMentID(self.strCreditRating, [aDataDict objectForKey:@"credit_rating"]);
    BasLongLongToNSString(self.strCreditRating);
    
    AssignMentID(self.strEmail, [aDataDict objectForKey:@"email"]);
    
    AssignMentID(self.strEmpCode, [aDataDict objectForKey:@"empCode"]);
    
    AssignMentID(self.strFaceDomain, [aDataDict objectForKey:@"face_domain"]);
    
    AssignMentID(self.strFaceUrl, [aDataDict objectForKey:@"face_url"]);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BasLongLongToNSString(self.strId);
    
    AssignMentID(self.strIndustryName, [aDataDict objectForKey:@"industry_name"]);
    
    AssignMentID(self.strLoginUserType, [aDataDict objectForKey:@"loginUserType"]);
    
    BasLongLongToNSString(self.strLoginUserType);
    
    AssignMentID(self.strNickName, [aDataDict objectForKey:@"nickname"]);
    
    AssignMentID(self.strPhone, [aDataDict objectForKey:@"phone"]);
    
    AssignMentID(self.strProvinceCode, [aDataDict objectForKey:@"province_code"]);
    BasLongLongToNSString(self.strProvinceCode);
    
    AssignMentID(self.strSid, [aDataDict objectForKey:@"sid"]);
    BasLongLongToNSString(self.strSid);
    
    AssignMentID(self.strToken, [aDataDict objectForKey:@"token"]);
    
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    BasLongLongToNSString(self.strUid);
    
    AssignMentID(self.strUname, [aDataDict objectForKey:@"uname"]);
    
    AssignMentID(self.strUserCore, [aDataDict objectForKey:@"user_score"]);
    BasLongLongToNSString(self.strUserCore);
    NSArray *storeArry = [aDataDict objectForKey:@"storeList"];
    if(storeArry && storeArry.count>0)
    {
        [self.storeList removeAllObjects];
        for(NSDictionary *storeDict in storeArry)
        {
            StoreMode *sMode = [[StoreMode alloc] init];
            [sMode unPacketData:storeDict];
            [self.storeList addObject:sMode];
        }
    }
}
@end




@implementation StoreMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strContactAddr, [aDataDict objectForKey:@"contact_addr"]);
    
    AssignMentID(self.strContactName, [aDataDict objectForKey:@"contact_name"]);
    
    AssignMentID(self.strContactPhone, [aDataDict objectForKey:@"contact_phone"]);
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BasLongLongToNSString(self.strId);
    
    AssignMentID(self.strStoreName, [aDataDict objectForKey:@"store_name"]);
    
    AssignMentID(self.strStoreType, [aDataDict objectForKey:@"store_type"]);
    
}
@end

