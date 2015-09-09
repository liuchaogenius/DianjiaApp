//
//  SPGLCategoryMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPGLCategoryMode : NSObject
@property (nonatomic, strong) NSString *strCateName;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *strPid;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface SPGLCategoryIndexList : NSObject
@property (nonatomic, strong) NSMutableArray *modeSectionArry;
@property (nonatomic, strong) NSMutableArray *modeIndexArry;

- (void)unPacketData:(NSArray *)aDataDictArry;
@end