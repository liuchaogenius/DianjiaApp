//
//  YDCXMode.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YDCXMode.h"

@implementation YDCXMode

- (instancetype)init
{
    if(self = [super init]){
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
}

@end

@implementation YDCXModeList

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
            YDCXMode *moce = [[YDCXMode alloc] init];
            [moce unPacketData:dict];
            [self.modeList addObject:moce];
        }
    }
}
@end
