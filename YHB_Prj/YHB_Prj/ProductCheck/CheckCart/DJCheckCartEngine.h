//
//  DJCheckCartEngine.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJCheckCartItemComponent.h"

@interface DJCheckCartEngine : NSObject

+ (void)switchEngineWithStoreId: (NSString *)storeId;

+ (void)registActionHandler:(DJCheckCartAxtionHandler)sHandler forActionTyp: (DJCheckCartActionType)typeKey;

+ (void)registSuccessActionHandler:(DJCheckCartAxtionHandler)sHandler
                       failHandler:(DJCheckCartAxtionHandler)fHandler
                     forActionType: (DJCheckCartActionType)typeKey;

+ (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item withStoreId:(NSString *)storeId;

+ (NSArray<DJCheckCartItemComponent> *)chekCartItemComponents;

+ (void)submitCheckCartItemComponents;

+ (void)deleteCheckCartItemComponents: (id<DJCheckCartItemComponent>)item;

@end
