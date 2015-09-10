//
//  PGProductMode.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "PGProductList.h"
#import "SPGLProductMode.h"

@implementation PGProductList

- (instancetype)init
{
    if(self = [super init]){
        self.productList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *arry = [aDataDict objectForKey:@"rows"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            SPGLProductMode *mode = [[SPGLProductMode alloc] init];
            [mode unPacketData:dict];
            [self.productList addObject:mode];
        }
    }
}


@end
