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
@property (nonatomic, strong) NSString *currentStoreName;
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
                [self setCurrentStoreName:sm.strStoreName];
                [self iosAppGetStoreList];
            }
        }];
    }
    return self;
}

- (void)login_request:(NSString *)aUserName pass:(NSString *)aPass
             retblock:(LOGINRESULTBLOCK)aBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
#ifdef DEBUG
    [dict setValue:aUserName forKey:@"userName"];
    [dict setValue:aPass forKey:@"userPassword"];
#else
    if(!aUserName || !aPass)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名或密码" duration:1.0f cover:NO offsetY:64];
        return ;
    }
    [dict setValue:aUserName forKey:@"userName"];
    [dict setValue:aPass forKey:@"userPassword"];
#endif
    
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
            [self setCurrentStoreName:sm.strStoreName];
            [self setNetWorkStoreId:sm.strId];
            [self iosAppGetStoreList];
            [[SCach shareInstance] setAsynValue:self.logMode key:@"loginMode" isMemeory:NO filePath:nil block:^(bool isResult) {
                
            }];
        }
        aBlock(YES);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aBlock(NO);
    }];
}

- (void)iosAppGetStoreList
{
    [NetManager requestWith:nil apiName:@"iosAppGetStoreList" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        NSArray *arry = [successDict objectForKey:@"result"];
        if(arry && arry.count > 0)
        {
            if(self.logMode)
            {
                [self.logMode unPacketAllStoreList:arry];
                [[SCach shareInstance] setAsynValue:self.logMode key:@"loginMode" isMemeory:NO filePath:nil block:^(bool isResult) {
                    
                }];
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usertoken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SCach *cach = [SCach shareInstance];
    [cach removeFileData:@"loginMode" filePath:nil];
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

- (NSArray *)getStoreAndAllList
{
    return self.logMode.storeAndAllList;
}

- (LoginMode *)getLoginMode
{
    return self.logMode;
}

- (void)setCurrentSelectStore:(StoreMode *)currentSelectStore {
    _currentSelectStore = currentSelectStore;
    [self setCurrentStoreName:currentSelectStore.strStoreName];
    self.currentStoreId = currentSelectStore.strId;
}

- (void)setCurrentStoreName:(NSString *)currentStoreName
{
    _currentStoreName = currentStoreName;
}

- (NSString *)getCurrentStoreName
{
    return self.currentStoreName?self.currentStoreName:@" ";
}
@end
