//
//  YDCXMode.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDCXMode : NSObject

@end

@interface YDCXModeList : NSObject
@property (nonatomic, strong) NSMutableArray *modeList;
- (void)unPacketData:(NSArray *)aDataDictArry;
@end
