//
//  PGResult.m
//
//  Created by  Johnny on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PGResult.h"
#import "PGRows.h"


NSString *const kPGResultAutoCount = @"autoCount";
NSString *const kPGResultNeedPage = @"needPage";
NSString *const kPGResultRows = @"rows";
NSString *const kPGResultPageSize = @"pageSize";
NSString *const kPGResultPageNo = @"pageNo";


@interface PGResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PGResult

@synthesize autoCount = _autoCount;
@synthesize needPage = _needPage;
@synthesize rows = _rows;
@synthesize pageSize = _pageSize;
@synthesize pageNo = _pageNo;


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
            self.autoCount = [[self objectOrNilForKey:kPGResultAutoCount fromDictionary:dict] doubleValue];
            self.needPage = [[self objectOrNilForKey:kPGResultNeedPage fromDictionary:dict] doubleValue];
    NSObject *receivedPGRows = [dict objectForKey:kPGResultRows];
    NSMutableArray *parsedPGRows = [NSMutableArray array];
    if ([receivedPGRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPGRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPGRows addObject:[PGRows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPGRows isKindOfClass:[NSDictionary class]]) {
       [parsedPGRows addObject:[PGRows modelObjectWithDictionary:(NSDictionary *)receivedPGRows]];
    }

    self.rows = [NSArray arrayWithArray:parsedPGRows];
            self.pageSize = [[self objectOrNilForKey:kPGResultPageSize fromDictionary:dict] doubleValue];
            self.pageNo = [[self objectOrNilForKey:kPGResultPageNo fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.autoCount] forKey:kPGResultAutoCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.needPage] forKey:kPGResultNeedPage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kPGResultRows];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kPGResultPageSize];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageNo] forKey:kPGResultPageNo];

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

    self.autoCount = [aDecoder decodeDoubleForKey:kPGResultAutoCount];
    self.needPage = [aDecoder decodeDoubleForKey:kPGResultNeedPage];
    self.rows = [aDecoder decodeObjectForKey:kPGResultRows];
    self.pageSize = [aDecoder decodeDoubleForKey:kPGResultPageSize];
    self.pageNo = [aDecoder decodeDoubleForKey:kPGResultPageNo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_autoCount forKey:kPGResultAutoCount];
    [aCoder encodeDouble:_needPage forKey:kPGResultNeedPage];
    [aCoder encodeObject:_rows forKey:kPGResultRows];
    [aCoder encodeDouble:_pageSize forKey:kPGResultPageSize];
    [aCoder encodeDouble:_pageNo forKey:kPGResultPageNo];
}

- (id)copyWithZone:(NSZone *)zone
{
    PGResult *copy = [[PGResult alloc] init];
    
    if (copy) {

        copy.autoCount = self.autoCount;
        copy.needPage = self.needPage;
        copy.rows = [self.rows copyWithZone:zone];
        copy.pageSize = self.pageSize;
        copy.pageNo = self.pageNo;
    }
    
    return copy;
}


@end
