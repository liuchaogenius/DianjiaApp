//
//  RKSPMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKSPMode : NSObject
@property (nonatomic, strong) NSString *strAddDate;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *strProductId;
@property (nonatomic, strong) NSString *strProductName;
@property (nonatomic, strong) NSString *strSalePrice;
@property (nonatomic, strong) NSString *strShelfDys;
@property (nonatomic, strong) NSString *strStayQty;
@property (nonatomic, strong) NSString *strStockNum;
@property (nonatomic, strong) NSString *strStockPrice;
@property (nonatomic, strong) NSString *strStockQty;
@property (nonatomic, strong) NSString *strStoreName;
@property (nonatomic, strong) NSString *strSupName;
@end

@interface RKSPModeList : NSObject
@property (nonatomic, strong) NSMutableArray *rksModeArry;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *strStatus;
@property (nonatomic, strong) NSString *strStatusDesc;
@property (nonatomic, strong) NSString *strOrderTime;
@property (nonatomic, strong) NSString *strCounterfoilUrl;
@property (nonatomic, strong) NSString *strStoreName;
@property (nonatomic, strong) NSString *strSupId;
@property (nonatomic, strong) NSString *strSupName;
@property (nonatomic, strong) NSString *strTotalRealPay;
@property (nonatomic, strong) NSString *strStockNum;
@property (nonatomic, strong) NSString *strSid;
@end

@interface RKSPModeListList : NSObject
@property (nonatomic, strong) NSMutableArray *rksModeArryArry;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

