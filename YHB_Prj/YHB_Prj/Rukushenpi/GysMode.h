//
//  GysMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GysMode : NSObject
@property (nonatomic, strong) NSString *strAddress;
@property (nonatomic, strong) NSString *strContact;
@property (nonatomic, strong) NSString *strEmail;
@property (nonatomic, strong) NSString *strFax;
@property (nonatomic, strong) NSString *strRemark;
@property (nonatomic, strong) NSString *strSupName;
@property (nonatomic, strong) NSString *strTel;
@property (nonatomic, strong) NSString *strId;
@end

@interface GysModeList : NSObject
@property (nonatomic, strong) NSMutableArray *modeList;
- (void)unPacketData:(NSArray *)aDataDictArry;
@end

