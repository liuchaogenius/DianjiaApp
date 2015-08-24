//
//  TBThreadSafeMutableArry.m
//  TBLocationFramework
//
//  Created by  striveliu on 7/4/14.
//  Copyright (c) 2014 taobao. All rights reserved.
//

#import "ThreadSafeMutableArry.h"

#define TBRD_LOCKED(...) pthread_rwlock_rdlock(&s_pthread_rwlock_t); \
__VA_ARGS__; \
pthread_rwlock_unlock(&s_pthread_rwlock_t);

#define TBWR_LOCKED(...) pthread_rwlock_wrlock(&s_pthread_rwlock_t); \
__VA_ARGS__; \
pthread_rwlock_unlock(&s_pthread_rwlock_t);

@implementation ThreadSafeMutableArry

- (id)init {
    pthread_rwlock_init(&s_pthread_rwlock_t, NULL);
    return [self initWithCapacity:0];
}

- (void)dealloc
{
    pthread_rwlock_destroy(&s_pthread_rwlock_t);
}


- (id)initWithCapacity:(NSUInteger)capacity {
    if ((self = [super init])) {
        _mutableArry = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}

- (void)addObject:(id)anObject
{
    TBWR_LOCKED([_mutableArry addObject:anObject]);
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    TBWR_LOCKED([_mutableArry removeObjectAtIndex:index]);
}

- (void)removeAllObjects
{
    TBWR_LOCKED([_mutableArry removeAllObjects]);
}

- (void)removeLastObject
{
    TBWR_LOCKED([_mutableArry removeLastObject]);
}

- (id)objectAtIndex:(NSUInteger)index
{
    TBRD_LOCKED(id obj = [_mutableArry objectAtIndex:index]);
    return obj;
}

- (NSUInteger)getCount
{
    TBRD_LOCKED(NSUInteger count=_mutableArry.count);
    return count;
}

@end
