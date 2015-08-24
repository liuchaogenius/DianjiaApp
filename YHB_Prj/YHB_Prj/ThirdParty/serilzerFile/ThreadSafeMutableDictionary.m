//
//  TBSDKThreadSafeMutableDictionary.m
//  TBSDKNetworkSDK
//
//  Created by Roger.Mu on 6/30/14.
//  Copyright (c) 2014 Alibaba-Inc. All rights reserved.
//

#import "ThreadSafeMutableDictionary.h"
#import <pthread.h>

#define RD_LOCKED(...) pthread_rwlock_rdlock(&s_pthread_rwlock_t); \
__VA_ARGS__; \
pthread_rwlock_unlock(&s_pthread_rwlock_t);

#define WR_LOCKED(...) pthread_rwlock_wrlock(&s_pthread_rwlock_t); \
__VA_ARGS__; \
pthread_rwlock_unlock(&s_pthread_rwlock_t);

@implementation ThreadSafeMutableDictionary
{
    pthread_rwlock_t s_pthread_rwlock_t;
    NSMutableDictionary *_dictionary;
}

#pragma mark - NSObject

- (id)init {
    return [self initWithCapacity:0];
}

- (void)dealloc
{
    pthread_rwlock_destroy(&s_pthread_rwlock_t);
}

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    if ((self = [self initWithCapacity:objects.count])) {
        [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            _dictionary[keys[idx]] = obj;
        }];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity
{
    if ((self = [super init]))
    {
        _dictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        pthread_rwlock_init(&s_pthread_rwlock_t, NULL);
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    WR_LOCKED(_dictionary[aKey] = anObject)
}

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    WR_LOCKED([_dictionary addEntriesFromDictionary:otherDictionary]);
}

- (void)setDictionary:(NSDictionary *)otherDictionary {
    WR_LOCKED([_dictionary setDictionary:otherDictionary]);
}

- (void)removeObjectForKey:(id)aKey {
    WR_LOCKED([_dictionary removeObjectForKey:aKey])
}

- (void)removeAllObjects {
    WR_LOCKED([_dictionary removeAllObjects]);
}

- (NSUInteger)count {
    RD_LOCKED(NSUInteger count = _dictionary.count)
    return count;
}

- (NSArray *)allKeys {
    RD_LOCKED(NSArray *allKeys = _dictionary.allKeys)
    return allKeys;
}

- (NSArray *)allValues {
    RD_LOCKED(NSArray *allValues = _dictionary.allValues)
    return allValues;
}

- (id)objectForKey:(id)aKey {
    RD_LOCKED(id obj = _dictionary[aKey])
    return obj;
}

- (NSEnumerator *)keyEnumerator {
    RD_LOCKED(NSEnumerator *keyEnumerator = [_dictionary keyEnumerator])
    return keyEnumerator;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self mutableCopyWithZone:zone];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    RD_LOCKED(id copiedDictionary = [[self.class allocWithZone:zone] initWithDictionary:_dictionary])
    return copiedDictionary;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])stackbuf
                                    count:(NSUInteger)len {
    RD_LOCKED(NSUInteger count = [[_dictionary copy] countByEnumeratingWithState:state objects:stackbuf count:len]);
    return count;
}

- (void)performLockedWithDictionary:(void (^)(NSDictionary *dictionary))block {
    if (block) RD_LOCKED(block(_dictionary));
}

//- (BOOL)isEqual:(id)object {
//    if (object == self) return YES;
//
//    if ([object isKindOfClass:PSPDFThreadSafeMutableDictionary.class]) {
//        PSPDFThreadSafeMutableDictionary *other = object;
//        __block BOOL isEqual = NO;
//        [other performLockedWithDictionary:^(NSDictionary *dictionary) {
//            [self performLockedWithDictionary:^(NSDictionary *otherDictionary) {
//                isEqual = [dictionary isEqual:otherDictionary];
//            }];
//        }];
//        return isEqual;
//    }
//    return NO;
//}

@end