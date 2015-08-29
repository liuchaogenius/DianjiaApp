//
//  LoginManager.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "LoginManager.h"
#import "NetManager.h"
#import "LoginMode.h"
#import "SCach.h"

@interface LoginManager()
@property (nonatomic, strong) NSString *strUserId;
@property (nonatomic, strong) NSString *strUserToken;
@property (nonatomic, strong) LoginMode *logMode;
@property (nonatomic, strong) NSString *currentStoreId;
@end

@implementation LoginManager

+ (LoginManager *)shareLoginManager
{
    static LoginManager *lm = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        lm = [[LoginManager alloc] init];
    });
    return lm;
}

- (instancetype)init
{
    if(self = [super init])
    {
        SCach *cach = [SCach shareInstance];
        [cach valueAsynForKey:@"loginMode" isMemory:NO filePath:nil className:@"LoginMode" block:^(id reslutId) {
            self.logMode = reslutId;
            if(self.logMode.strUid)
            {
                [self setNetWorkParam:self.logMode.strUid userToke:self.logMode.strToken];
                StoreMode *sm = [self.logMode.storeList objectAtIndex:0];
                [self setNetWorkStoreId:sm.strId];
            }
        }];
    }
    return self;
}

- (void)login_request:(NSString *)aUserName pass:(NSString *)aPass
             retblock:(LOGINRESULTBLOCK)aBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@"18066040008" forKey:@"userName"];
    [dict setValue:@"000000" forKey:@"userPassword"];
    [dict setValue:@"1" forKey:@"loginUserType"];
    [NetManager requestWith:dict apiName:@"loginApp" method:@"POST" succ:^(NSDictionary *successDict) {
        NSDictionary *resultDict = [successDict objectForKey:@"result"];
        if(resultDict)
        {
            NSString *token = [resultDict objectForKey:@"token"];
            [self saveUserToken:token];
            NSString *uid = [resultDict objectForKey:@"uid"];
            BaseIntToNSString(uid);
            [self saveUserId:uid];
            if(!self.logMode)
            {
                self.logMode = [[LoginMode alloc] init];
            }
            [self.logMode unPacketData:resultDict];
            [self setNetWorkParam:self.strUserId userToke:self.strUserToken];
            StoreMode *sm = [self.logMode.storeList objectAtIndex:0];
            [self setNetWorkStoreId:sm.strId];
            [[SCach shareInstance] setAsynValue:self.logMode key:@"loginMode" isMemeory:NO filePath:nil block:^(bool isResult) {
                
            }];
        }
        aBlock(YES);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aBlock(NO);
    }];
}

- (void)saveUserId:(NSString *)aUserId
{
    self.strUserId = aUserId;
    [[NSUserDefaults standardUserDefaults] setObject:self.strUserId forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)saveUserToken:(NSString *)aUserToken
{
    self.strUserToken = aUserToken;
    [[NSUserDefaults standardUserDefaults] setObject:self.strUserToken forKey:@"usertoken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)getUserId
{
    if(!self.strUserId)
    {
        self.strUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    }
    return self.strUserId;
}

- (NSString*)getUserToken
{
    if(!self.strUserToken)
    {
        self.strUserToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    }
    return self.strUserToken;
}

- (void)setNetWorkParam:(NSString *)aUserid userToke:(NSString *)aUserToke
{
    [[NetManager shareInstance] setUserid:aUserid];
    [[NetManager shareInstance] setUserToken:aUserToke];
}

- (void)setNetWorkStoreId:(NSString *)astoreID
{
    self.currentStoreId = astoreID;
    [[NetManager shareInstance] setStroeID:astoreID];
}

- (void)setNetWorkSEID:(NSString *)aSEID
{
    [[NetManager shareInstance] setSEID:aSEID];
}

- (NSString *)getStoreId
{
    return  self.currentStoreId;
}

- (NSArray *)getStoreList
{
    return self.logMode.storeList;
}

- (void)setCurrentSelectStore:(StoreMode *)currentSelectStore {
    _currentSelectStore = currentSelectStore;
    self.currentStoreId = currentSelectStore.strId;
}

@end
