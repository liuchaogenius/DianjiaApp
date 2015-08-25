//
//  KCYJMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCYJMode : NSObject
@property (nonatomic, strong) NSString *strId;//商家id
@property (nonatomic, strong) NSString *strUid;//店铺id
@property (nonatomic, strong) NSString *strSid;
@property (nonatomic, strong) NSString *strStoreName;//店铺名称
@property (nonatomic, strong) NSString *strWrningCount;//告警商品数量
@property (nonatomic, strong) NSString *strProductId;
@property (nonatomic, strong) NSString *strProductName;//商品名称
@property (nonatomic, strong) NSString *strStockQty;//统计时剩余库存
@property (nonatomic, strong) NSString *strSaleRate;//销售速率
@property (nonatomic, strong) NSString *strSaleDays;//剩余库存预计销售完成天数
@property (nonatomic, strong) NSString *strSaleNum;//统计时销售数量

@property (nonatomic, strong) NSString *strStockMoney;//小计成本
@property (nonatomic, strong) NSString *strSumStockMoney;//总成本
@property (nonatomic, strong) NSString *strProductItemNum;//滞销商品种类

@end

@interface KCYJListMode : NSObject
@property (nonatomic, strong) NSMutableArray *kcyjModeArry;
@property (nonatomic, strong) NSString *strAutoCount;
@property (nonatomic, strong) NSString *strNeedPage;
@property (nonatomic, strong) NSString *strOrder;
@property (nonatomic, strong) NSString *strOrderBy;
@property (nonatomic, strong) NSString *strPageNo;
@property (nonatomic, strong) NSString *strPageSize;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface StoreTockList : NSObject
@property (nonatomic, strong) NSMutableArray *storeStockArry;
- (void)unPacketData:(NSArray *)aDataDictArry;
@end

@interface StoreTockMode :NSObject

@property (nonatomic, strong) NSString *strDayTotal;

@property (nonatomic, strong) NSString *strMonthTotal;

@property (nonatomic, strong) NSString *strSaleMoney;

@property (nonatomic, strong) NSString *strSid;

@property (nonatomic, strong) NSString *strStockMoney;

@property (nonatomic, strong) NSString *strStockQty;

@property (nonatomic, strong) NSString *strStoreName;

@property (nonatomic, strong) NSString *strUid;

@property (nonatomic, strong) NSString *strWeekTotal;

- (void)unPacketData:(NSDictionary *)aDataDict;
@end