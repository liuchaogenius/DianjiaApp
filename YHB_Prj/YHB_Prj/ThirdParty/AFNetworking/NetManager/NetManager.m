//
//  NetManager.m
//  JieJiong
//
//  Created by xie licai on 12-12-21.
//  Copyright (c) 2012年 xie licai. All rights reserved.
//

#import "NetManager.h"
#import <objc/runtime.h>
#import "JSONKit.h"
#import "ThreadSafeMutableDictionary.h"
#import "AFHTTPRequestOperationManager.h"
@interface NetManager()
{
    NSMutableDictionary *mutaDict;
    NSString *strUserid;
    NSString *strUserToken;
    NSString *strStroreID;
    NSString *strSEID;
    NSString *strCPID;
    float lat;
    float lon;
    NSString *areaId;
}
@end

@implementation NetManager

+ (NetManager *)shareInstance
{
    static NetManager *netMan;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netMan = [[NetManager alloc] init];
    });
    return netMan;
}

- (instancetype)init
{
    if(self = [super init])
    {
        mutaDict = [[ThreadSafeMutableDictionary alloc] initWithCapacity:0];
        strCPID = @"test";
    }
    return self;
}

- (void)addOperationAndKey:(NSString *)aKey operation:(id)aOperation
{
    [mutaDict setObject:aOperation forKey:aKey];
}

- (void)removeOperationKey:(NSString *)aKey
{
    if(aKey)
    {
        [mutaDict removeObjectForKey:aKey];
    }
}
- (id)objectForKey:(NSString *)aKey
{
    if(aKey)
    {
        return [mutaDict objectForKey:aKey];
    }
    return nil;
}
- (void)removeAllOperation
{
    [mutaDict removeAllObjects];
}

- (void)setUserid:(NSString *)aUserid
{
    strUserid = aUserid;
}

- (void)setStroeID:(NSString *)astoreID
{
    strStroreID = astoreID;
}

- (void)setSEID:(NSString *)aSEID
{
    strSEID = aSEID;
}

- (void)setCPID:(NSString *)aCPID
{
    strCPID = aCPID;
}

- (void)setUserToken:(NSString *)aUserToken
{
    strUserToken = aUserToken;
}


- (NSString *)getUserid
{
    return strUserid;
}

- (NSString *)getUserToken
{
    if(!strUserToken) strUserToken = @"barcodescan.chinascrm.com";
    return strUserToken;
}

- (NSString*)getStroeID //StoreID这个是你本地选择门店后变动的值
{
    if (!strStroreID) strStroreID = @"-8712";
    return strStroreID;
}

- (NSString*)getSEID//员工id    登录给（员工版和PC用到）
{
    return strSEID;
}

- (NSString*)getCPID //CPID 这是你的机器id
{
    return strCPID;
}



- (void)dealloc
{
    MLOG(@"Netmanager--dealloc");
}

+ (void)requestWith:(id)aDict
            apiName:(NSString *)aApiName
             method:(NSString *)aMethod
               succ:(SUCCESSBLOCK)success
            failure:(FAILUREBLOCK)failure

{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *param = nil;
    NSMutableDictionary *dict = nil;
    manager.requestSerializer.timeoutInterval = 30;

    param = [[NetManager shareInstance] basePostDict:aDict apiName:aApiName];
    dict = [NSMutableDictionary dictionary];
    [dict setValue:param forKey:@"S3CAPI"];
    
    MLOG(@"%@", dict);
    [NetManager setRequestHeadValue:manager];
    NSString *method = [aMethod uppercaseString];
//    if([kBaseUrl compare:@"https://api.dianjia001.com/sapi4app.html"] == 0)
//    {
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        securityPolicy.allowInvalidCertificates = YES;
//        [AFHTTPRequestOperationManager manager].securityPolicy = securityPolicy;
//    }
    if([method compare:@"POST"] == 0)
    {
        [manager POST:kBaseUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功
            NSDictionary *dic = responseObject;
            MLOG(@"API_NAME = %@,result=%@",aApiName,dic);
            NSString *codeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([codeString intValue] == 0) {
                success(dic);
            }else{
                success(dic);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            NSDictionary *resultDictionary = [operation.responseString objectFromJSONString];
            MLOG(@"API_NAME = %@,false=%@",aApiName,resultDictionary);
            failure(nil, error);
        }];
    }
    else if([method compare:@"GET"] == 0)
    {
        [manager GET:kBaseUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功
            NSDictionary *Dict = [operation.responseString objectFromJSONString];
            MLOG(@"API_NAME = %@,result=%@",aApiName,Dict);
            success(Dict);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            NSDictionary *resultDictionary = [operation.responseString objectFromJSONString];
            MLOG(@"API_NAME = %@,false=%@",aApiName,resultDictionary);
            failure(resultDictionary, error);
        }];
    }
}

