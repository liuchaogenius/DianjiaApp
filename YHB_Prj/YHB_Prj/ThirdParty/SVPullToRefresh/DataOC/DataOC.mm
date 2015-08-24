//
//  DataOC.m
//  TaoJie
//
//  Created by 超 刘 on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataOC.h"
#import "DataCenterDeal.h"
@implementation DataOC


+(NSString*)getTimeString:(long)puData
{
    return [NSString stringWithUTF8String:GetTimestr(puData).c_str()];
}
@end
