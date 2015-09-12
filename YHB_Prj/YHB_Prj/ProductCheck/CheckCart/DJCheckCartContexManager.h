//
//  DJCheckCartProcessorManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DJCheckCartItemComponent;

@interface DJCheckCartContexManager : NSObject

+ (void)switchStore: (NSString *)storeId;

+ (void)registActionHandler:(DJCheckCartAxtionHandler)sHandler
              forActionType: (DJCheckCartActionType)typeKey;

+ (DJCheckCartAxtionHandler)actionHandlerWithActionType: (DJCheckCartActionType)type;

+ (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item
                      withStoreId:(NSString *)storeId;

+ (NSArray<DJCheckCartItemComponent> *)chekCartItemComponents;

+ (void)removeAllItemComponentsWithStoreId:(NSString *)storeId;

+ (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components;

+ (void)deleteCheckCartItemComponents: (id<DJCheckCartItemComponent>)item;

@end
