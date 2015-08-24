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
@end

