//
//  PGRows.m
//
//  Created by  Johnny on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PGRows.h"
#import "PGPicList.h"


NSString *const kPGRowsId = @"id";
NSString *const kPGRowsStayQty = @"stay_qty";
NSString *const kPGRowsSysPid = @"sysPid";
NSString *const kPGRowsUid = @"uid";
NSString *const kPGRowsProductName = @"product_name";
NSString *const kPGRowsClsName = @"cls_name";
NSString *const kPGRowsStockQty = @"stockQty";
NSString *const kPGRowsCheckLastTime = @"check_last_time";
NSString *const kPGRowsActValue = @"act_value";
NSString *const kPGRowsBuyingPrice = @"buying_price";
NSString *const kPGRowsCid = @"cid";
NSString *const kPGRowsHasPic = @"has_pic";
NSString *const kPGRowsSalePrice = @"sale_price";
NSString *const kPGRowsPicList = @"picList";
NSString *const kPGRowsIsScore = @"is_score";
NSString *const kPGRowsProductCode = @"product_code";
NSString *const kPGRowsActEnabled = @"act_enabled";
NSString *const kPGRowsSaleUnit = @"sale_unit";


@interface PGRows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PGRows

@synthesize rowsIdentifier = _rowsIdentifier;
@synthesize stayQty = _stayQty;
@synthesize sysPid = _sysPid;
@synthesize uid = _uid;
@synthesize productName = _productName;
@synthesize clsName = _clsName;
@synthesize stockQty = _stockQty;
@synthesize checkLastTime = _checkLastTime;
@synthesize actValue = _actValue;
@synthesize buyingPrice = _buyingPrice;
@synthesize cid = _cid;
@synthesize hasPic = _hasPic;
@synthesize salePrice = _salePrice;
@synthesize picList = _picList;
@synthesize isScore = _isScore;
@synthesize productCode = _productCode;
@synthesize actEnabled = _actEnabled;
@synthesize saleUnit = _saleUnit;


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
            self.rowsIdentifier = [[self objectOrNilForKey:kPGRowsId fromDictionary:dict] doubleValue];
            self.stayQty = [[self objectOrNilForKey:kPGRowsStayQty fromDictionary:dict] doubleValue];
            self.sysPid = [[self objectOrNilForKey:kPGRowsSysPid fromDictionary:dict] doubleValue];
            self.uid = [[self objectOrNilForKey:kPGRowsUid fromDictionary:dict] doubleValue];
            self.productName = [self objectOrNilForKey:kPGRowsProductName fromDictionary:dict];
            self.clsName = [self objectOrNilForKey:kPGRowsClsName fromDictionary:dict];
            self.stockQty = [[self objectOrNilForKey:kPGRowsStockQty fromDictionary:dict] doubleValue];
            self.checkLastTime = [self objectOrNilForKey:kPGRowsCheckLastTime fromDictionary:dict];
            self.actValue = [[self objectOrNilForKey:kPGRowsActValue fromDictionary:dict] doubleValue];
            self.buyingPrice = [[self objectOrNilForKey:kPGRowsBuyingPrice fromDictionary:dict] doubleValue];
            self.cid = [[self objectOrNilForKey:kPGRowsCid fromDictionary:dict] doubleValue];
            self.hasPic = [[self objectOrNilForKey:kPGRowsHasPic fromDictionary:dict] doubleValue];
            self.salePrice = [[self objectOrNilForKey:kPGRowsSalePrice fromDictionary:dict] doubleValue];
    NSObject *receivedPGPicList = [dict objectForKey:kPGRowsPicList];
    NSMutableArray *parsedPGPicList = [NSMutableArray array];
    if ([receivedPGPicList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPGPicList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPGPicList addObject:[PGPicList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPGPicList isKindOfClass:[NSDictionary class]]) {
       [parsedPGPicList addObject:[PGPicList modelObjectWithDictionary:(NSDictionary *)receivedPGPicList]];
    }

    self.picList = [NSArray arrayWithArray:parsedPGPicList];
            self.isScore = [[self objectOrNilForKey:kPGRowsIsScore fromDictionary:dict] doubleValue];
            self.productCode = [[self objectOrNilForKey:kPGRowsProductCode fromDictionary:dict] doubleValue];
            self.actEnabled = [[self objectOrNilForKey:kPGRowsActEnabled fromDictionary:dict] doubleValue];
            self.saleUnit = [self objectOrNilForKey:kPGRowsSaleUnit fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rowsIdentifier] forKey:kPGRowsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stayQty] forKey:kPGRowsStayQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sysPid] forKey:kPGRowsSysPid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uid] forKey:kPGRowsUid];
    [mutableDict setValue:self.productName forKey:kPGRowsProductName];
    [mutableDict setValue:self.clsName forKey:kPGRowsClsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stockQty] forKey:kPGRowsStockQty];
    [mutableDict setValue:self.checkLastTime forKey:kPGRowsCheckLastTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actValue] forKey:kPGRowsActValue];
    [mutableDict setValue:[NSNumber numberWithDouble:self.buyingPrice] forKey:kPGRowsBuyingPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cid] forKey:kPGRowsCid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hasPic] forKey:kPGRowsHasPic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.salePrice] forKey:kPGRowsSalePrice];
    NSMutableArray *tempArrayForPicList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.picList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPicList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPicList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPicList] forKey:kPGRowsPicList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isScore] forKey:kPGRowsIsScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productCode] forKey:kPGRowsProductCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actEnabled] forKey:kPGRowsActEnabled];
    [mutableDict setValue:self.saleUnit forKey:kPGRowsSaleUnit];

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

    self.rowsIdentifier = [aDecoder decodeDoubleForKey:kPGRowsId];
    self.stayQty = [aDecoder decodeDoubleForKey:kPGRowsStayQty];
    self.sysPid = [aDecoder decodeDoubleForKey:kPGRowsSysPid];
    self.uid = [aDecoder decodeDoubleForKey:kPGRowsUid];
    self.productName = [aDecoder decodeObjectForKey:kPGRowsProductName];
    self.clsName = [aDecoder decodeObjectForKey:kPGRowsClsName];
    self.stockQty = [aDecoder decodeDoubleForKey:kPGRowsStockQty];
    self.checkLastTime = [aDecoder decodeObjectForKey:kPGRowsCheckLastTime];
    self.actValue = [aDecoder decodeDoubleForKey:kPGRowsActValue];
    self.buyingPrice = [aDecoder decodeDoubleForKey:kPGRowsBuyingPrice];
    self.cid = [aDecoder decodeDoubleForKey:kPGRowsCid];
    self.hasPic = [aDecoder decodeDoubleForKey:kPGRowsHasPic];
    self.salePrice = [aDecoder decodeDoubleForKey:kPGRowsSalePrice];
    self.picList = [aDecoder decodeObjectForKey:kPGRowsPicList];
    self.isScore = [aDecoder decodeDoubleForKey:kPGRowsIsScore];
    self.productCode = [aDecoder decodeDoubleForKey:kPGRowsProductCode];
    self.actEnabled = [aDecoder decodeDoubleForKey:kPGRowsActEnabled];
    self.saleUnit = [aDecoder decodeObjectForKey:kPGRowsSaleUnit];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_rowsIdentifier forKey:kPGRowsId];
    [aCoder encodeDouble:_stayQty forKey:kPGRowsStayQty];
    [aCoder encodeDouble:_sysPid forKey:kPGRowsSysPid];
    [aCoder encodeDouble:_uid forKey:kPGRowsUid];
    [aCoder encodeObject:_productName forKey:kPGRowsProductName];
    [aCoder encodeObject:_clsName forKey:kPGRowsClsName];
    [aCoder encodeDouble:_stockQty forKey:kPGRowsStockQty];
    [aCoder encodeObject:_checkLastTime forKey:kPGRowsCheckLastTime];
    [aCoder encodeDouble:_actValue forKey:kPGRowsActValue];
    [aCoder encodeDouble:_buyingPrice forKey:kPGRowsBuyingPrice];
    [aCoder encodeDouble:_cid forKey:kPGRowsCid];
    [aCoder encodeDouble:_hasPic forKey:kPGRowsHasPic];
    [aCoder encodeDouble:_salePrice forKey:kPGRowsSalePrice];
    [aCoder encodeObject:_picList forKey:kPGRowsPicList];
    [aCoder encodeDouble:_isScore forKey:kPGRowsIsScore];
    [aCoder encodeDouble:_productCode forKey:kPGRowsProductCode];
    [aCoder encodeDouble:_actEnabled forKey:kPGRowsActEnabled];
    [aCoder encodeObject:_saleUnit forKey:kPGRowsSaleUnit];
}

- (id)copyWithZone:(NSZone *)zone
{
    PGRows *copy = [[PGRows alloc] init];
    
    if (copy) {

        copy.rowsIdentifier = self.rowsIdentifier;
        copy.stayQty = self.stayQty;
        copy.sysPid = self.sysPid;
        copy.uid = self.uid;
        copy.productName = [self.productName copyWithZone:zone];
        copy.clsName = [self.clsName copyWithZone:zone];
        copy.stockQty = self.stockQty;
        copy.checkLastTime = [self.checkLastTime copyWithZone:zone];
        copy.actValue = self.actValue;
        copy.buyingPrice = self.buyingPrice;
        copy.cid = self.cid;
        copy.hasPic = self.hasPic;
        copy.salePrice = self.salePrice;
        copy.picList = [self.picList copyWithZone:zone];
        copy.isScore = self.isScore;
        copy.productCode = self.productCode;
        copy.actEnabled = self.actEnabled;
        copy.saleUnit = [self.saleUnit copyWithZone:zone];
    }
    
    return copy;
}


@end
