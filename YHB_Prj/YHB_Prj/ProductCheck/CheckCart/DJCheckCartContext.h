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

- (void)registSuccessActionHandler:(DJCheckCartAxtionHandler)sHandler
                       failHandler:(DJCheckCartAxtionHandler)fHandler
                     forActionType: (DJCheckCartActionType)typeKey;

- (void)addCheckCartItemComponent: (id<DJCheckCartItemComponent>)item;

- (NSMutableArray<DJCheckCartItemComponent> *)chekCartItemComponents;

- (void)setCheckCartItemComponents: (NSArray<DJCheckCartItemComponent> *)components;

@end
