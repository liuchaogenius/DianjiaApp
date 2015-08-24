//
//  JsonToModel.h
//  Json2ModelDemo
//
//  Created by striveliu on 14-7-24.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonToModel : NSObject

+ (NSDictionary *)dictionaryFromObject:(id)object key:(NSString *)aKey;

//+ (NSArray *)propertiesFromObject:(id)object;

+ (id)objectFromDictionary:(NSDictionary *)dictionary
                 className:(NSString *)name
                       key:(NSString *)aKey
                     valid:(BOOL)isValid;

@end
