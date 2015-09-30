//
//  JCCXDetailMode.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/30.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCCXDetailMode : NSObject
@property (nonatomic, strong) NSString *stremp_name;

@property (nonatomic, strong) NSString *strid;

@property (nonatomic, strong) NSString *strlogin_name;

@property (nonatomic, strong) NSString *strorder_time;

@property (nonatomic, strong) NSString *strpinyin_code;

@property (nonatomic, strong) NSString *strproduct_code;

@property (nonatomic, strong) NSString *strproduct_id;

@property (nonatomic, strong) NSString *strproduct_name;

@property (nonatomic, strong) NSString *strremark;

@property (nonatomic, strong) NSString *strstatus;

@property (nonatomic, strong) NSString *strstay_id;

@property (nonatomic, strong) NSString *strstore_name;

@property (nonatomic, strong) NSString *strsurplus_num;

@property (nonatomic, strong) NSString *strsurplus_sum;

@property (nonatomic, strong) NSString *strtake_num;

@property (nonatomic, strong) NSString *strtotal_num;

@property (nonatomic, strong) NSString *strvip_code;

@property (nonatomic, strong) NSString *strvip_id;

@property (nonatomic, strong) NSString *strvip_name;

@property (nonatomic, strong) NSString *strvip_phone;
@end


@interface JCCXDetailModeList : NSObject
@property (nonatomic, strong) NSMutableArray *modeList;
- (void)unPacketData:(NSArray *)aDataDictArry;
@end




