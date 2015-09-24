//
//  WYJHMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPGLProductMode;

@interface WYJHMode : NSObject
@property (nonatomic, strong) NSString *strAddDate;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strMakeDate;

@property (nonatomic, strong) NSString *strProductCode;

@property (nonatomic, strong) NSString *strProductId;

@property (nonatomic, strong) NSString *strProductName;

@property (nonatomic, strong) NSString *strSalePrice;

@property (nonatomic, strong) NSString *strShelfDys;

@property (nonatomic, strong) NSString *strStayQty;

@property (nonatomic, strong) NSString *strStockNum;

@property (nonatomic, strong) NSString *strStockPrice;

@property (nonatomic, strong) NSString *strStockQty;

@property (nonatomic, strong) NSString *strStoreName;

@property (nonatomic, strong) NSString *strSupId;

@property (nonatomic, strong) NSString *strSupName;

- (instancetype)initWithProductMode:(SPGLProductMode *)aProductMode;
@end

@interface WYJHModeList : NSObject
@property (nonatomic, strong) NSString *strAccountType;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strOrderFromName;

@property (nonatomic, strong) NSString *strOrderTime;

@property (nonatomic, strong) NSString *strSid;

@property (nonatomic, strong) NSString *strSrl;

@property (nonatomic, strong) NSString *strStatus;

@property (nonatomic, strong) NSString *strStatusStr;

@property (nonatomic, strong) NSString *strStockNum;

@property (nonatomic, strong) NSString *strStockName;

@property (nonatomic, strong) NSString *strSupid;

@property (nonatomic, strong) NSString *strSupName;

@property (nonatomic, strong) NSString *strTotalRealPay;

@property (nonatomic, strong) NSString *strEmpStockId;

@property (nonatomic, strong) NSMutableArray *modeListArry;
@end

@interface WYJHModeRows : NSObject
@property (nonatomic, strong) NSMutableArray *modeRowsArry;

- (void)unPacketData:(NSDictionary *)aDataDict;
@end


