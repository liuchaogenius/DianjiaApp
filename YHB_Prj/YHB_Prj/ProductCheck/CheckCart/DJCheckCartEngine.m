//
//  DJCheckCartEngine.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJCheckCartEngine.h"
#import "DJCheckCartContexManager.h"
#import "JSONKit.h"
#import "DJProductCheckManager.h"
#import "AFNetworking.h"

@implementation DJCheckCartEngine

+ (instancetype)sharedEngine{
    static id engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[[self class] alloc] init];
    });
    return engine;
}

+ (void)switchEngineWithStoreId: (NSString *)storeId {
    if (!storeId || [storeId integerValue] == 0) {
        return;
    }
    [DJCheckCartContexManager switchStore:storeId];
}

+ (void)registActionHandler:(DJCheckCartAxtionHandler)sHandler forActionTyp: (DJCheckCartActionType)typeKey {
    [DJCheckCartContexManager registActionHandler:[sHandler copy] forActionType:typeKey];
}

+ (DJCheckCartAxtionHandler)actionHandlerWIthType: (DJCheckCartActionType)typeKey {
    return [DJCheckCartContexManager actionHandlerWithActionType:typeKey];
}

+ (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item
                      withStoreId:(NSString *)storeId {
    if (!item) {
        return;
    }
    [DJCheckCartContexManager addCheckCartItemComponent:item withStoreId:storeId];
    [[NSNotificationCenter defaultCenter] postNotificationName:DJCheckCartDataChangedNotification object:nil];
}

+ (NSArray<DJCheckCartItemComponent> *)chekCartItemComponents {
    return [DJCheckCartContexManager chekCartItemComponents];
}

+ (void)deleteCheckCartItemComponents: (id<DJCheckCartItemComponent>)item {
    if (!item) {
        return;
    }
    [DJCheckCartContexManager deleteCheckCartItemComponents:item];
    [[NSNotificationCenter defaultCenter] postNotificationName:DJCheckCartDataChangedNotification object:nil];
}

+ (void)submitCheckCartItemComponentsWithStoreId:(NSString *)storeId {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[DJCheckCartContexManager chekCartItemComponents].count];
    DJCheckCartAxtionHandler sHandler = [self actionHandlerWIthType:DJCheckCartActionTypeSubmitChecksSuccess];
    DJCheckCartAxtionHandler fHandler = [self actionHandlerWIthType:DJCheckCartActionTypeSubmitFail];
    DJCheckCartAxtionHandler reCheckHandler = [self actionHandlerWIthType:DJCheckCartActionTypeSubmitChecksNeedRechack];
    
    for (id<DJCheckCartItemComponent> item in [DJCheckCartContexManager chekCartItemComponents])
    {
        [array addObject:[item dataDictionary]];
    };
    [DJProductCheckManager submitProductChecksWithCheckDicArray:array success:^(NSArray *result) {
        [DJCheckCartContexManager removeAllItemComponentsWithStoreId:storeId];
        if (result.count) {
            [result enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                id<DJCheckCartItemComponent> item = [[DJCheckCartItemComponent alloc] initWithData:obj];
                [DJCheckCartContexManager addCheckCartItemComponent:item withStoreId:storeId];
            }];
            if (reCheckHandler) {
                reCheckHandler(nil);
            }
        }else {
            if (sHandler) {
                sHandler(nil);
            }
        }

    } fail:^(id msg) {
        if (fHandler) {
            fHandler(nil);
        }
    }];
    
}


@end
