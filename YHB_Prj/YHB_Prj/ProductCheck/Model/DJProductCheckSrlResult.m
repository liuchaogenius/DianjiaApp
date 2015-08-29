//
//  DJProductCheckSrlResult.m
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 Apple (中国大陆). All rights reserved.
//

#import "DJProductCheckSrlResult.h"
#import "DJProductCheckSrl.h"


NSString *const kDJProductCheckSrlResultPageSize = @"pageSize";
NSString *const kDJProductCheckSrlResultPageNo = @"pageNo";
NSString *const kDJProductCheckSrlResultNeedPage = @"needPage";
NSString *const kDJProductCheckSrlResultTotalPages = @"totalPages";
NSString *const kDJProductCheckSrlResultRows = @"rows";
NSString *const kDJProductCheckSrlResultAutoCount = @"autoCount";
NSString *const kDJProductCheckSrlResultTotal = @"total";


@interface DJProductCheckSrlResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DJProductCheckSrlResult

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
            self.pageSize = [[self objectOrNilForKey:kDJProductCheckSrlResultPageSize fromDictionary:dict] doubleValue];
            self.pageNo = [[self objectOrNilForKey:kDJProductCheckSrlResultPageNo fromDictionary:dict] doubleValue];
            self.needPage = [[self objectOrNilForKey:kDJProductCheckSrlResultNeedPage fromDictionary:dict] boolValue];
            self.totalPages = [[self objectOrNilForKey:kDJProductCheckSrlResultTotalPages fromDictionary:dict] doubleValue];
    NSObject *receivedDJRows = [dict objectForKey:kDJProductCheckSrlResultRows];
    NSMutableArray *parsedDJRows = [NSMutableArray array];
    if ([receivedDJRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDJRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDJRows addObject:[DJProductCheckSrl modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDJRows isKindOfClass:[NSDictionary class]]) {
       [parsedDJRows addObject:[DJProductCheckSrl modelObjectWithDictionary:(NSDictionary *)receivedDJRows]];
    }

    self.rows = [NSArray arrayWithArray:parsedDJRows];
            self.autoCount = [[self objectOrNilForKey:kDJProductCheckSrlResultAutoCount fromDictionary:dict] boolValue];
            self.total = [[self objectOrNilForKey:kDJProductCheckSrlResultTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kDJProductCheckSrlResultPageSize];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageNo] forKey:kDJProductCheckSrlResultPageNo];
    [mutableDict setValue:[NSNumber numberWithBool:self.needPage] forKey:kDJProductCheckSrlResultNeedPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kDJProductCheckSrlResultTotalPages];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kDJProductCheckSrlResultRows];
    [mutableDict setValue:[NSNumber numberWithBool:self.autoCount] forKey:kDJProductCheckSrlResultAutoCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kDJProductCheckSrlResultTotal];

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

    self.pageSize = [aDecoder decodeDoubleForKey:kDJProductCheckSrlResultPageSize];
    self.pageNo = [aDecoder decodeDoubleForKey:kDJProductCheckSrlResultPageNo];
    self.needPage = [aDecoder decodeBoolForKey:kDJProductCheckSrlResultNeedPage];
    self.totalPages = [aDecoder decodeDoubleForKey:kDJProductCheckSrlResultTotalPages];
    self.rows = [aDecoder decodeObjectForKey:kDJProductCheckSrlResultRows];
    self.autoCount = [aDecoder decodeBoolForKey:kDJProductCheckSrlResultAutoCount];
    self.total = [aDecoder decodeDoubleForKey:kDJProductCheckSrlResultTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_pageSize forKey:kDJProductCheckSrlResultPageSize];
    [aCoder encodeDouble:_pageNo forKey:kDJProductCheckSrlResultPageNo];
    [aCoder encodeBool:_needPage forKey:kDJProductCheckSrlResultNeedPage];
    [aCoder encodeDouble:_totalPages forKey:kDJProductCheckSrlResultTotalPages];
    [aCoder encodeObject:_rows forKey:kDJProductCheckSrlResultRows];
    [aCoder encodeBool:_autoCount forKey:kDJProductCheckSrlResultAutoCount];
    [aCoder encodeDouble:_total forKey:kDJProductCheckSrlResultTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    DJProductCheckSrlResult *copy = [[DJProductCheckSrlResult alloc] init];
    
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
