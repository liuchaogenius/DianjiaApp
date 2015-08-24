//
//  NotifyFactoryObject.m
//  YHB_Prj
//
//  Created by  striveliu on 14/12/3.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "NotifyFactoryObject.h"

@implementation NotifyFactoryObject
+ (void)registerLoginMsgNotify:(id)aTarget action:(SEL)aSelector
{
    [[NSNotificationCenter defaultCenter] addObserver:aTarget selector:aSelector name:kLoginForUserMessage object:nil];
}

+ (void)registerLoginSuccMsgNotify:(id)aTarget action:(SEL)aSelector
{
    [[NSNotificationCenter defaultCenter] addObserver:aTarget selector:aSelector name:kLoginSuccessMessae object:nil];
}

+ (void)registerLoginFailMsgNotify:(id)aTarget action:(SEL)aSelector
{
    [[NSNotificationCenter defaultCenter] addObserver:aTarget selector:aSelector name:kLoginFailMessage object:nil];
}

+ (void)postNotifyMessage:(NSString *)aMessageName param:(id)aParam
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aMessageName object:aParam];
}
@end
