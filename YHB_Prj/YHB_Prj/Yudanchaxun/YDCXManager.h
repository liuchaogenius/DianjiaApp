//
//  YDCXManager.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VipCerditStatus) {
    VipCerditStatusAll=0,
    VipCerditStatusNo,
    VipCerditStatusYes
};

@interface YDCXManager : NSObject
- (void)appGetVipCerditListArr:(int)aStatus isRefresh:(BOOL)aIsRefresh finishBlock:(void (^)(NSArray *))aFinishBlock;
- (void)setCurrentVipid:(NSString *)aVipId;
- (void)setStartTime:(NSString *)aStartTime;
- (void)setEndTime:(NSString *)aEndTime;
- (void)setCurrentSid:(NSString *)aSid;
@end
