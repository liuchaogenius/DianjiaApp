//
//  DJCheckCartContext.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJCheckCartItemComponent.h"

@interface DJCheckCartProcessor: NSObject

@end

@interface DJCheckCartContext : NSObject

- (void)registActionHandler:(DJCheckCartAxtionHandler)sHandler
              forActionType: (DJCheckCartActionType)typeKey;

- (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item;

- (void)removeAllItemComponents ;

- (NSMutableArray<DJCheckCartItemComponent> *)chekCartItemComponents;

- (DJCheckCartAxtionHandler)actionHandlerWithActionType: (DJCheckCartActionType)type;

- (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components;

@end
