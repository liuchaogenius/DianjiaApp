//
//  GysMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "GysMode.h"

@implementation GysMode
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
    
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strId);
    
}
@end

@implementation GysModeList

- (instancetype)init
{
    if(self = [super init]){
        self.modeList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSArray *)aDataDictArry
{
    for(NSDictionary *dict in aDataDictArry)
    {
        GysMode *mode = [[GysMode alloc] init];
        [mode unPacketData:dict];
        [self.modeList addObject:mode];
    }
}

@end


