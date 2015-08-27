//
//  HYGLManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VipInfoList;
@class VipInfoMode;
@class HYGLDataModeList;
@interface HYGLManager : NSObject
- (void)appGetAllVip:(void(^)(VipInfoList *modeList))aFinishBlock;
- (void)appGetVipDetailByVid:(NSString *)aVipId
                 finishBlock:(void(^)(VipInfoMode *mode))aFinishBlock;

- (void)getVipSaleOneMonth:(NSString *)aVipId
               finishBlock:(void(^)(HYGLDataModeList *mode))aFinishBlock;
@end
