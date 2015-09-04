//
//  DJYDCXRows.h
//
//  Created by  Johnny on 15/9/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DJYDCXRows : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *payrelMoneySum;
@property (nonatomic, assign) double uid;
@property (nonatomic, strong) NSString *payrelMoney;
@property (nonatomic, assign) double rowsIdentifier;
@property (nonatomic, strong) NSString *empName;
@property (nonatomic, strong) NSString *vipName;
@property (nonatomic, assign) double vipId;
@property (nonatomic, strong) NSArray *detailList;
@property (nonatomic, assign) double vipPhone;
@property (nonatomic, assign) double discountRate;
@property (nonatomic, strong) NSString *endOrderTime;
@property (nonatomic, assign) double sid;
@property (nonatomic, assign) double realMoney;
@property (nonatomic, assign) double cardPayed;
@property (nonatomic, assign) double scoPayed;
@property (nonatomic, assign) double bankPayed;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSString *profitMoney;
@property (nonatomic, assign) double scoCost;
@property (nonatomic, strong) NSString *srl;
@property (nonatomic, assign) double orderClass;
@property (nonatomic, assign) double eid;
@property (nonatomic, strong) NSString *payment;
@property (nonatomic, assign) double ticketPayed;
@property (nonatomic, strong) NSString *stockMoney;
@property (nonatomic, assign) double creditId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) double cashPayed;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double vipCode;
@property (nonatomic, assign) double thirdPayed;
@property (nonatomic, assign) double isScore;
@property (nonatomic, assign) double orderType;
@property (nonatomic, strong) NSString *payableMoney;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
