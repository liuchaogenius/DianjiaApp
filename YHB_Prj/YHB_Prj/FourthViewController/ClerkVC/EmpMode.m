//
//  SupplierMode.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/1.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "EmpMode.h"

@implementation EmpMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strid, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strid);
    
    AssignMentID(self.strsid, [aDataDict objectForKey:@"sid"]);
    BaseLongLongToNSString(self.strsid);
    
    AssignMentID(self.strbirthday, [aDataDict objectForKey:@"birthday"]);
    
    AssignMentID(self.stremp_detail, [aDataDict objectForKey:@"emp_detail"]);
    
    AssignMentID(self.stremp_name, [aDataDict objectForKey:@"emp_name"]);
    
    AssignMentID(self.stremp_priv, [aDataDict objectForKey:@"emp_priv"]);
    
    AssignMentID(self.stremp_sex, [aDataDict objectForKey:@"emp_sex"]);
    BaseLongLongToNSString(self.stremp_sex);
    
    AssignMentID(self.stremp_type_name, [aDataDict objectForKey:@"emp_type_name"]);
    
    AssignMentID(self.stremp_type, [aDataDict objectForKey:@"emp_type"]);
    BaseLongLongToNSString(self.stremp_type);
    
    AssignMentID(self.strlogin_name, [aDataDict objectForKey:@"login_name"]);
    
    AssignMentID(self.strpassword, [aDataDict objectForKey:@"password"]);
    
    AssignMentID(self.strphone, [aDataDict objectForKey:@"phone"]);
    BaseLongLongToNSString(self.strphone);
    
    AssignMentID(self.strqq, [aDataDict objectForKey:@"qq"]);
    
    AssignMentID(self.strweixin, [aDataDict objectForKey:@"weixin"]);
    
    AssignMentID(self.strstore_name, [aDataDict objectForKey:@"store_name"]);
}

@end

@implementation EmpModeList

- (instancetype)init
{
    if(self = [super init]){
        self.empList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *storeArry = [aDataDict objectForKey:@"result"];
    if(storeArry && storeArry.count>0)
    {
        [self.empList removeAllObjects];
        for(NSDictionary *storeDict in storeArry)
        {
            EmpMode *sMode = [[EmpMode alloc] init];
            [sMode unPacketData:storeDict];
            [self.empList addObject:sMode];
        }
    }
}

@end