- (NSString *)basePostDict:(id)aParam apiName:(NSString *)aApiName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:nil];
    [dict setValue:aApiName forKey:@"ApiName"];
    if([self getStroeID])
    {
        [dict setValue:[self getStroeID] forKey:@"StoreID"];
    }
    if([self getUserid])
    {
        [dict setValue:[self getUserid] forKey:@"UID"];
    }
    if([self getSEID])
    {
        [dict setValue:[self getSEID] forKey:@"SEID"];
    }
    if([self getUserToken])
    {
        [dict setValue:[self getUserToken] forKey:@"Token"];
    }
    if([self getCPID])
    {
        [dict setValue:[self getCPID] forKey:@"CPID"];
    }
    if(aParam)
    {
        NSString *myJsonString = [NetManager Dic_ToJSONString:aParam];
        [dict setValue:myJsonString forKey:@"ApiParam"];
    }
        
    NSString *paramString = [NetManager Dic_ToJSONString:dict];
    return paramString;
}

+ (NSString*)Dic_ToJSONString:(id)aDict
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:aDict
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    
    NSString *jsonString = [[NSString alloc] initWithData:result
                                                 encoding:NSUTF8StringEncoding];
    //    jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];//转json的格式
    return jsonString;
}

+ (void)setRequestHeadValue:(AFHTTPRequestOperationManager*)aRequest
{
    NetManager *net = [NetManager shareInstance];
    if([net getUserid])
    {
        [aRequest.requestSerializer setValue:[net getUserid] forHTTPHeaderField:@"3CUID"];
    }
    if ([net getUserToken]) {
        [aRequest.requestSerializer setValue:[net getUserToken] forHTTPHeaderField:@"3CUTK"];
    }

    [aRequest.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"S3CTYPE"];

    [aRequest.requestSerializer setValue:@"test" forHTTPHeaderField:@"3CPID"];
    [aRequest.requestSerializer setValue:@"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1;)  chinascrm.com" forHTTPHeaderField:@"User-Agent"];
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
    [aRequest.requestSerializer setValue:appVersion forHTTPHeaderField:@"appver"];
}

+ (void)cancelOperation:(id)aKey
{
    NetManager *net = [NetManager shareInstance];
    AFHTTPRequestOperation *operation = [net objectForKey:aKey];
    [operation cancel];
}

+ (void)uploadImg:(UIImage*)aImg
       parameters:(NSDictionary*)aParam
          apiName:(NSString *)aApidName
        uploadUrl:(NSString*)aUrl
    uploadimgName:(NSString*)aImgname
    progressBlock:(PROGRESSBLOCK)block
             succ:(SUCCESSBLOCK)success
          failure:(FAILUREBLOCK)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSData *imageData = UIImageJPEGRepresentation(aImg, 1);
    NSString *param = nil;
    NSMutableDictionary *dict = nil;
    manager.requestSerializer.timeoutInterval = 30;
    
    param = [[NetManager shareInstance] basePostDict:aParam apiName:aApidName];
    dict = [NSMutableDictionary dictionaryWithDictionary:aParam];
    [dict setValue:param forKey:@"S3CAPI"];
    [manager.requestSerializer setValue:param forHTTPHeaderField:@"S3CAPI"];
    [NetManager setRequestHeadValue:manager];
    if([kBaseUrl compare:@"https://api.dianjia001.com/sapi4app.html"] == 0)
    {
        manager.securityPolicy.allowInvalidCertificates = YES;
    }
    
    [manager POST:kBaseUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"temp_image.jpg" mimeType:@"application/octet-stream"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *Dict = [operation.responseString objectFromJSONString];
        success(Dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *Dict = [operation.responseString objectFromJSONString];
        success(Dict);
    }];
}

+ (void)uploadImgArry:(NSArray*)aImgArry
           parameters:(NSDictionary*)aParam
              apiName:(NSString *)aApidName
            uploadUrl:(NSString*)aUrl
        uploadimgName:(NSString*)aImgname
        progressBlock:(PROGRESSBLOCK)block
                 succ:(SUCCESSBLOCK)success
              failure:(FAILUREBLOCK)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *param = nil;
    NSMutableDictionary *dict = nil;
    manager.requestSerializer.timeoutInterval = 30;
    
    param = [[NetManager shareInstance] basePostDict:aParam apiName:aApidName];
    dict = [NSMutableDictionary dictionaryWithDictionary:aParam];
    [dict setValue:param forKey:@"S3CAPI"];
    [manager.requestSerializer setValue:param forHTTPHeaderField:@"S3CAPI"];
    [NetManager setRequestHeadValue:manager];
    if([kBaseUrl compare:@"https://api.dianjia001.com/sapi4app.html"] == 0)
    {
        manager.securityPolicy.allowInvalidCertificates = YES;
    }
    
    [manager POST:kBaseUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *fileName = @"temp_image.jpg";
        for(int i=0; i<aImgArry.count; i++)
        {
            fileName = [NSString stringWithFormat:@"temp_image%d.jpg",i];
            NSData *imageData = UIImageJPEGRepresentation([aImgArry objectAtIndex:i], 1);
            [formData appendPartWithFileData:imageData name:@"pic" fileName:fileName mimeType:@"application/octet-stream"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *Dict = [operation.responseString objectFromJSONString];
        success(Dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *Dict = [operation.responseString objectFromJSONString];
        success(Dict);
    }];
}


@end
