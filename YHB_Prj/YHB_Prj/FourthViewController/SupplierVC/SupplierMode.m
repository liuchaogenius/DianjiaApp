//
//  SupplierMode.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/1.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SupplierMode.h"

@implementation SupplierMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strAddress, [aDataDict objectForKey:@"Address"]);
    
    AssignMentID(self.strContact, [aDataDict objectForKey:@"Contact"]);
    
    AssignMentID(self.strEmail, [aDataDict objectForKey:@"Email"]);
    
    AssignMentID(self.strFax, [aDataDict objectForKey:@"Fax"]);
    
    AssignMentID(self.strRemark, [aDataDict objectForKey:@"Remark"]);
    
    AssignMentID(self.strSupName, [aDataDict objectForKey:@"SupName"]);
    
    AssignMentID(self.strTel, [aDataDict objectForKey:@"Tel"]);
    BaseLongLongToNSString(self.strTel);

    AssignMentID(self.strid, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strid);
}

@end

@implementation SupplierModeList

- (instancetype)init
{
    if(self = [super init]){
        self.supplierList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *storeArry = [aDataDict objectForKey:@"result"];
    if(storeArry && storeArry.count>0)
    {
        [self.supplierList removeAllObjects];
        for(NSDictionary *storeDict in storeArry)
        {
            SupplierMode *sMode = [[SupplierMode alloc] init];
            [sMode unPacketData:storeDict];
            [self.supplierList addObject:sMode];
        }
    }
}

@end
