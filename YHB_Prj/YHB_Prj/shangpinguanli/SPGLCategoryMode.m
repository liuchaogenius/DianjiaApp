//
//  SPGLCategoryMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLCategoryMode.h"

@implementation SPGLCategoryMode
- (void)unPacketData:(NSDictionary *)aDataDict
{
    AssignMentID(self.strCateName, [aDataDict objectForKey:@"CateName"]);
    AssignMentID(self.strPid, [aDataDict objectForKey:@"pid"]);
    BaseIntToNSString(self.strPid);
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
}
@end

@implementation SPGLCategoryIndexList

-(instancetype)init
{
    if(self=[super init])
    {
        self.modeIndexArry = [NSMutableArray arrayWithCapacity:0];
        self.modeSectionArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSArray *)aDataDictArry
{
    if(aDataDictArry && aDataDictArry.count >0)
    {
        for(NSDictionary *dict in aDataDictArry)
        {
            SPGLCategoryMode *mode = [[SPGLCategoryMode alloc] init];
            [mode unPacketData:dict];
            if([mode.strPid intValue] == 0)
            {
                [self.modeSectionArry addObject:mode];
            }
            else
            {
                [self.modeIndexArry addObject:mode];
            }
        }
    }
}
@end


