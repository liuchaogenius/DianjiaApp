//
//  JHLSMode.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHLSMode : NSObject
@property (nonatomic, strong) NSString *strAdd_date;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strProduct_code;

@property (nonatomic, strong) NSString *strProduct_id;

@property (nonatomic, strong) NSString *strProduct_name;

@property (nonatomic, strong) NSString *strSale_price;

@property (nonatomic, strong) NSString *strShelf_dys;

@property (nonatomic, strong) NSString *strStay_qty;

@property (nonatomic, strong) NSString *strStock_num;

@property (nonatomic, strong) NSString *strStock_price;

@property (nonatomic, strong) NSString *strStock_qty;

@property (nonatomic, strong) NSString *strSup_id;

@property (nonatomic, strong) NSString *strSup_name;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface JHLSList : NSObject
@property (nonatomic, strong) NSMutableArray *productList;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end
