//
//  DJCheckCartItemComponent.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger{
    DJCheckItemStateNormal = 0, //正常
    DJCheckItemStateMuch,       //盘亏
    DJCheckItemStateLess,       //盘盈
    DJCheckItemStateNotCheck    //未盘点
}DJCheckItemState;

@protocol DJCheckCartItemComponent <NSObject>

@property (nonatomic, strong) NSString      *checkId;
@property (nonatomic, strong) NSString      *sid;
@property (nonatomic, strong) NSString      *productId;
@property (nonatomic, strong) NSString      *productName;
@property (nonatomic, strong) NSString      *productCode;
@property (nonatomic, strong) NSString      *storeStockId;
@property (nonatomic, assign) NSUInteger    stockQuanity;
@property (nonatomic, assign) NSUInteger    stayQuanity;
@property (nonatomic, assign) NSUInteger    checkQuanity;
@property (nonatomic, strong) NSString      *lastCheckTime;
@property (nonatomic, strong) NSString      *checkName;
@property (nonatomic, assign) DJCheckItemState      checkState;

- (NSString *)checkStateString;
- (NSDictionary *)dataDictionary;
- (instancetype)initWithData: (NSDictionary *)data;

@end

@interface DJCheckCartItemComponent : NSObject<DJCheckCartItemComponent>


@end
