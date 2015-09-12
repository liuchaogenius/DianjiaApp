//
//  XSLSMode.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSLSMode : NSObject
@property (nonatomic, strong) NSString *strCard_use_num;

@property (nonatomic, strong) NSString *strDiscount_rate;

@property (nonatomic, strong) NSString *strEid;

@property (nonatomic, strong) NSString *strEmp_name;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strLogin_name;

@property (nonatomic, strong) NSString *strOrder_time;

@property (nonatomic, strong) NSString *strPayable_money;

@property (nonatomic, strong) NSString *strProduct_code;

@property (nonatomic, strong) NSString *strProduct_id;

@property (nonatomic, strong) NSString *strProduct_name;

@property (nonatomic, strong) NSString *strReal_money;

@property (nonatomic, strong) NSString *strSale_id;

@property (nonatomic, strong) NSString *strSale_num;

@property (nonatomic, strong) NSString *strSale_price;

@property (nonatomic, strong) NSString *strSid;

@property (nonatomic, strong) NSString *strSrl;

@property (nonatomic, strong) NSString *strSrl_status;

@property (nonatomic, strong) NSString *strStock_price;

@property (nonatomic, strong) NSString *strStore_name;

@property (nonatomic, strong) NSString *strUid;

- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface XSLSList : NSObject
@property (nonatomic, strong) NSMutableArray *productList;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end
