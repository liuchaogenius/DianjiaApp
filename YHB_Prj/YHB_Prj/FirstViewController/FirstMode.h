//
//  FirstMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SaleSrlStatisticMode;
@class SummaryStoreStockMode;
@class HomePageInfoAppMode;
@interface FirstMode : NSObject
@property (nonatomic, strong) SaleSrlStatisticMode *ssMode;
@property (nonatomic, strong) SummaryStoreStockMode *sumMode;
@property (nonatomic, strong) HomePageInfoAppMode *homeInfoMode;
@end


@interface SaleSrlStatisticMode : NSObject

@property (nonatomic, strong) NSString *strSaleCount;//销售单数
@property (nonatomic, strong) NSString *strRealMoney;//实际销售总金额
@property (nonatomic, strong) NSString *strStockMoney;//进货总金额
@property (nonatomic, strong) NSString *strProFitMoney;//盈利总金额

- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface SummaryStoreStockMode :NSObject

@property (nonatomic, strong) NSString *strUid;//商家id
@property (nonatomic, strong) NSString *strSid;//店铺id
@property (nonatomic, strong) NSString *strStoreName;
@property (nonatomic, strong) NSString *strStockQty;//库存总数量
@property (nonatomic, strong) NSString *strStockMoney;//库存总销售价
@property (nonatomic, strong) NSString *strSaleMoney;//库存总销售价
@property (nonatomic, strong) NSString *strJZLS;//今天流水（元）
@property (nonatomic, strong) NSString *strBZLS;//本周流水
@property (nonatomic, strong) NSString *strBYLS;//本月流水

- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface HomePageInfoAppMode :NSObject

@property (nonatomic, strong) NSString *strStockWarnPCount;//库存预警商品数量
@property (nonatomic, strong) NSString *strSaleWarnPCount;//滞销商品数量
@property (nonatomic, strong) NSString *strPreviousDayTotal;//昨天流水（元）
@property (nonatomic, strong) NSString *strPreviousWeekTotal;//上周流水（元）
@property (nonatomic, strong) NSString *strPreviousMonthTotal;//上月流水（元）

- (void)unPacketData:(NSDictionary *)aDataDict;
@end
