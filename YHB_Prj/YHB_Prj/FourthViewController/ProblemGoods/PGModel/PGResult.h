//
//  PGResult.h
//
//  Created by  Johnny on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PGResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double autoCount;
@property (nonatomic, assign) double needPage;
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) double pageSize;
@property (nonatomic, assign) double pageNo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
