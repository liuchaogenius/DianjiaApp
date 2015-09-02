//
//  SupplierMode.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/1.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplierMode : NSObject

@property (nonatomic, strong) NSString *strAddress;
@property (nonatomic, strong) NSString *strContact;
@property (nonatomic, strong) NSString *strEmail;
@property (nonatomic, strong) NSString *strFax;
@property (nonatomic, strong) NSString *strRemark;
@property (nonatomic, strong) NSString *strSupName;
@property (nonatomic, strong) NSString *strTel;
@property (nonatomic, strong) NSString *strid;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface SupplierModeList : NSObject

@property (nonatomic, strong) NSMutableArray *supplierList;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end
