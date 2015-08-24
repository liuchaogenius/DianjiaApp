//
//  SCach.h
//  YOChangeWord
//
//  Created by  striveliu on 14-9-9.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonToModel.h"
#import "ThreadSafeMutableDictionary.h"
@interface SCach : NSObject
{
    NSOperationQueue *operationQueue;
    ThreadSafeMutableDictionary *mutableDict;
}
+ (SCach *)shareInstance;

- (void)setAsynValue:(id)aValue
                 key:(NSString *)aKey
           isMemeory:(BOOL)aMemeory
            filePath:(NSString *)aFilePath
               block:(void(^)(bool isResult))aBlock;
- (BOOL)setSynValue:(id)aValue
                key:(NSString *)aKey
           filePath:(NSString *)aFilePath
          isMemeory:(BOOL)aMemeory;
- (void)valueAsynForKey:(NSString *)aKey
               isMemory:(BOOL)aMemory
               filePath:(NSString *)aFilePath
              className:(NSString *)aClassName
                  block:(void(^)(id reslutId))aBlock;

- (void)valueSynForKey:(NSString *)aKey
              isMemory:(BOOL)aMemory
              filePath:(NSString *)aFilePath
             className:(NSString *)aClassName
             outObject:(NSObject **)aObject;
- (BOOL)removeMemoryData:(NSString *)aKey;
- (BOOL)removeFileData:(NSString *)aKey filePath:(NSString *)aFilePath;
- (BOOL)removeAllData:(NSString*)aKey filePath:(NSString*)aFilePath;

- (void)save;
@end