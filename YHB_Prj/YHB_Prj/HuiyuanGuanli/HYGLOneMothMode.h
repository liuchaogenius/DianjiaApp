//
//  HYGLOneMothMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYGLOneMothMode : NSObject
@property (nonatomic, strong) NSString *strCardUserNum;

@property (nonatomic, strong) NSString *strDiscountRate;

@property (nonatomic, strong) NSString *strEid;

@property (nonatomic, strong) NSString *strEmpName;

@property (nonatomic, strong) NSString *strid;

@property (nonatomic, strong) NSString *strLoginName;

@property (nonatomic, strong) NSString *strOrderTime;

@property (nonatomic, strong) NSString *strPayAbleMoney;

@property (nonatomic, strong) NSString *strProductCode;

@property (nonatomic, strong) NSString *strProductId;

@property (nonatomic, strong) NSString *strProductName;

@property (nonatomic, strong) NSString *strRealMoney;

@property (nonatomic, strong) NSString *strSaleId;

@property (nonatomic, strong) NSString *strSaleNum;

@property (nonatomic, strong) NSString *strSalePrice;

@property (nonatomic, strong) NSString *strSid;

@property (nonatomic, strong) NSString *strSrl;

@property (nonatomic, strong) NSString *strSrlStatus;

@property (nonatomic, strong) NSString *strStockPrice;

@property (nonatomic, strong) NSString *strStoreName;

@property (nonatomic, strong) NSString *strUid;
@end

@interface HYGLOneMothTimeList : NSObject
@property (nonatomic, strong) NSMutableArray *oneMothDataArry;
@property (nonatomic, strong) NSString *strOrderTime;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface HYGLDataModeList : NSObject
@property (nonatomic, strong) NSMutableArray *HYGLDataArry;
- (void)unPacketData:(NSDictionary *)adataDict;
@end

