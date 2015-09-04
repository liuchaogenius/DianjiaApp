//
//  DJYDCXRows.m
//
//  Created by  Johnny on 15/9/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "DJYDCXRows.h"
#import "DJYDCXDetailList.h"


NSString *const kDJYDCXRowsPayrelMoneySum = @"payrel_money_sum";
NSString *const kDJYDCXRowsUid = @"uid";
NSString *const kDJYDCXRowsPayrelMoney = @"payrel_money";
NSString *const kDJYDCXRowsId = @"id";
NSString *const kDJYDCXRowsEmpName = @"emp_name";
NSString *const kDJYDCXRowsVipName = @"vip_name";
NSString *const kDJYDCXRowsVipId = @"vip_id";
NSString *const kDJYDCXRowsDetailList = @"DetailList";
NSString *const kDJYDCXRowsVipPhone = @"vip_phone";
NSString *const kDJYDCXRowsDiscountRate = @"discount_rate";
NSString *const kDJYDCXRowsEndOrderTime = @"endOrderTime";
NSString *const kDJYDCXRowsSid = @"sid";
NSString *const kDJYDCXRowsRealMoney = @"real_money";
NSString *const kDJYDCXRowsCardPayed = @"card_payed";
NSString *const kDJYDCXRowsScoPayed = @"sco_payed";
NSString *const kDJYDCXRowsBankPayed = @"bank_payed";
NSString *const kDJYDCXRowsOrderTime = @"order_time";
NSString *const kDJYDCXRowsProfitMoney = @"profit_money";
NSString *const kDJYDCXRowsScoCost = @"sco_cost";
NSString *const kDJYDCXRowsSrl = @"srl";
NSString *const kDJYDCXRowsOrderClass = @"order_class";
NSString *const kDJYDCXRowsEid = @"eid";
NSString *const kDJYDCXRowsPayment = @"payment";
NSString *const kDJYDCXRowsTicketPayed = @"ticket_payed";
NSString *const kDJYDCXRowsStockMoney = @"stock_money";
NSString *const kDJYDCXRowsCreditId = @"creditId";
NSString *const kDJYDCXRowsStoreName = @"store_name";
NSString *const kDJYDCXRowsCashPayed = @"cash_payed";
NSString *const kDJYDCXRowsStatus = @"status";
NSString *const kDJYDCXRowsVipCode = @"vip_code";
NSString *const kDJYDCXRowsThirdPayed = @"third_payed";
NSString *const kDJYDCXRowsIsScore = @"isScore";
NSString *const kDJYDCXRowsOrderType = @"order_type";
NSString *const kDJYDCXRowsPayableMoney = @"payable_money";


@interface DJYDCXRows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DJYDCXRows

