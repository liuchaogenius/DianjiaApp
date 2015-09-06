//
//  PGPicList.m
//
//  Created by  Johnny on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PGPicList.h"


NSString *const kPGPicListId = @"id";
NSString *const kPGPicListPicUrl = @"pic_url";
NSString *const kPGPicListUid = @"uid";
NSString *const kPGPicListPid = @"pid";
NSString *const kPGPicListPicDomain = @"pic_domain";


@interface PGPicList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PGPicList

@synthesize picListIdentifier = _picListIdentifier;
@synthesize picUrl = _picUrl;
@synthesize uid = _uid;
@synthesize pid = _pid;
@synthesize picDomain = _picDomain;


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
            self.picListIdentifier = [[self objectOrNilForKey:kPGPicListId fromDictionary:dict] doubleValue];
            self.picUrl = [self objectOrNilForKey:kPGPicListPicUrl fromDictionary:dict];
            self.uid = [[self objectOrNilForKey:kPGPicListUid fromDictionary:dict] doubleValue];
            self.pid = [[self objectOrNilForKey:kPGPicListPid fromDictionary:dict] doubleValue];
            self.picDomain = [self objectOrNilForKey:kPGPicListPicDomain fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.picListIdentifier] forKey:kPGPicListId];
    [mutableDict setValue:self.picUrl forKey:kPGPicListPicUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uid] forKey:kPGPicListUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pid] forKey:kPGPicListPid];
    [mutableDict setValue:self.picDomain forKey:kPGPicListPicDomain];

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

    self.picListIdentifier = [aDecoder decodeDoubleForKey:kPGPicListId];
    self.picUrl = [aDecoder decodeObjectForKey:kPGPicListPicUrl];
    self.uid = [aDecoder decodeDoubleForKey:kPGPicListUid];
    self.pid = [aDecoder decodeDoubleForKey:kPGPicListPid];
    self.picDomain = [aDecoder decodeObjectForKey:kPGPicListPicDomain];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_picListIdentifier forKey:kPGPicListId];
    [aCoder encodeObject:_picUrl forKey:kPGPicListPicUrl];
    [aCoder encodeDouble:_uid forKey:kPGPicListUid];
    [aCoder encodeDouble:_pid forKey:kPGPicListPid];
    [aCoder encodeObject:_picDomain forKey:kPGPicListPicDomain];
}

- (id)copyWithZone:(NSZone *)zone
{
    PGPicList *copy = [[PGPicList alloc] init];
    
    if (copy) {

        copy.picListIdentifier = self.picListIdentifier;
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.uid = self.uid;
        copy.pid = self.pid;
        copy.picDomain = [self.picDomain copyWithZone:zone];
    }
    
    return copy;
}


@end
