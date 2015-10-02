//
//  DJCheckCartItemComponent.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJCheckCartItemComponent.h"

@interface DJCheckCartItemComponent()
{
     NSString      *_productId;
     NSString       *_productName;
     NSUInteger    _stockQuanity;
     NSUInteger    _stayQuanity;
     NSUInteger    _checkQuanity;
     NSString       *_lastCheckTime;
     DJCheckItemState _checkState;
     NSString       *_sid;
    NSString       *_checkId;
    NSString       *_checkName;
    NSString       *_storeStockId;
}
@end

@implementation DJCheckCartItemComponent
@synthesize productId = _productId,productName = _productName,stockQuanity = _stockQuanity,stayQuanity = _stayQuanity,checkQuanity = _checkQuanity,checkId = _checkId,lastCheckTime = _lastCheckTime,checkState = _checkState,sid = _sid,checkName = _checkName,storeStockId = _storeStockId,productCode = _productCode;

- (instancetype)initWithData: (NSDictionary *)data {
    if (self = [super init]) {
        self.sid = data[@"sid"];
        self.productId = data[@"product_id"];
        self.productName = data[@"product_name"];
        self.productCode = data[@"product_code"];
        self.storeStockId = data[@"store_stock_id"];
        self.stockQuanity = [data[@"stock_qty"] integerValue];
        self.stayQuanity = [data[@"stay_qty"] integerValue];
        self.lastCheckTime = data[@"last_ck_time"];
        self.checkQuanity = [data[@"chek_qty"] integerValue];
        self.checkName = data[@"check_name"];
    }
    return self;
}

- (NSDictionary *)dataDictionary {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    data[@"sid"] = self.sid?:@"";
    data[@"product_id"] = self.productId?:@"";
//    data[@"product_name"] = self.productName?:@"";
//    data[@"product_code"] = self.productCode?:@"";
//    data[@"store_stock_id"] = self.storeStockId?:@"";
    data[@"stock_qty"] = @(self.stockQuanity);
    data[@"stay_qty"] = @(self.stayQuanity);
//    data[@"last_ck_time"] = self.lastCheckTime?:@"";
    data[@"chek_qty"] = @(self.checkQuanity);
    data[@"check_name"] = self.checkName?:@"";
    
    return data;
}

- (void)setCheckQuanity:(NSUInteger)checkQuanity {
    _checkQuanity = checkQuanity;
    if (_checkQuanity == _stockQuanity + _stayQuanity) {
        _checkState = DJCheckItemStateNormal;
    }else if (_checkQuanity < _stockQuanity + _stayQuanity) {
        _checkState = DJCheckItemStateLess;
    }else {
        _checkState = DJCheckItemStateMuch;
    }
}

- (NSString *)checkStateString {
    switch (self.checkState) {
        case DJCheckItemStateNormal:
            return @"正常";
            break;
        case DJCheckItemStateLess:
            return @"盘亏";
            break;
        case DJCheckItemStateMuch:
            return @"盘盈";
            break;
        default:
            return @"";
            break;
    }
}

@end
