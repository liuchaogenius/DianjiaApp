//
//  SCach.m
//  YOChangeWord
//
//  Created by  striveliu on 14-9-9.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "SCach.h"
#import "NSFileManager_Additions.h"

#define kMaxCurrentOperationCount  8
@implementation SCach

+ (SCach *)shareInstance
{
    static SCach *sca = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sca = [[SCach alloc] init];
    });
    return sca;
}

- (instancetype)init
{
    if(self = [super init])
    {
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setMaxConcurrentOperationCount:kMaxCurrentOperationCount];
        [operationQueue setName:@"com.you.cache"];
    }
    return self;
}

- (void)setAsynValue:(id)aValue
                 key:(NSString *)aKey
           isMemeory:(BOOL)aMemeory
            filePath:(NSString *)aFilePath
               block:(void(^)(bool isResult))aBlock
{
    __weak SCach *weakself = self;
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL isSucc = [weakself setSynValue:aValue key:aKey filePath:aFilePath isMemeory:aMemeory];
        aBlock(isSucc);
    }];
    [operationQueue addOperation:blockOperation];
}

- (BOOL)setSynValue:(id)aValue
                 key:(NSString *)aKey
            filePath:(NSString *)aFilePath
          isMemeory:(BOOL)aMemeory
{

    NSString *filePath = nil;
    if(aFilePath)
    {
        filePath = [NSString stringWithFormat:@"%@/%@",aFilePath,aKey];;
    }
    else
    {
        filePath = [[NSFileManager defaultManager] cachesDirectory:aKey];
    }
    if(aMemeory)
    {
        [mutableDict setObject:aValue forKey:aKey];
    }
    NSDictionary *modleDict = [JsonToModel dictionaryFromObject:aValue key:aKey];
    if(modleDict == nil)
    {
        return NO;
    }
    BOOL isSucc = [modleDict writeToFile:filePath atomically:NO];
    NSLog(@"写文件=%d",isSucc);
    return isSucc;
}


- (void)valueAsynForKey:(NSString *)aKey
         isMemory:(BOOL)aMemory
         filePath:(NSString *)aFilePath
        className:(NSString *)aClassName
                  block:(void(^)(id reslutId))aBlock
{
    __weak SCach *weakself = self;
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        id resultid = nil;
        [weakself valueSynForKey:aKey isMemory:aMemory filePath:aFilePath className:aClassName outObject:&resultid];
        aBlock(resultid);
    }];
    [operationQueue addOperation:blockOperation];
}

- (void)valueSynForKey:(NSString *)aKey
               isMemory:(BOOL)aMemory
               filePath:(NSString *)aFilePath
              className:(NSString *)aClassName
         outObject:(NSObject **)aObject
{
    NSString *filePath = nil;
    if(aMemory)
    {
        *aObject = [mutableDict objectForKey:aKey];
        if(*aObject)
        {
            return;
        }
    }
    if(aFilePath)
    {
        filePath = [NSString stringWithFormat:@"%@/%@",aFilePath,aKey];
    }
    else
    {
       filePath = [[NSFileManager defaultManager] cachesDirectory:aKey];
    }
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    *aObject = [JsonToModel objectFromDictionary:dict className:aClassName key:aKey valid:NO];
}

- (BOOL)removeMemoryData:(NSString *)aKey
{
    [mutableDict removeObjectForKey:aKey];
    return YES;
}

- (BOOL)removeFileData:(NSString *)aKey filePath:(NSString *)aFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = aFilePath;
    if(filePath == nil)
    {
        filePath = [[NSFileManager defaultManager] cachesDirectory:aKey];
    }
    [fileManager removeItemAtPath:filePath error:nil];
    return YES;
}

- (BOOL)removeAllData:(NSString*)aKey filePath:(NSString*)aFilePath
{
    [self removeMemoryData:aKey];
    [self removeFileData:aKey filePath:aFilePath];
    return YES;
}

- (void)save
{
    NSArray *keyArry = [mutableDict allKeys];
    if(keyArry && keyArry.count)
    {
        for(NSString *key in keyArry)
        {
            [self setAsynValue:mutableDict[key] key:key isMemeory:NO filePath:nil block:^(bool isResult) {
                NSLog(@"写文件成功");
            }];
        }
    }
}
@end


















