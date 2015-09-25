//
//  LSMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMode : NSObject
@property (nonatomic, strong) NSString *strBank_payed;

@property (nonatomic, strong) NSString *strCard_payed;

@property (nonatomic, strong) NSString *strCash_payed;

@property (nonatomic, strong) NSString *strCreditId;

@property (nonatomic, strong) NSString *strDiscount_rate;

@property (nonatomic, strong) NSString *strEid;

@property (nonatomic, strong) NSString *strEmp_name;

@property (nonatomic, strong) NSString *strEndOrderTime;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strIsScore;

@property (nonatomic, strong) NSString *strLogin_name;

@property (nonatomic, strong) NSString *strOrder_class;

@property (nonatomic, strong) NSString *strOrder_time;

@property (nonatomic, strong) NSString *strOrder_type;

@property (nonatomic, strong) NSString *strPayable_money;

@property (nonatomic, strong) NSString *strPayment;

@property (nonatomic, strong) NSString *strPayrel_money;

@property (nonatomic, strong) NSString *strPayrel_money_sum;

@property (nonatomic, strong) NSString *strProfit_money;

@property (nonatomic, strong) NSString *strReal_money;

@property (nonatomic, strong) NSString *strSco_cost;

@property (nonatomic, strong) NSString *strSco_payed;

@property (nonatomic, strong) NSString *strSid;

@property (nonatomic, strong) NSString *strSrl;

@property (nonatomic, strong) NSString *strStatus;

@property (nonatomic, strong) NSString *strStock_money;

@property (nonatomic, strong) NSString *strStore_name;

@property (nonatomic, strong) NSString *strThird_payed;

@property (nonatomic, strong) NSString *strTicket_payed;

@property (nonatomic, strong) NSString *strUid;

@property (nonatomic, strong) NSString *strVip_code;

@property (nonatomic, strong) NSString *strVip_id;

@property (nonatomic, strong) NSString *strVip_name;

@property (nonatomic, strong) NSString *strVip_score;

@property (nonatomic, strong) NSString *strVip_score_type;
@end


@interface LSModeList : NSObject
@property (nonatomic, strong) NSMutableArray *modeArry;
- (void)unPacketModeData:(NSDictionary *)aDict;
@end


