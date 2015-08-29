//
//  DJProductCheckDetail.h
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 Apple (中国大陆). All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DJProductCheckDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) double realQty;
@property (nonatomic, assign) double diffNum;
@property (nonatomic, assign) double bookQty;
@property (nonatomic, assign) double diffMoney;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) double stayQty;
@property (nonatomic, strong) NSString *orderFromName;
@property (nonatomic, strong) NSString *orderTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
