//
//  DJCheckCartPublic.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#ifndef YHB_Prj_DJCheckCartPublic_h
#define YHB_Prj_DJCheckCartPublic_h
//数据发生变化 通知
#define DJCheckCartDataChangedNotification @"cartChange"

typedef void (^DJCheckCartAxtionHandler)(id model);

typedef NS_ENUM(NSUInteger, DJCheckCartActionType) {
    DJCheckCartActionTypeSubmitChecksSuccess = 0,
    DJCheckCartActionTypeSubmitChecksNeedRechack,
    DJCheckCartActionTypeSubmitFail
};

#endif
