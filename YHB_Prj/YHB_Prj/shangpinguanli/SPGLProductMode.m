//
//  SPGLProductMode.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLProductMode.h"

@implementation SPGLProductPicMode

- (void)unPacketData:(NSDictionary *)aDataDict
{
    self.strPicUrl = [aDataDict objectForKey:@"pic_url"];
    self.strPickDomain = [aDataDict objectForKey:@"pic_domain"];
    self.strPic = [NSString stringWithFormat:@"%@%@",self.strPickDomain,self.strPicUrl];
}

@end

@implementation SPGLProductMode
- (instancetype)init
{
    if(self = [super init]){
        self.picList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strActEnable, [aDataDict objectForKey:@"act_enabled"]);
    BaseIntToNSString(self.strActEnable);
    AssignMentID(self.strActValue, [aDataDict objectForKey:@"act_value"]);
    BaseIntToNSString(self.strActValue);
    AssignMentID(self.strBuyingPrice, [aDataDict objectForKey:@"buying_price"]);
    BaseFloadToNSString(self.strBuyingPrice);
    AssignMentID(self.strCheckLasttime, [aDataDict objectForKey:@"check_last_time"]);
    
    AssignMentID(self.strCid, [aDataDict objectForKey:@"cid"]);
    BaseIntToNSString(self.strCid);
    AssignMentID(self.strClsName, [aDataDict objectForKey:@"cls_name"]);
    
    AssignMentID(self.strHasPic, [aDataDict objectForKey:@"has_pic"]);
    BaseIntToNSString(self.strHasPic);
    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseLongLongToNSString(self.strId);
    AssignMentID(self.strIsScore, [aDataDict objectForKey:@"is_score"]);
    BaseIntToNSString(self.strIsScore);
    AssignMentID(self.strProductCode, [aDataDict objectForKey:@"product_code"]);
    
    AssignMentID(self.strProductName, [aDataDict objectForKey:@"product_name"]);
    
    AssignMentID(self.strSalePrice, [aDataDict objectForKey:@"sale_price"]);
    BaseFloadToNSString(self.strSalePrice);
    AssignMentID(self.strSaleUnit, [aDataDict objectForKey:@"sale_unit"]);
    
    AssignMentID(self.strStayQty, [aDataDict objectForKey:@"sstay_qty"]);
    BaseIntToNSString(self.strStayQty);
    AssignMentID(self.strStockQty, [aDataDict objectForKey:@"stockQty"]);
    BaseIntToNSString(self.strStockQty);
    AssignMentID(self.strSysPid, [aDataDict objectForKey:@"sysPid"]);
    BaseIntToNSString(self.strSysPid);
    AssignMentID(self.strUid, [aDataDict objectForKey:@"uid"]);
    BaseIntToNSString(self.strUid);
    
    AssignMentID(self.strSupid, [aDataDict objectForKey:@"sup_id"]);
    BaseFloadToNSString(self.strSupid);
    AssignMentID(self.strSupName, [aDataDict objectForKey:@"sup_name"]);
    
    NSArray *arry = [aDataDict objectForKey:@"picList"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            SPGLProductPicMode *picMode = [[SPGLProductPicMode alloc] init];
            [picMode unPacketData:dict];
            [self.picList addObject:picMode];
        }
    }
}
@end

@implementation SPGLProductList

- (instancetype)init
{
    if(self = [super init]){
        self.productList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    self.totalPage = [[aDataDict objectForKey:@"totalPages"] intValue];
    self.totalNum = [[aDataDict objectForKey:@"total"] intValue];
    NSArray *arry = [aDataDict objectForKey:@"rows"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            SPGLProductMode *mode = [[SPGLProductMode alloc] init];
            [mode unPacketData:dict];
            [self.productList addObject:mode];
        }
    }
}

@end


