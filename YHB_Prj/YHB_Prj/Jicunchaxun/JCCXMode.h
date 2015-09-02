//
//  JCCXMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCCXMode : NSObject
@property (nonatomic, strong) NSString *strEmpName;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strLoginName;

@property (nonatomic, strong) NSString *strOrderTimer;

@property (nonatomic, strong) NSString *strPinyinCode;

@property (nonatomic, strong) NSString *strProductCode;

@property (nonatomic, strong) NSString *strProductId;

@property (nonatomic, strong) NSString *strProductName;

@property (nonatomic, strong) NSString *strRemark;

@property (nonatomic, strong) NSString *strStatus;

@property (nonatomic, strong) NSString *strStayId;

@property (nonatomic, strong) NSString *strStoreName;

@property (nonatomic, strong) NSString *strSurplusNum;

@property (nonatomic, strong) NSString *strSrplusSum;

@property (nonatomic, strong) NSString *strTakeNum;

@property (nonatomic, strong) NSString *strTotalNum;

@property (nonatomic, strong) NSString *strVipCode;

@property (nonatomic, strong) NSString *strVipId;

@property (nonatomic, strong) NSString *strVipName;

@property (nonatomic, strong) NSString *strVipPhone;
@end

@interface JCCXModeList : NSObject
@property (nonatomic, strong) NSMutableArray *modeList;
- (void)unPacketData:(NSArray *)aDataDictArry;
@end

