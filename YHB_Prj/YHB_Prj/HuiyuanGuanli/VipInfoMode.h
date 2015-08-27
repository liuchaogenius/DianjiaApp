//
//  VipInfoMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipInfoMode : NSObject
@property (nonatomic, strong) NSString *strCardNum;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strPortraitDomain;

@property (nonatomic, strong) NSString *strPortraitUrl;

@property (nonatomic, strong) NSString *strQQ;

@property (nonatomic, strong) NSString *strRemark;

@property (nonatomic, strong) NSString *strSaleMoney;

@property (nonatomic, strong) NSString *strVipAddr;

@property (nonatomic, strong) NSString *strVipBirethday;

@property (nonatomic, strong) NSString *strVipCode;

@property (nonatomic, strong) NSString *strVipDiscount;

@property (nonatomic, strong) NSString *strVipLevel;

@property (nonatomic, strong) NSString *strVipName;

@property (nonatomic, strong) NSString *strVipPhone;

@property (nonatomic, strong) NSString *strVipScore;

@property (nonatomic, strong) NSString *strVipSex;

@property (nonatomic, strong) NSString *strWeixin;
@property (nonatomic, assign) BOOL isHasRemark;

@property (nonatomic, assign) BOOL isSelect;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

@interface VipInfoList : NSObject
@property (nonatomic, strong) NSMutableArray *modeList;

- (void)unPacketData:(NSArray *)aDataArry;
@end
