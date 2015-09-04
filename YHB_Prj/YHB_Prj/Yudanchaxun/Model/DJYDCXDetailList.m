//
//  DJYDCXDetailList.m
//
//  Created by  Johnny on 15/9/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "DJYDCXDetailList.h"


NSString *const kDJYDCXDetailListPayableMoney = @"payable_money";
NSString *const kDJYDCXDetailListId = @"id";
NSString *const kDJYDCXDetailListCardUseNum = @"card_use_num";
NSString *const kDJYDCXDetailListUid = @"uid";
NSString *const kDJYDCXDetailListStockPrice = @"stock_price";
NSString *const kDJYDCXDetailListProductName = @"product_name";
NSString *const kDJYDCXDetailListDiscountRate = @"discount_rate";
NSString *const kDJYDCXDetailListSrlStatus = @"srl_status";
NSString *const kDJYDCXDetailListSaleNum = @"sale_num";
NSString *const kDJYDCXDetailListSalePrice = @"sale_price";
NSString *const kDJYDCXDetailListProductId = @"product_id";
NSString *const kDJYDCXDetailListSid = @"sid";
NSString *const kDJYDCXDetailListRealMoney = @"real_money";
NSString *const kDJYDCXDetailListProductCode = @"product_code";
NSString *const kDJYDCXDetailListSaleId = @"sale_id";
NSString *const kDJYDCXDetailListSrl = @"srl";
NSString *const kDJYDCXDetailListEid = @"eid";


@interface DJYDCXDetailList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DJYDCXDetailList

