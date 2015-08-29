//
//  DJProductCheckDetail.m
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 Apple (中国大陆). All rights reserved.
//

#import "DJProductCheckDetail.h"


NSString *const kDJProductCheckDetailProductName = @"product_name";
NSString *const kDJProductCheckDetailRealQty = @"real_qty";
NSString *const kDJProductCheckDetailDiffNum = @"diff_num";
NSString *const kDJProductCheckDetailBookQty = @"book_qty";
NSString *const kDJProductCheckDetailDiffMoney = @"diff_money";
NSString *const kDJProductCheckDetailStoreName = @"store_name";
NSString *const kDJProductCheckDetailStayQty = @"stay_qty";
NSString *const kDJProductCheckDetailOrderFromName = @"orderFromName";
NSString *const kDJProductCheckDetailOrderTime = @"order_time";


@interface DJProductCheckDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DJProductCheckDetail

@synthesize productName = _productName;
@synthesize realQty = _realQty;
@synthesize diffNum = _diffNum;
@synthesize bookQty = _bookQty;
@synthesize diffMoney = _diffMoney;
@synthesize storeName = _storeName;
@synthesize stayQty = _stayQty;
@synthesize orderFromName = _orderFromName;
@synthesize orderTime = _orderTime;


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
            self.productName = [self objectOrNilForKey:kDJProductCheckDetailProductName fromDictionary:dict];
            self.realQty = [[self objectOrNilForKey:kDJProductCheckDetailRealQty fromDictionary:dict] doubleValue];
            self.diffNum = [[self objectOrNilForKey:kDJProductCheckDetailDiffNum fromDictionary:dict] doubleValue];
            self.bookQty = [[self objectOrNilForKey:kDJProductCheckDetailBookQty fromDictionary:dict] doubleValue];
            self.diffMoney = [[self objectOrNilForKey:kDJProductCheckDetailDiffMoney fromDictionary:dict] doubleValue];
            self.storeName = [self objectOrNilForKey:kDJProductCheckDetailStoreName fromDictionary:dict];
            self.stayQty = [[self objectOrNilForKey:kDJProductCheckDetailStayQty fromDictionary:dict] doubleValue];
            self.orderFromName = [self objectOrNilForKey:kDJProductCheckDetailOrderFromName fromDictionary:dict];
            self.orderTime = [self objectOrNilForKey:kDJProductCheckDetailOrderTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productName forKey:kDJProductCheckDetailProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realQty] forKey:kDJProductCheckDetailRealQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.diffNum] forKey:kDJProductCheckDetailDiffNum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bookQty] forKey:kDJProductCheckDetailBookQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.diffMoney] forKey:kDJProductCheckDetailDiffMoney];
    [mutableDict setValue:self.storeName forKey:kDJProductCheckDetailStoreName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stayQty] forKey:kDJProductCheckDetailStayQty];
    [mutableDict setValue:self.orderFromName forKey:kDJProductCheckDetailOrderFromName];
    [mutableDict setValue:self.orderTime forKey:kDJProductCheckDetailOrderTime];

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

    self.productName = [aDecoder decodeObjectForKey:kDJProductCheckDetailProductName];
    self.realQty = [aDecoder decodeDoubleForKey:kDJProductCheckDetailRealQty];
    self.diffNum = [aDecoder decodeDoubleForKey:kDJProductCheckDetailDiffNum];
    self.bookQty = [aDecoder decodeDoubleForKey:kDJProductCheckDetailBookQty];
    self.diffMoney = [aDecoder decodeDoubleForKey:kDJProductCheckDetailDiffMoney];
    self.storeName = [aDecoder decodeObjectForKey:kDJProductCheckDetailStoreName];
    self.stayQty = [aDecoder decodeDoubleForKey:kDJProductCheckDetailStayQty];
    self.orderFromName = [aDecoder decodeObjectForKey:kDJProductCheckDetailOrderFromName];
    self.orderTime = [aDecoder decodeObjectForKey:kDJProductCheckDetailOrderTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productName forKey:kDJProductCheckDetailProductName];
    [aCoder encodeDouble:_realQty forKey:kDJProductCheckDetailRealQty];
    [aCoder encodeDouble:_diffNum forKey:kDJProductCheckDetailDiffNum];
    [aCoder encodeDouble:_bookQty forKey:kDJProductCheckDetailBookQty];
    [aCoder encodeDouble:_diffMoney forKey:kDJProductCheckDetailDiffMoney];
    [aCoder encodeObject:_storeName forKey:kDJProductCheckDetailStoreName];
    [aCoder encodeDouble:_stayQty forKey:kDJProductCheckDetailStayQty];
    [aCoder encodeObject:_orderFromName forKey:kDJProductCheckDetailOrderFromName];
    [aCoder encodeObject:_orderTime forKey:kDJProductCheckDetailOrderTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    DJProductCheckDetail *copy = [[DJProductCheckDetail alloc] init];
    
    if (copy) {

        copy.productName = [self.productName copyWithZone:zone];
        copy.realQty = self.realQty;
        copy.diffNum = self.diffNum;
        copy.bookQty = self.bookQty;
        copy.diffMoney = self.diffMoney;
        copy.storeName = [self.storeName copyWithZone:zone];
        copy.stayQty = self.stayQty;
        copy.orderFromName = [self.orderFromName copyWithZone:zone];
        copy.orderTime = [self.orderTime copyWithZone:zone];
    }
    
    return copy;
}


@end
