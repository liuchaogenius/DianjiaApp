//
//  YDCXManager.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YDCXManager.h"
#import "NetManager.h"
#import "LoginManager.h"
#import "DJYDCXResult.h"

@interface YDCXManager()
{
    int _currentPage_all;
    int _currentPage_no;
    int _currentPage_yes;
    NSString *_strVipId;
    NSString *_strStartTime;
    NSString *_strEndTime;
    NSString *_strSid;
}
@end

@implementation YDCXManager

- (void)appGetVipCerditListArr:(int)aStatus isRefresh:(BOOL)aIsRefresh finishBlock:(void (^)(NSArray *))aFinishBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:[NSNumber numberWithInt:aStatus] forKey:@"Status"];
    if (aIsRefresh==YES)
    {
        _currentPage_yes = 0;
        _currentPage_no = 0;
        _currentPage_all = 0;
    }
    if(aStatus == VipCerditStatusAll)
    {
        [dict setValue:[NSNumber numberWithInt:_currentPage_all] forKey:@"pageNo"];
    }
    else if(aStatus == VipCerditStatusNo)
    {
        [dict setValue:[NSNumber numberWithInt:_currentPage_no] forKey:@"pageNo"];
    }
    else if(aStatus == VipCerditStatusYes)
    {
        [dict setValue:[NSNumber numberWithInt:_currentPage_yes] forKey:@"pageNo"];
    }
    [dict setValue:@20 forKey:@"pageSize"];
    [dict setValue:@"false" forKey:@"needPage"];
    if(_strStartTime)
    {
        [dict setValue:_strStartTime forKey:@"BeginDate"];
    }
    if(_strEndTime)
    {
        [dict setValue:_strEndTime forKey:@"EndDate"];
    }
    if(_strVipId)
    {
        [dict setValue:_strVipId forKey:@"vipId"];
    }
    if(_strSid)
    {
        [dict setValue:_strSid forKey:@"sid"];
    }
    [NetManager requestWith:dict apiName:@"getVipCerditListPage" method:@"POST" succ:^(NSDictionary *successDict) {
//        MLOG(@"%@",successDict);
        NSDictionary *dict = [successDict objectForKey:@"result"];
        if(dict)
        {
            DJYDCXResult *resultMode = [DJYDCXResult modelObjectWithDictionary:dict];
            aFinishBlock(resultMode.rows);
            if(aStatus == VipCerditStatusAll)
            {
                _currentPage_all++;
            }
            else if(aStatus == VipCerditStatusNo)
            {
                _currentPage_no++;
            }
            else if(aStatus == VipCerditStatusYes)
            {
                _currentPage_yes++;
            }
        }
        else
        {
            aFinishBlock(nil);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        {
            aFinishBlock(nil);
        }
    }];

}

- (void)setCurrentSid:(NSString *)aSid
{
    _strSid = aSid;
}

- (void)setCurrentVipid:(NSString *)aVipId
{
    _strVipId = aVipId;
}

- (void)setStartTime:(NSString *)aStartTime
{
    _strStartTime = aStartTime;
}

- (void)setEndTime:(NSString *)aEndTime
{
    _strEndTime = aEndTime;
}

@end
