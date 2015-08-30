//
//  DJProductCheckManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successHandler)(id resultModel);
typedef void (^failHandler)(id msg);

@interface DJProductCheckManager : NSObject

+ (void)getProductCheckSrlWithSid:(NSString *)sid
                          PageNum: (NSInteger)pageNum
                         pageSize: (NSInteger)pageSize
                        beginTime: (NSString *)begin
                          endTime: (NSString *)end
                          success: (successHandler)successHandler
                             fail: (failHandler)failHandler;

+ (void)getProductCheckDetailWithCheckId: (NSString *)checkId
                                 success: (successHandler)successHandler
                                    fail: (failHandler)failHandler;

+ (void)getProductCheckWithProductId: (NSString *)pId
                                 sid:(NSString *)sid
                             success: (successHandler)successHandler
                                fail: (failHandler)failHandler;

+ (void)submitProductChecksWithCheckDicArray: (NSArray *)checks
                                     success: (successHandler)successHandler
                                        fail: (failHandler)failHandler;

@end
