//
//  LSDetailMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDetailMode : NSObject
@property (nonatomic, strong) NSString *strcard_use_num;

@property (nonatomic, strong) NSString *strdiscount_rate;

@property (nonatomic, strong) NSString *streid;

@property (nonatomic, strong) NSString *strid;

@property (nonatomic, strong) NSString *strpayable_money;

@property (nonatomic, strong) NSString *strproduct_code;

@property (nonatomic, strong) NSString *strproduct_id;

@property (nonatomic, strong) NSString *strproduct_name;

@property (nonatomic, strong) NSString *strreal_money;

@property (nonatomic, strong) NSString *strsale_id;

@property (nonatomic, strong) NSString *strsale_num;

@property (nonatomic, strong) NSString *strsale_price;

@property (nonatomic, strong) NSString *strsid;

@property (nonatomic, strong) NSString *strsrl;

@property (nonatomic, strong) NSString *strsrl_status;

@property (nonatomic, strong) NSString *strstock_price;

@property (nonatomic, strong) NSString *struid;
@end

@interface LSDetailModeList : NSObject
@property (nonatomic, strong) NSMutableArray *modeArry;
- (void)unPacketData:(NSDictionary *)aDataDict;
@end

