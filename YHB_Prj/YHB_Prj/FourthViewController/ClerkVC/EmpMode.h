//
//  EmpMode.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/2.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmpMode : NSObject

@property (nonatomic, strong) NSString *strbirthday;
@property (nonatomic, strong) NSString *stremp_detail;
@property (nonatomic, strong) NSString *stremp_name;
@property (nonatomic, strong) NSString *stremp_priv;
@property (nonatomic, strong) NSString *stremp_sex;
@property (nonatomic, strong) NSString *stremp_type;
@property (nonatomic, strong) NSString *stremp_type_name;
@property (nonatomic, strong) NSString *strid;
@property (nonatomic, strong) NSString *strlogin_name;
@property (nonatomic, strong) NSString *strpassword;
@property (nonatomic, strong) NSString *strphone;
@property (nonatomic, strong) NSString *strqq;
@property (nonatomic, strong) NSString *strsid;
@property (nonatomic, strong) NSString *strstore_name;
@property (nonatomic, strong) NSString *strweixin;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface EmpModeList : NSObject

@property (nonatomic, strong) NSMutableArray *empList;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end
