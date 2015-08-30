//
//  DJCheckCartEngine.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJCheckCartEngine.h"
#import "DJCheckCartContexManager.h"
#import "DJCheckCartNetService.h"
#import "JSONKit.h"
#import "DJProductCheckManager.h"

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
    [self registSuccessActionHandler:sHandler failHandler:nil forActionType:typeKey];
}

+ (void)registSuccessActionHandler:(DJCheckCartAxtionHandler)sHandler
                       failHandler:(DJCheckCartAxtionHandler)fHandler
                     forActionType: (DJCheckCartActionType)typeKey {
    [DJCheckCartContexManager registSuccessActionHandler:[sHandler copy] failHandler:[fHandler copy] forActionType:typeKey];
}

+ (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item
                      withStoreId:(NSString *)storeId {
    if (!item) {
        return;
    }
    [DJCheckCartContexManager addCheckCartItemComponent:item withStoreId:storeId];
}

+ (NSArray<DJCheckCartItemComponent> *)chekCartItemComponents {
    return [DJCheckCartContexManager chekCartItemComponents];
}

+ (void)deleteCheckCartItemComponents: (id<DJCheckCartItemComponent>)item; {
    
}

+ (void)submitCheckCartItemComponents {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[DJCheckCartContexManager chekCartItemComponents].count];
    for (id<DJCheckCartItemComponent> item in [DJCheckCartContexManager chekCartItemComponents])
    {
        [array addObject:[item dataDictionary]];
    };
    [DJProductCheckManager submitProductChecksWithCheckDicArray:array success:^(id resultModel) {
        
    } fail:^(id msg) {
        
    }];
    
}


@end
