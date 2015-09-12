//
//  DJCheckCartProcessorManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJCheckCartContexManager.h"
#import "DJCheckCartContext.h"

@interface DJCheckCartContexManager ()

@property (nonatomic, strong) NSMutableDictionary *contextDic;
@property (nonatomic, strong) NSString *currentStoreId;

@end

@implementation DJCheckCartContexManager

+ (instancetype)sharedManager{
    static id pManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pManage = [[[self class] alloc] init];
    });
    return pManage;
}

- (instancetype)init {
    if (self = [super init]) {
        self.contextDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return self;
}

+ (void)switchStore: (NSString *)storeId {
    if (!storeId) {
        return;
    }
    [[self sharedManager] setCurrentStoreId: storeId];
    if (![[self sharedManager] contextDic][storeId]) {
        DJCheckCartContext *context = [[DJCheckCartContext alloc] init];
        [[self sharedManager] contextDic][storeId] = context;
    }
}

+ (DJCheckCartContext *)currentContex {
    return [[[self sharedManager] contextDic] objectForKey:[[self sharedManager] currentStoreId]];
}

+ (void)registActionHandler:(DJCheckCartAxtionHandler)sHandler
              forActionType: (DJCheckCartActionType)typeKey {
    [[self currentContex] registActionHandler:sHandler forActionType:typeKey];
}

+ (DJCheckCartAxtionHandler)actionHandlerWithActionType: (DJCheckCartActionType)type {
    return [[self currentContex] actionHandlerWithActionType:type];
}

+ (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item
                      withStoreId:(NSString *)storeId
{
    if ([storeId integerValue] == 0) {
        return;
    }
    [item setSid:storeId];
    [[[[self sharedManager] contextDic] objectForKey:storeId] addCheckCartItemComponent:item];
}

+ (NSArray<DJCheckCartItemComponent> *)chekCartItemComponents {
    return [[self currentContex] chekCartItemComponents];
}

+ (void)removeAllItemComponentsWithStoreId:(NSString *)storeId {
    [[[[self sharedManager] contextDic] objectForKey:storeId] removeAllItemComponents];
}

+ (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components {
    [[self currentContex] setCheckCartItemComponents:components];
}
+ (void)deleteCheckCartItemComponents: (id<DJCheckCartItemComponent>)item {
    [[[self currentContex] chekCartItemComponents] removeObject:item];
}

@end
