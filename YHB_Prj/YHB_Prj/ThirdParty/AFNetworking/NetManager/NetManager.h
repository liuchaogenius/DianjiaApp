//
//  NetManager.h
//  JieJiong
//
//  Created by xie licai on 12-12-21.
//  Copyright (c) 2012年 xie licai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCCESSBLOCK      void(^)(NSDictionary* successDict)
#define FAILUREBLOCK      void(^)(NSDictionary *failDict, NSError *error)
#define PROGRESSBLOCK     void(^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)

@interface NetManager : NSObject

+ (NetManager *)shareInstance;
- (void)setUserid:(NSString *)aUserid;
- (void)setStroeID:(NSString *)astoreID;
- (void)setSEID:(NSString *)aSEID;
- (void)setCPID:(NSString *)aCPID;
- (void)setUserToken:(NSString *)aUserToken;

//- (void)set
/******************************************************
 *  aDict   body数据 如果没有业务数据此值为nil
 *  aUrl
 *  aMethod
 *  aEncoding
 *  success
 *  failure
 */
+ (void)requestWith:(NSDictionary *)aDict
            apiName:(NSString *)aApiName
             method:(NSString *)aMethod
               succ:(SUCCESSBLOCK)success
            failure:(FAILUREBLOCK)failure;

+ (void)uploadImg:(UIImage*)aImg
       parameters:(NSDictionary*)aParam
        uploadUrl:(NSString*)aUrl
    uploadimgName:(NSString*)aImgname
    progressBlock:(PROGRESSBLOCK)block
             succ:(SUCCESSBLOCK)success
          failure:(FAILUREBLOCK)failure;

+ (void)cancelOperation:(id)aOperationKey;
@end