@synthesize payableMoney = _payableMoney;
@synthesize detailListIdentifier = _detailListIdentifier;
@synthesize cardUseNum = _cardUseNum;
@synthesize uid = _uid;
@synthesize stockPrice = _stockPrice;
@synthesize productName = _productName;
@synthesize discountRate = _discountRate;
@synthesize srlStatus = _srlStatus;
@synthesize saleNum = _saleNum;
@synthesize salePrice = _salePrice;
@synthesize productId = _productId;
@synthesize sid = _sid;
@synthesize realMoney = _realMoney;
@synthesize productCode = _productCode;
@synthesize saleId = _saleId;
@synthesize srl = _srl;
@synthesize eid = _eid;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.payableMoney = [[self objectOrNilForKey:kDJYDCXDetailListPayableMoney fromDictionary:dict] doubleValue];
            self.detailListIdentifier = [[self objectOrNilForKey:kDJYDCXDetailListId fromDictionary:dict] doubleValue];
            self.cardUseNum = [[self objectOrNilForKey:kDJYDCXDetailListCardUseNum fromDictionary:dict] doubleValue];
            self.uid = [[self objectOrNilForKey:kDJYDCXDetailListUid fromDictionary:dict] doubleValue];
            self.stockPrice = [[self objectOrNilForKey:kDJYDCXDetailListStockPrice fromDictionary:dict] doubleValue];
            self.productName = [self objectOrNilForKey:kDJYDCXDetailListProductName fromDictionary:dict];
            self.discountRate = [[self objectOrNilForKey:kDJYDCXDetailListDiscountRate fromDictionary:dict] doubleValue];
            self.srlStatus = [[self objectOrNilForKey:kDJYDCXDetailListSrlStatus fromDictionary:dict] doubleValue];
            self.saleNum = [[self objectOrNilForKey:kDJYDCXDetailListSaleNum fromDictionary:dict] doubleValue];
            self.salePrice = [[self objectOrNilForKey:kDJYDCXDetailListSalePrice fromDictionary:dict] doubleValue];
            self.productId = [[self objectOrNilForKey:kDJYDCXDetailListProductId fromDictionary:dict] doubleValue];
            self.sid = [[self objectOrNilForKey:kDJYDCXDetailListSid fromDictionary:dict] doubleValue];
            self.realMoney = [self objectOrNilForKey:kDJYDCXDetailListRealMoney fromDictionary:dict];
            self.productCode = [[self objectOrNilForKey:kDJYDCXDetailListProductCode fromDictionary:dict] doubleValue];
            self.saleId = [[self objectOrNilForKey:kDJYDCXDetailListSaleId fromDictionary:dict] doubleValue];
            self.srl = [self objectOrNilForKey:kDJYDCXDetailListSrl fromDictionary:dict];
            self.eid = [[self objectOrNilForKey:kDJYDCXDetailListEid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payableMoney] forKey:kDJYDCXDetailListPayableMoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.detailListIdentifier] forKey:kDJYDCXDetailListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cardUseNum] forKey:kDJYDCXDetailListCardUseNum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uid] forKey:kDJYDCXDetailListUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stockPrice] forKey:kDJYDCXDetailListStockPrice];
    [mutableDict setValue:self.productName forKey:kDJYDCXDetailListProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.discountRate] forKey:kDJYDCXDetailListDiscountRate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.srlStatus] forKey:kDJYDCXDetailListSrlStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.saleNum] forKey:kDJYDCXDetailListSaleNum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.salePrice] forKey:kDJYDCXDetailListSalePrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kDJYDCXDetailListProductId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sid] forKey:kDJYDCXDetailListSid];
    [mutableDict setValue:self.realMoney forKey:kDJYDCXDetailListRealMoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productCode] forKey:kDJYDCXDetailListProductCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.saleId] forKey:kDJYDCXDetailListSaleId];
    [mutableDict setValue:self.srl forKey:kDJYDCXDetailListSrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eid] forKey:kDJYDCXDetailListEid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.payableMoney = [aDecoder decodeDoubleForKey:kDJYDCXDetailListPayableMoney];
    self.detailListIdentifier = [aDecoder decodeDoubleForKey:kDJYDCXDetailListId];
    self.cardUseNum = [aDecoder decodeDoubleForKey:kDJYDCXDetailListCardUseNum];
    self.uid = [aDecoder decodeDoubleForKey:kDJYDCXDetailListUid];
    self.stockPrice = [aDecoder decodeDoubleForKey:kDJYDCXDetailListStockPrice];
    self.productName = [aDecoder decodeObjectForKey:kDJYDCXDetailListProductName];
    self.discountRate = [aDecoder decodeDoubleForKey:kDJYDCXDetailListDiscountRate];
    self.srlStatus = [aDecoder decodeDoubleForKey:kDJYDCXDetailListSrlStatus];
    self.saleNum = [aDecoder decodeDoubleForKey:kDJYDCXDetailListSaleNum];
    self.salePrice = [aDecoder decodeDoubleForKey:kDJYDCXDetailListSalePrice];
    self.productId = [aDecoder decodeDoubleForKey:kDJYDCXDetailListProductId];
    self.sid = [aDecoder decodeDoubleForKey:kDJYDCXDetailListSid];
    self.realMoney = [aDecoder decodeObjectForKey:kDJYDCXDetailListRealMoney];
    self.productCode = [aDecoder decodeDoubleForKey:kDJYDCXDetailListProductCode];
    self.saleId = [aDecoder decodeDoubleForKey:kDJYDCXDetailListSaleId];
    self.srl = [aDecoder decodeObjectForKey:kDJYDCXDetailListSrl];
    self.eid = [aDecoder decodeDoubleForKey:kDJYDCXDetailListEid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_payableMoney forKey:kDJYDCXDetailListPayableMoney];
    [aCoder encodeDouble:_detailListIdentifier forKey:kDJYDCXDetailListId];
    [aCoder encodeDouble:_cardUseNum forKey:kDJYDCXDetailListCardUseNum];
    [aCoder encodeDouble:_uid forKey:kDJYDCXDetailListUid];
    [aCoder encodeDouble:_stockPrice forKey:kDJYDCXDetailListStockPrice];
    [aCoder encodeObject:_productName forKey:kDJYDCXDetailListProductName];
    [aCoder encodeDouble:_discountRate forKey:kDJYDCXDetailListDiscountRate];
    [aCoder encodeDouble:_srlStatus forKey:kDJYDCXDetailListSrlStatus];
    [aCoder encodeDouble:_saleNum forKey:kDJYDCXDetailListSaleNum];
    [aCoder encodeDouble:_salePrice forKey:kDJYDCXDetailListSaleNum];
    [aCoder encodeDouble:_productId forKey:kDJYDCXDetailListProductId];
    [aCoder encodeDouble:_sid forKey:kDJYDCXDetailListSid];
    [aCoder encodeObject:_realMoney forKey:kDJYDCXDetailListRealMoney];
    [aCoder encodeDouble:_productCode forKey:kDJYDCXDetailListProductCode];
    [aCoder encodeDouble:_saleId forKey:kDJYDCXDetailListSaleId];
    [aCoder encodeObject:_srl forKey:kDJYDCXDetailListSrl];
    [aCoder encodeDouble:_eid forKey:kDJYDCXDetailListEid];
}

- (id)copyWithZone:(NSZone *)zone
{
    DJYDCXDetailList *copy = [[DJYDCXDetailList alloc] init];
    
    if (copy) {

        copy.payableMoney = self.payableMoney;
        copy.detailListIdentifier = self.detailListIdentifier;
        copy.cardUseNum = self.cardUseNum;
        copy.uid = self.uid;
        copy.stockPrice = self.stockPrice;
        copy.productName = [self.productName copyWithZone:zone];
        copy.discountRate = self.discountRate;
        copy.srlStatus = self.srlStatus;
        copy.saleNum = self.saleNum;
        copy.salePrice = self.salePrice;
        copy.productId = self.productId;
        copy.sid = self.sid;
        copy.realMoney = [self.realMoney copyWithZone:zone];
        copy.productCode = self.productCode;
        copy.saleId = self.saleId;
        copy.srl = [self.srl copyWithZone:zone];
        copy.eid = self.eid;
    }
    
    return copy;
}


@end
