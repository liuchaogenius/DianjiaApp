//
//  DJProductCheckSrlResult.h
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 Apple (中国大陆). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJProductCheckSrlResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double pageSize;
@property (nonatomic, assign) double pageNo;
@property (nonatomic, assign) BOOL needPage;
@property (nonatomic, assign) double totalPages;
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) BOOL autoCount;
@property (nonatomic, assign) double total;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
