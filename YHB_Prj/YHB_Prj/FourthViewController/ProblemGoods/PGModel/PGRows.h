//
//  PGRows.h
//
//  Created by  Johnny on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PGRows : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double rowsIdentifier;
@property (nonatomic, assign) double stayQty;
@property (nonatomic, assign) double sysPid;
@property (nonatomic, assign) double uid;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *clsName;
@property (nonatomic, assign) double stockQty;
@property (nonatomic, strong) NSString *checkLastTime;
@property (nonatomic, assign) double actValue;
@property (nonatomic, assign) double buyingPrice;
@property (nonatomic, assign) double cid;
@property (nonatomic, assign) double hasPic;
@property (nonatomic, assign) double salePrice;
@property (nonatomic, strong) NSArray *picList;
@property (nonatomic, assign) double isScore;
@property (nonatomic, assign) double productCode;
@property (nonatomic, assign) double actEnabled;
@property (nonatomic, strong) NSString *saleUnit;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
