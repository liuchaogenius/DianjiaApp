//
//  DJCheckCartContext.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJCheckCartContext.h"
#import "DJCheckCartItemComponent.h"

@interface DJCheckCartProcessor()

@end

@implementation DJCheckCartProcessor

@end

@interface DJCheckCartContext()

@property (nonatomic, strong) NSString              *storeId;
@property (nonatomic, strong) NSMutableArray<DJCheckCartItemComponent> *itemComponents;
@property (nonatomic, strong) DJCheckCartProcessor  *processor;
@property (nonatomic, strong) NSMutableDictionary   *successActionBlockDic;
@property (nonatomic, strong) NSMutableDictionary   *failActionBlockDic;

@end

@implementation DJCheckCartContext
#pragma mark - getter and setter
- (NSMutableDictionary *)successActionBlockDic {
    if (!_successActionBlockDic) {
        _successActionBlockDic = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _successActionBlockDic;
}

- (NSMutableDictionary *)failActionBlockDic {
    if (!_failActionBlockDic) {
        _failActionBlockDic = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _failActionBlockDic;
}

- (void)registSuccessActionHandler:(DJCheckCartAxtionHandler)sHandler
                       failHandler:(DJCheckCartAxtionHandler)fHandler
                     forActionType: (DJCheckCartActionType)typeKey {
    if (sHandler) {
        self.successActionBlockDic[@(typeKey)] = sHandler;
    }
    if (fHandler) {
        self.failActionBlockDic[@(typeKey)] = fHandler;
    }
}

- (void)addCheckCartItemComponent:(id<DJCheckCartItemComponent>)item {
    for (id<DJCheckCartItemComponent> citem in self.chekCartItemComponents) {
        if ([citem.productId isEqualToString:item.productId]) {
            [self.chekCartItemComponents removeObject:citem];
        }
    }
    [self.itemComponents addObject:item];
}

- (NSMutableArray<DJCheckCartItemComponent> *)chekCartItemComponents {
    return self.itemComponents;
}

- (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components {
    [self.itemComponents removeAllObjects];
    [self.itemComponents addObjectsFromArray:components];
}

@end
