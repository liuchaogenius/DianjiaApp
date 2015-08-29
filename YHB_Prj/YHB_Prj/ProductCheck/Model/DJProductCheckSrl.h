//
//  DJRows.h
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 Apple (中国大陆). All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DJProductCheckSrl : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *checkName;
@property (nonatomic, assign) double pankui;
@property (nonatomic, assign) double staySum;
@property (nonatomic, assign) double panying;
@property (nonatomic, assign) double realSum;
@property (nonatomic, strong) NSString *orderFrom;
@property (nonatomic, assign) double sid;
@property (nonatomic, assign) double bookSum;
@property (nonatomic, strong) NSString *ckTime;
@property (nonatomic, assign) double breakMoney;
@property (nonatomic, strong) NSString *srl;
@property (nonatomic, assign) double checkId;
@property (nonatomic, assign) double itemNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
