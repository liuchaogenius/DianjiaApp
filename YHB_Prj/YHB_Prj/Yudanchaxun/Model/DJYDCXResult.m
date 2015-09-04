//
//  DJYDCXResult.m
//
//  Created by  Johnny on 15/9/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "DJYDCXResult.h"
#import "DJYDCXRows.h"


NSString *const kDJYDCXResultPageSize = @"pageSize";
NSString *const kDJYDCXResultPageNo = @"pageNo";
NSString *const kDJYDCXResultNeedPage = @"needPage";
NSString *const kDJYDCXResultTotalPages = @"totalPages";
NSString *const kDJYDCXResultRows = @"rows";
NSString *const kDJYDCXResultAutoCount = @"autoCount";
NSString *const kDJYDCXResultTotal = @"total";


@interface DJYDCXResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DJYDCXResult

@synthesize pageSize = _pageSize;
@synthesize pageNo = _pageNo;
@synthesize needPage = _needPage;
@synthesize totalPages = _totalPages;
@synthesize rows = _rows;
@synthesize autoCount = _autoCount;
@synthesize total = _total;


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
            self.pageSize = [[self objectOrNilForKey:kDJYDCXResultPageSize fromDictionary:dict] doubleValue];
            self.pageNo = [[self objectOrNilForKey:kDJYDCXResultPageNo fromDictionary:dict] doubleValue];
            self.needPage = [[self objectOrNilForKey:kDJYDCXResultNeedPage fromDictionary:dict] doubleValue];
            self.totalPages = [[self objectOrNilForKey:kDJYDCXResultTotalPages fromDictionary:dict] doubleValue];
    NSObject *receivedDJYDCXRows = [dict objectForKey:kDJYDCXResultRows];
    NSMutableArray *parsedDJYDCXRows = [NSMutableArray array];
    if ([receivedDJYDCXRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDJYDCXRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDJYDCXRows addObject:[DJYDCXRows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDJYDCXRows isKindOfClass:[NSDictionary class]]) {
       [parsedDJYDCXRows addObject:[DJYDCXRows modelObjectWithDictionary:(NSDictionary *)receivedDJYDCXRows]];
    }

    self.rows = [NSArray arrayWithArray:parsedDJYDCXRows];
            self.autoCount = [[self objectOrNilForKey:kDJYDCXResultAutoCount fromDictionary:dict] doubleValue];
            self.total = [[self objectOrNilForKey:kDJYDCXResultTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kDJYDCXResultPageSize];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageNo] forKey:kDJYDCXResultPageNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.needPage] forKey:kDJYDCXResultNeedPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kDJYDCXResultTotalPages];
    NSMutableArray *tempArrayForRows = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rows) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRows addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRows addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kDJYDCXResultRows];
    [mutableDict setValue:[NSNumber numberWithDouble:self.autoCount] forKey:kDJYDCXResultAutoCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kDJYDCXResultTotal];

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

    self.pageSize = [aDecoder decodeDoubleForKey:kDJYDCXResultPageSize];
    self.pageNo = [aDecoder decodeDoubleForKey:kDJYDCXResultPageNo];
    self.needPage = [aDecoder decodeDoubleForKey:kDJYDCXResultNeedPage];
    self.totalPages = [aDecoder decodeDoubleForKey:kDJYDCXResultTotalPages];
    self.rows = [aDecoder decodeObjectForKey:kDJYDCXResultRows];
    self.autoCount = [aDecoder decodeDoubleForKey:kDJYDCXResultAutoCount];
    self.total = [aDecoder decodeDoubleForKey:kDJYDCXResultTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_pageSize forKey:kDJYDCXResultPageSize];
    [aCoder encodeDouble:_pageNo forKey:kDJYDCXResultPageNo];
    [aCoder encodeDouble:_needPage forKey:kDJYDCXResultNeedPage];
    [aCoder encodeDouble:_totalPages forKey:kDJYDCXResultTotalPages];
    [aCoder encodeObject:_rows forKey:kDJYDCXResultRows];
    [aCoder encodeDouble:_autoCount forKey:kDJYDCXResultAutoCount];
    [aCoder encodeDouble:_total forKey:kDJYDCXResultTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    DJYDCXResult *copy = [[DJYDCXResult alloc] init];
    
    if (copy) {

        copy.pageSize = self.pageSize;
        copy.pageNo = self.pageNo;
        copy.needPage = self.needPage;
        copy.totalPages = self.totalPages;
        copy.rows = [self.rows copyWithZone:zone];
        copy.autoCount = self.autoCount;
        copy.total = self.total;
    }
    
    return copy;
}


@end
