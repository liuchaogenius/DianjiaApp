//
//  PGProductMode.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGProductList : NSObject
@property (nonatomic, strong) NSMutableArray *productList;
- (void)unPacketData:(NSDictionary *)aDataDict;

@end
