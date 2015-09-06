//
//  PGPicList.h
//
//  Created by  Johnny on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PGPicList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double picListIdentifier;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) double uid;
@property (nonatomic, assign) double pid;
@property (nonatomic, strong) NSString *picDomain;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
