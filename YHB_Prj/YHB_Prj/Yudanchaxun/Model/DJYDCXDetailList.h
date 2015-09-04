//
//  DJYDCXDetailList.h
//
//  Created by  Johnny on 15/9/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DJYDCXDetailList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double payableMoney;
@property (nonatomic, assign) double detailListIdentifier;
@property (nonatomic, assign) double cardUseNum;
@property (nonatomic, assign) double uid;
@property (nonatomic, assign) double stockPrice;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) double discountRate;
@property (nonatomic, assign) double srlStatus;
@property (nonatomic, assign) double saleNum;
@property (nonatomic, strong) NSString *salePrice;
@property (nonatomic, assign) double productId;
@property (nonatomic, assign) double sid;
@property (nonatomic, strong) NSString *realMoney;
@property (nonatomic, assign) double productCode;
@property (nonatomic, assign) double saleId;
@property (nonatomic, strong) NSString *srl;
@property (nonatomic, assign) double eid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
