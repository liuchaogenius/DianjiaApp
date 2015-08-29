//
//  DJRows.m
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 Apple (中国大陆). All rights reserved.
//

#import "DJProductCheckSrl.h"


NSString *const kDJRowsStoreName = @"store_name";
NSString *const kDJRowsCheckName = @"check_name";
NSString *const kDJRowsPankui = @"pankui";
NSString *const kDJRowsStaySum = @"stay_sum";
NSString *const kDJRowsPanying = @"panying";
NSString *const kDJRowsRealSum = @"real_sum";
NSString *const kDJRowsOrderFrom = @"order_from";
NSString *const kDJRowsSid = @"sid";
NSString *const kDJRowsBookSum = @"book_sum";
NSString *const kDJRowsCkTime = @"ck_time";
NSString *const kDJRowsBreakMoney = @"break_money";
NSString *const kDJRowsSrl = @"srl";
NSString *const kDJRowsCheckId = @"check_id";
NSString *const kDJRowsItemNum = @"item_num";


@interface DJProductCheckSrl ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DJProductCheckSrl

@synthesize storeName = _storeName;
@synthesize checkName = _checkName;
@synthesize pankui = _pankui;
@synthesize staySum = _staySum;
@synthesize panying = _panying;
@synthesize realSum = _realSum;
@synthesize orderFrom = _orderFrom;
@synthesize sid = _sid;
@synthesize bookSum = _bookSum;
@synthesize ckTime = _ckTime;
@synthesize breakMoney = _breakMoney;
@synthesize srl = _srl;
@synthesize checkId = _checkId;
@synthesize itemNum = _itemNum;


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
            self.storeName = [self objectOrNilForKey:kDJRowsStoreName fromDictionary:dict];
            self.checkName = [self objectOrNilForKey:kDJRowsCheckName fromDictionary:dict];
            self.pankui = [[self objectOrNilForKey:kDJRowsPankui fromDictionary:dict] doubleValue];
            self.staySum = [[self objectOrNilForKey:kDJRowsStaySum fromDictionary:dict] doubleValue];
            self.panying = [[self objectOrNilForKey:kDJRowsPanying fromDictionary:dict] doubleValue];
            self.realSum = [[self objectOrNilForKey:kDJRowsRealSum fromDictionary:dict] doubleValue];
            self.orderFrom = [self objectOrNilForKey:kDJRowsOrderFrom fromDictionary:dict];
            self.sid = [[self objectOrNilForKey:kDJRowsSid fromDictionary:dict] doubleValue];
            self.bookSum = [[self objectOrNilForKey:kDJRowsBookSum fromDictionary:dict] doubleValue];
            self.ckTime = [self objectOrNilForKey:kDJRowsCkTime fromDictionary:dict];
            self.breakMoney = [[self objectOrNilForKey:kDJRowsBreakMoney fromDictionary:dict] doubleValue];
            self.srl = [self objectOrNilForKey:kDJRowsSrl fromDictionary:dict];
            self.checkId = [[self objectOrNilForKey:kDJRowsCheckId fromDictionary:dict] doubleValue];
            self.itemNum = [[self objectOrNilForKey:kDJRowsItemNum fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.storeName forKey:kDJRowsStoreName];
    [mutableDict setValue:self.checkName forKey:kDJRowsCheckName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pankui] forKey:kDJRowsPankui];
    [mutableDict setValue:[NSNumber numberWithDouble:self.staySum] forKey:kDJRowsStaySum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.panying] forKey:kDJRowsPanying];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realSum] forKey:kDJRowsRealSum];
    [mutableDict setValue:self.orderFrom forKey:kDJRowsOrderFrom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sid] forKey:kDJRowsSid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bookSum] forKey:kDJRowsBookSum];
    [mutableDict setValue:self.ckTime forKey:kDJRowsCkTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.breakMoney] forKey:kDJRowsBreakMoney];
    [mutableDict setValue:self.srl forKey:kDJRowsSrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkId] forKey:kDJRowsCheckId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemNum] forKey:kDJRowsItemNum];

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

    self.storeName = [aDecoder decodeObjectForKey:kDJRowsStoreName];
    self.checkName = [aDecoder decodeObjectForKey:kDJRowsCheckName];
    self.pankui = [aDecoder decodeDoubleForKey:kDJRowsPankui];
    self.staySum = [aDecoder decodeDoubleForKey:kDJRowsStaySum];
    self.panying = [aDecoder decodeDoubleForKey:kDJRowsPanying];
    self.realSum = [aDecoder decodeDoubleForKey:kDJRowsRealSum];
    self.orderFrom = [aDecoder decodeObjectForKey:kDJRowsOrderFrom];
    self.sid = [aDecoder decodeDoubleForKey:kDJRowsSid];
    self.bookSum = [aDecoder decodeDoubleForKey:kDJRowsBookSum];
    self.ckTime = [aDecoder decodeObjectForKey:kDJRowsCkTime];
    self.breakMoney = [aDecoder decodeDoubleForKey:kDJRowsBreakMoney];
    self.srl = [aDecoder decodeObjectForKey:kDJRowsSrl];
    self.checkId = [aDecoder decodeDoubleForKey:kDJRowsCheckId];
    self.itemNum = [aDecoder decodeDoubleForKey:kDJRowsItemNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_storeName forKey:kDJRowsStoreName];
    [aCoder encodeObject:_checkName forKey:kDJRowsCheckName];
    [aCoder encodeDouble:_pankui forKey:kDJRowsPankui];
    [aCoder encodeDouble:_staySum forKey:kDJRowsStaySum];
    [aCoder encodeDouble:_panying forKey:kDJRowsPanying];
    [aCoder encodeDouble:_realSum forKey:kDJRowsRealSum];
    [aCoder encodeObject:_orderFrom forKey:kDJRowsOrderFrom];
    [aCoder encodeDouble:_sid forKey:kDJRowsSid];
    [aCoder encodeDouble:_bookSum forKey:kDJRowsBookSum];
    [aCoder encodeObject:_ckTime forKey:kDJRowsCkTime];
    [aCoder encodeDouble:_breakMoney forKey:kDJRowsBreakMoney];
    [aCoder encodeObject:_srl forKey:kDJRowsSrl];
    [aCoder encodeDouble:_checkId forKey:kDJRowsCheckId];
    [aCoder encodeDouble:_itemNum forKey:kDJRowsItemNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    DJProductCheckSrl *copy = [[DJProductCheckSrl alloc] init];
    
    if (copy) {

        copy.storeName = [self.storeName copyWithZone:zone];
        copy.checkName = [self.checkName copyWithZone:zone];
        copy.pankui = self.pankui;
        copy.staySum = self.staySum;
        copy.panying = self.panying;
        copy.realSum = self.realSum;
        copy.orderFrom = [self.orderFrom copyWithZone:zone];
        copy.sid = self.sid;
        copy.bookSum = self.bookSum;
        copy.ckTime = [self.ckTime copyWithZone:zone];
        copy.breakMoney = self.breakMoney;
        copy.srl = [self.srl copyWithZone:zone];
        copy.checkId = self.checkId;
        copy.itemNum = self.itemNum;
    }
    
    return copy;
}


@end
