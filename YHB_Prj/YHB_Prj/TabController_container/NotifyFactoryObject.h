//
//  NotifyFactoryObject.h
//  YHB_Prj
//
//  Created by  striveliu on 14/12/3.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifyFactoryObject : NSObject
//注册登录消息
+ (void)registerLoginMsgNotify:(id)aTarget action:(SEL)aSelector;
//注册登录成功的消息
+ (void)registerLoginSuccMsgNotify:(id)aTarget action:(SEL)aSelector;
//注册登录失败的消息
+ (void)registerLoginFailMsgNotify:(id)aTarget action:(SEL)aSelector;
//post 消息
+ (void)postNotifyMessage:(NSString *)aMessageName param:(id)aParam;
@end
