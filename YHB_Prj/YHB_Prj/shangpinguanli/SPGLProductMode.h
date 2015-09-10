//
//  SPGLProductMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPGLProductPicMode : NSObject
@property (nonatomic, strong) NSString *strPicUrl;
@property (nonatomic, strong) NSString *strPickDomain;
@property (nonatomic, strong) NSString *strPic;
@end

@interface SPGLProductMode : NSObject
@property (nonatomic, strong) NSString *strActEnable;

@property (nonatomic, strong) NSString *strActValue;

@property (nonatomic, strong) NSString *strBuyingPrice;

@property (nonatomic, strong) NSString *strCheckLasttime;

@property (nonatomic, strong) NSString *strCid;

@property (nonatomic, strong) NSString *strClsName;

@property (nonatomic, strong) NSString *strHasPic;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strIsScore;

@property (nonatomic, strong) NSString *strProductCode;

@property (nonatomic, strong) NSString *strProductName;

@property (nonatomic, strong) NSString *strSalePrice;

@property (nonatomic, strong) NSString *strSaleUnit;

@property (nonatomic, strong) NSString *strStayQty;

@property (nonatomic, strong) NSString *strStockQty;

@property (nonatomic, strong) NSString *strSysPid;

@property (nonatomic, strong) NSString *strUid;

@property (nonatomic, strong) NSMutableArray *picList;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end



@interface SPGLProductList : NSObject
@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic, assign) int totalNum;
@property (nonatomic, assign) int totalPage;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end
