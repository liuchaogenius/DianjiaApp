//
//  LoginMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginMode : NSObject

@property (nonatomic, strong) NSString *strAddDate;
@property (nonatomic, strong) NSString *strAreaCode;
@property (nonatomic, strong) NSString *strCityCode;
@property (nonatomic, strong) NSString *strCompanyName;
@property (nonatomic, strong) NSString *strContactAddr;
@property (nonatomic, strong) NSString *strCreditRating;
@property (nonatomic, strong) NSString *strEmail;
@property (nonatomic, strong) NSString *strEmpCode;
@property (nonatomic, strong) NSString *strFaceDomain;
@property (nonatomic, strong) NSString *strFaceUrl;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *strIndustryName;
@property (nonatomic, strong) NSString *strLoginUserType;
@property (nonatomic, strong) NSString *strNickName;
@property (nonatomic, strong) NSString *strPhone;
@property (nonatomic, strong) NSString *strProvinceCode;
@property (nonatomic, strong) NSString *strSid;
@property (nonatomic, strong) NSString *strToken;
@property (nonatomic, strong) NSString *strUid;
@property (nonatomic, strong) NSString *strUname;
@property (nonatomic, strong) NSString *strUserCore;
@property (nonatomic, strong) NSMutableArray *storeList;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end


@interface StoreMode:NSObject

@property (nonatomic, strong) NSString *strContactAddr;
@property (nonatomic, strong) NSString *strContactName;
@property (nonatomic, strong) NSString *strContactPhone;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *strStoreName;
@property (nonatomic, strong) NSString *strStoreType;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end
