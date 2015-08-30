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

+ (void)registSuccessActionHandler:(DJCheckCartAxtionHandler)sHandler
                       failHandler:(DJCheckCartAxtionHandler)fHandler
                     forActionType: (DJCheckCartActionType)typeKey;

+ (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item
                      withStoreId:(NSString *)storeId;

+ (NSArray<DJCheckCartItemComponent> *)chekCartItemComponents;

+ (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components;

+ (void)deleteCheckCartItemComponents: (id<DJCheckCartItemComponent>)item;

@end