@synthesize payrelMoneySum = _payrelMoneySum;
@synthesize uid = _uid;
@synthesize payrelMoney = _payrelMoney;
@synthesize rowsIdentifier = _rowsIdentifier;
@synthesize empName = _empName;
@synthesize vipName = _vipName;
@synthesize vipId = _vipId;
@synthesize detailList = _detailList;
@synthesize vipPhone = _vipPhone;
@synthesize discountRate = _discountRate;
@synthesize endOrderTime = _endOrderTime;
@synthesize sid = _sid;
@synthesize realMoney = _realMoney;
@synthesize cardPayed = _cardPayed;
@synthesize scoPayed = _scoPayed;
@synthesize bankPayed = _bankPayed;
@synthesize orderTime = _orderTime;
@synthesize profitMoney = _profitMoney;
@synthesize scoCost = _scoCost;
@synthesize srl = _srl;
@synthesize orderClass = _orderClass;
@synthesize eid = _eid;
@synthesize payment = _payment;
@synthesize ticketPayed = _ticketPayed;
@synthesize stockMoney = _stockMoney;
@synthesize creditId = _creditId;
@synthesize storeName = _storeName;
@synthesize cashPayed = _cashPayed;
@synthesize status = _status;
@synthesize vipCode = _vipCode;
@synthesize thirdPayed = _thirdPayed;
@synthesize isScore = _isScore;
@synthesize orderType = _orderType;
@synthesize payableMoney = _payableMoney;


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
            self.payrelMoneySum = [self objectOrNilForKey:kDJYDCXRowsPayrelMoneySum fromDictionary:dict];
            self.uid = [[self objectOrNilForKey:kDJYDCXRowsUid fromDictionary:dict] doubleValue];
            self.payrelMoney = [self objectOrNilForKey:kDJYDCXRowsPayrelMoney fromDictionary:dict];
            self.rowsIdentifier = [[self objectOrNilForKey:kDJYDCXRowsId fromDictionary:dict] doubleValue];
            self.empName = [self objectOrNilForKey:kDJYDCXRowsEmpName fromDictionary:dict];
            self.vipName = [self objectOrNilForKey:kDJYDCXRowsVipName fromDictionary:dict];
            self.vipId = [[self objectOrNilForKey:kDJYDCXRowsVipId fromDictionary:dict] doubleValue];
    NSObject *receivedDJYDCXDetailList = [dict objectForKey:kDJYDCXRowsDetailList];
    NSMutableArray *parsedDJYDCXDetailList = [NSMutableArray array];
    if ([receivedDJYDCXDetailList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDJYDCXDetailList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDJYDCXDetailList addObject:[DJYDCXDetailList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDJYDCXDetailList isKindOfClass:[NSDictionary class]]) {
       [parsedDJYDCXDetailList addObject:[DJYDCXDetailList modelObjectWithDictionary:(NSDictionary *)receivedDJYDCXDetailList]];
    }

    self.detailList = [NSArray arrayWithArray:parsedDJYDCXDetailList];
            self.vipPhone = [[self objectOrNilForKey:kDJYDCXRowsVipPhone fromDictionary:dict] doubleValue];
            self.discountRate = [[self objectOrNilForKey:kDJYDCXRowsDiscountRate fromDictionary:dict] doubleValue];
            self.endOrderTime = [self objectOrNilForKey:kDJYDCXRowsEndOrderTime fromDictionary:dict];
            self.sid = [[self objectOrNilForKey:kDJYDCXRowsSid fromDictionary:dict] doubleValue];
            self.realMoney = [[self objectOrNilForKey:kDJYDCXRowsRealMoney fromDictionary:dict] doubleValue];
            self.cardPayed = [[self objectOrNilForKey:kDJYDCXRowsCardPayed fromDictionary:dict] doubleValue];
            self.scoPayed = [[self objectOrNilForKey:kDJYDCXRowsScoPayed fromDictionary:dict] doubleValue];
            self.bankPayed = [[self objectOrNilForKey:kDJYDCXRowsBankPayed fromDictionary:dict] doubleValue];
            self.orderTime = [self objectOrNilForKey:kDJYDCXRowsOrderTime fromDictionary:dict];
            self.profitMoney = [self objectOrNilForKey:kDJYDCXRowsProfitMoney fromDictionary:dict];
            self.scoCost = [[self objectOrNilForKey:kDJYDCXRowsScoCost fromDictionary:dict] doubleValue];
            self.srl = [self objectOrNilForKey:kDJYDCXRowsSrl fromDictionary:dict];
            self.orderClass = [[self objectOrNilForKey:kDJYDCXRowsOrderClass fromDictionary:dict] doubleValue];
            self.eid = [[self objectOrNilForKey:kDJYDCXRowsEid fromDictionary:dict] doubleValue];
            self.payment = [self objectOrNilForKey:kDJYDCXRowsPayment fromDictionary:dict];
            self.ticketPayed = [[self objectOrNilForKey:kDJYDCXRowsTicketPayed fromDictionary:dict] doubleValue];
            self.stockMoney = [self objectOrNilForKey:kDJYDCXRowsStockMoney fromDictionary:dict];
            self.creditId = [[self objectOrNilForKey:kDJYDCXRowsCreditId fromDictionary:dict] doubleValue];
            self.storeName = [self objectOrNilForKey:kDJYDCXRowsStoreName fromDictionary:dict];
            self.cashPayed = [[self objectOrNilForKey:kDJYDCXRowsCashPayed fromDictionary:dict] doubleValue];
            self.status = [[self objectOrNilForKey:kDJYDCXRowsStatus fromDictionary:dict] doubleValue];
            self.vipCode = [[self objectOrNilForKey:kDJYDCXRowsVipCode fromDictionary:dict] doubleValue];
            self.thirdPayed = [[self objectOrNilForKey:kDJYDCXRowsThirdPayed fromDictionary:dict] doubleValue];
            self.isScore = [[self objectOrNilForKey:kDJYDCXRowsIsScore fromDictionary:dict] doubleValue];
            self.orderType = [[self objectOrNilForKey:kDJYDCXRowsOrderType fromDictionary:dict] doubleValue];
            self.payableMoney = [self objectOrNilForKey:kDJYDCXRowsPayableMoney fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.payrelMoneySum forKey:kDJYDCXRowsPayrelMoneySum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uid] forKey:kDJYDCXRowsUid];
    [mutableDict setValue:self.payrelMoney forKey:kDJYDCXRowsPayrelMoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rowsIdentifier] forKey:kDJYDCXRowsId];
    [mutableDict setValue:self.empName forKey:kDJYDCXRowsEmpName];
    [mutableDict setValue:self.vipName forKey:kDJYDCXRowsVipName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vipId] forKey:kDJYDCXRowsVipId];
    NSMutableArray *tempArrayForDetailList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.detailList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDetailList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDetailList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDetailList] forKey:kDJYDCXRowsDetailList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vipPhone] forKey:kDJYDCXRowsVipPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.discountRate] forKey:kDJYDCXRowsDiscountRate];
    [mutableDict setValue:self.endOrderTime forKey:kDJYDCXRowsEndOrderTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sid] forKey:kDJYDCXRowsSid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realMoney] forKey:kDJYDCXRowsRealMoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cardPayed] forKey:kDJYDCXRowsCardPayed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scoPayed] forKey:kDJYDCXRowsScoPayed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bankPayed] forKey:kDJYDCXRowsBankPayed];
    [mutableDict setValue:self.orderTime forKey:kDJYDCXRowsOrderTime];
    [mutableDict setValue:self.profitMoney forKey:kDJYDCXRowsProfitMoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scoCost] forKey:kDJYDCXRowsScoCost];
    [mutableDict setValue:self.srl forKey:kDJYDCXRowsSrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderClass] forKey:kDJYDCXRowsOrderClass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eid] forKey:kDJYDCXRowsEid];
    [mutableDict setValue:self.payment forKey:kDJYDCXRowsPayment];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ticketPayed] forKey:kDJYDCXRowsTicketPayed];
    [mutableDict setValue:self.stockMoney forKey:kDJYDCXRowsStockMoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creditId] forKey:kDJYDCXRowsCreditId];
    [mutableDict setValue:self.storeName forKey:kDJYDCXRowsStoreName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cashPayed] forKey:kDJYDCXRowsCashPayed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kDJYDCXRowsStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vipCode] forKey:kDJYDCXRowsVipCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.thirdPayed] forKey:kDJYDCXRowsThirdPayed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isScore] forKey:kDJYDCXRowsIsScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderType] forKey:kDJYDCXRowsOrderType];
    [mutableDict setValue:self.payableMoney forKey:kDJYDCXRowsPayableMoney];

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

    self.payrelMoneySum = [aDecoder decodeObjectForKey:kDJYDCXRowsPayrelMoneySum];
    self.uid = [aDecoder decodeDoubleForKey:kDJYDCXRowsUid];
    self.payrelMoney = [aDecoder decodeObjectForKey:kDJYDCXRowsPayrelMoney];
    self.rowsIdentifier = [aDecoder decodeDoubleForKey:kDJYDCXRowsId];
    self.empName = [aDecoder decodeObjectForKey:kDJYDCXRowsEmpName];
    self.vipName = [aDecoder decodeObjectForKey:kDJYDCXRowsVipName];
    self.vipId = [aDecoder decodeDoubleForKey:kDJYDCXRowsVipId];
    self.detailList = [aDecoder decodeObjectForKey:kDJYDCXRowsDetailList];
    self.vipPhone = [aDecoder decodeDoubleForKey:kDJYDCXRowsVipPhone];
    self.discountRate = [aDecoder decodeDoubleForKey:kDJYDCXRowsDiscountRate];
    self.endOrderTime = [aDecoder decodeObjectForKey:kDJYDCXRowsEndOrderTime];
    self.sid = [aDecoder decodeDoubleForKey:kDJYDCXRowsSid];
    self.realMoney = [aDecoder decodeDoubleForKey:kDJYDCXRowsRealMoney];
    self.cardPayed = [aDecoder decodeDoubleForKey:kDJYDCXRowsCardPayed];
    self.scoPayed = [aDecoder decodeDoubleForKey:kDJYDCXRowsScoPayed];
    self.bankPayed = [aDecoder decodeDoubleForKey:kDJYDCXRowsBankPayed];
    self.orderTime = [aDecoder decodeObjectForKey:kDJYDCXRowsOrderTime];
    self.profitMoney = [aDecoder decodeObjectForKey:kDJYDCXRowsProfitMoney];
    self.scoCost = [aDecoder decodeDoubleForKey:kDJYDCXRowsScoCost];
    self.srl = [aDecoder decodeObjectForKey:kDJYDCXRowsSrl];
    self.orderClass = [aDecoder decodeDoubleForKey:kDJYDCXRowsOrderClass];
    self.eid = [aDecoder decodeDoubleForKey:kDJYDCXRowsEid];
    self.payment = [aDecoder decodeObjectForKey:kDJYDCXRowsPayment];
    self.ticketPayed = [aDecoder decodeDoubleForKey:kDJYDCXRowsTicketPayed];
    self.stockMoney = [aDecoder decodeObjectForKey:kDJYDCXRowsStockMoney];
    self.creditId = [aDecoder decodeDoubleForKey:kDJYDCXRowsCreditId];
    self.storeName = [aDecoder decodeObjectForKey:kDJYDCXRowsStoreName];
    self.cashPayed = [aDecoder decodeDoubleForKey:kDJYDCXRowsCashPayed];
    self.status = [aDecoder decodeDoubleForKey:kDJYDCXRowsStatus];
    self.vipCode = [aDecoder decodeDoubleForKey:kDJYDCXRowsVipCode];
    self.thirdPayed = [aDecoder decodeDoubleForKey:kDJYDCXRowsThirdPayed];
    self.isScore = [aDecoder decodeDoubleForKey:kDJYDCXRowsIsScore];
    self.orderType = [aDecoder decodeDoubleForKey:kDJYDCXRowsOrderType];
    self.payableMoney = [aDecoder decodeObjectForKey:kDJYDCXRowsPayableMoney];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_payrelMoneySum forKey:kDJYDCXRowsPayrelMoneySum];
    [aCoder encodeDouble:_uid forKey:kDJYDCXRowsUid];
    [aCoder encodeObject:_payrelMoney forKey:kDJYDCXRowsPayrelMoney];
    [aCoder encodeDouble:_rowsIdentifier forKey:kDJYDCXRowsId];
    [aCoder encodeObject:_empName forKey:kDJYDCXRowsEmpName];
    [aCoder encodeObject:_vipName forKey:kDJYDCXRowsVipName];
    [aCoder encodeDouble:_vipId forKey:kDJYDCXRowsVipId];
    [aCoder encodeObject:_detailList forKey:kDJYDCXRowsDetailList];
    [aCoder encodeDouble:_vipPhone forKey:kDJYDCXRowsVipPhone];
    [aCoder encodeDouble:_discountRate forKey:kDJYDCXRowsDiscountRate];
    [aCoder encodeObject:_endOrderTime forKey:kDJYDCXRowsEndOrderTime];
    [aCoder encodeDouble:_sid forKey:kDJYDCXRowsSid];
    [aCoder encodeDouble:_realMoney forKey:kDJYDCXRowsRealMoney];
    [aCoder encodeDouble:_cardPayed forKey:kDJYDCXRowsCardPayed];
    [aCoder encodeDouble:_scoPayed forKey:kDJYDCXRowsScoPayed];
    [aCoder encodeDouble:_bankPayed forKey:kDJYDCXRowsBankPayed];
    [aCoder encodeObject:_orderTime forKey:kDJYDCXRowsOrderTime];
    [aCoder encodeObject:_profitMoney forKey:kDJYDCXRowsProfitMoney];
    [aCoder encodeDouble:_scoCost forKey:kDJYDCXRowsScoCost];
    [aCoder encodeObject:_srl forKey:kDJYDCXRowsSrl];
    [aCoder encodeDouble:_orderClass forKey:kDJYDCXRowsOrderClass];
    [aCoder encodeDouble:_eid forKey:kDJYDCXRowsEid];
    [aCoder encodeObject:_payment forKey:kDJYDCXRowsPayment];
    [aCoder encodeDouble:_ticketPayed forKey:kDJYDCXRowsTicketPayed];
    [aCoder encodeObject:_stockMoney forKey:kDJYDCXRowsStockMoney];
    [aCoder encodeDouble:_creditId forKey:kDJYDCXRowsCreditId];
    [aCoder encodeObject:_storeName forKey:kDJYDCXRowsStoreName];
    [aCoder encodeDouble:_cashPayed forKey:kDJYDCXRowsCashPayed];
    [aCoder encodeDouble:_status forKey:kDJYDCXRowsStatus];
    [aCoder encodeDouble:_vipCode forKey:kDJYDCXRowsVipCode];
    [aCoder encodeDouble:_thirdPayed forKey:kDJYDCXRowsThirdPayed];
    [aCoder encodeDouble:_isScore forKey:kDJYDCXRowsIsScore];
    [aCoder encodeDouble:_orderType forKey:kDJYDCXRowsOrderType];
    [aCoder encodeObject:_payableMoney forKey:kDJYDCXRowsPayableMoney];
}

