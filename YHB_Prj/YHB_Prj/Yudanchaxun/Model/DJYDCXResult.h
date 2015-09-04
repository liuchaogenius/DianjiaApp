//
//  DJYDCXResult.h
//
//  Created by  Johnny on 15/9/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DJYDCXResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double pageSize;
@property (nonatomic, assign) double pageNo;
@property (nonatomic, assign) double needPage;
@property (nonatomic, assign) double totalPages;
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) double autoCount;
@property (nonatomic, assign) double total;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
