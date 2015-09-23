//
//  LoginManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LOGINRESULTBLOCK      void(^)(BOOL ret)
@class LoginMode;
@class StoreMode;
@interface LoginManager : NSObject

+ (LoginManager *)shareLoginManager;

- (void)login_request:(NSString *)aUserName pass:(NSString *)aPass retblock:(LOGINRESULTBLOCK)aBlock;

- (NSString*)getUserId;

- (NSString*)getUserToken;

- (NSString *)getStoreId;

- (LoginMode *)getLoginMode;

- (void)setNetWorkParam:(NSString *)aUserid userToke:(NSString *)aUserToke;

- (void)setNetWorkStoreId:(NSString *)astoreID;

- (void)setNetWorkSEID:(NSString *)aSEID;

- (NSArray *)getStoreList;

- (NSString *)getCurrentStoreName;

@property (nonatomic, strong) StoreMode *currentSelectStore;

@end