- (id)copyWithZone:(NSZone *)zone
{
    DJYDCXRows *copy = [[DJYDCXRows alloc] init];
    
    if (copy) {

        copy.payrelMoneySum = [self.payrelMoneySum copyWithZone:zone];
        copy.uid = self.uid;
        copy.payrelMoney = [self.payrelMoney copyWithZone:zone];
        copy.rowsIdentifier = self.rowsIdentifier;
        copy.empName = [self.empName copyWithZone:zone];
        copy.vipName = [self.vipName copyWithZone:zone];
        copy.vipId = self.vipId;
        copy.detailList = [self.detailList copyWithZone:zone];
        copy.vipPhone = self.vipPhone;
        copy.discountRate = self.discountRate;
        copy.endOrderTime = [self.endOrderTime copyWithZone:zone];
        copy.sid = self.sid;
        copy.realMoney = self.realMoney;
        copy.cardPayed = self.cardPayed;
        copy.scoPayed = self.scoPayed;
        copy.bankPayed = self.bankPayed;
        copy.orderTime = [self.orderTime copyWithZone:zone];
        copy.profitMoney = [self.profitMoney copyWithZone:zone];
        copy.scoCost = self.scoCost;
        copy.srl = [self.srl copyWithZone:zone];
        copy.orderClass = self.orderClass;
        copy.eid = self.eid;
        copy.payment = [self.payment copyWithZone:zone];
        copy.ticketPayed = self.ticketPayed;
        copy.stockMoney = [self.stockMoney copyWithZone:zone];
        copy.creditId = self.creditId;
        copy.storeName = [self.storeName copyWithZone:zone];
        copy.cashPayed = self.cashPayed;
        copy.status = self.status;
        copy.vipCode = self.vipCode;
        copy.thirdPayed = self.thirdPayed;
        copy.isScore = self.isScore;
        copy.orderType = self.orderType;
        copy.payableMoney = [self.payableMoney copyWithZone:zone];
    }
    
    return copy;
}


@end
