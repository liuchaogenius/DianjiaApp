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
@property (nonatomic, strong) NSMutableDictionary   *actionBlockDic;
//@property (nonatomic, strong) NSMutableDictionary   *failActionBlockDic;

@end

@implementation DJCheckCartContext
#pragma mark - getter and setter
- (NSMutableDictionary *)actionBlockDic {
    if (!_actionBlockDic) {
        _actionBlockDic = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _actionBlockDic;
}

- (void)registActionHandler:(DJCheckCartAxtionHandler)sHandler
              forActionType: (DJCheckCartActionType)typeKey {
    if (sHandler) {
        self.actionBlockDic[@(typeKey)] = [sHandler copy];
    }

}

- (DJCheckCartAxtionHandler)actionHandlerWithActionType: (DJCheckCartActionType)type {
    return self.actionBlockDic[@(type)];
}

- (void)addCheckCartItemComponent:(id<DJCheckCartItemComponent>)item {
    id<DJCheckCartItemComponent> removeItem = nil;
    for (id<DJCheckCartItemComponent> citem in self.chekCartItemComponents) {
        if ([citem.productId isEqualToString:item.productId]) {
            removeItem = item;
            break;
        }
    }
    if (removeItem) {
        [self.chekCartItemComponents removeObject:removeItem];
    }
    if (!self.itemComponents) {
        self.itemComponents = ( NSMutableArray<DJCheckCartItemComponent> *)[NSMutableArray array];
    }
    [self.itemComponents addObject:item];
}

- (NSMutableArray<DJCheckCartItemComponent> *)chekCartItemComponents {
    return self.itemComponents;
}

- (void)removeAllItemComponents {
    [self.itemComponents removeAllObjects];
}

- (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components {
    [self.itemComponents removeAllObjects];
    [self.itemComponents addObjectsFromArray:components];
}

@end
