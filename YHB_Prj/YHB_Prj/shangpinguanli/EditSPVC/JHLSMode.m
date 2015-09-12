//
//  JHLSMode.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JHLSMode.h"

@implementation JHLSMode
- (void)unPacketData:(NSDictionary *)aDataDict
{
    
    AssignMentID(self.strAdd_date, [aDataDict objectForKey:@"add_date"]);

    AssignMentID(self.strId, [aDataDict objectForKey:@"id"]);
    BaseIntToNSString(self.strId);
    
    AssignMentID(self.strProduct_code, [aDataDict objectForKey:@"product_code"]);

    AssignMentID(self.strProduct_id, [aDataDict objectForKey:@"product_id"]);
    BaseIntToNSString(self.strProduct_id);
    
    AssignMentID(self.strProduct_name, [aDataDict objectForKey:@"product_name"]);

    AssignMentID(self.strSale_price, [aDataDict objectForKey:@"sale_price"]);
    BaseIntToNSString(self.strSale_price);
    
    AssignMentID(self.strShelf_dys, [aDataDict objectForKey:@"shelf_dys"]);
    BaseIntToNSString(self.strShelf_dys);
    
    AssignMentID(self.strStay_qty, [aDataDict objectForKey:@"stay_qty"]);
    BaseLongLongToNSString(self.strStay_qty);
    
    AssignMentID(self.strStock_num, [aDataDict objectForKey:@"stock_num"]);
    BaseIntToNSString(self.strStock_num);
    
    AssignMentID(self.strStock_price, [aDataDict objectForKey:@"stock_price"]);
    
    AssignMentID(self.strStock_qty, [aDataDict objectForKey:@"stock_qty"]);
    BaseIntToNSString(self.strStock_qty);
    
    AssignMentID(self.strSup_id, [aDataDict objectForKey:@"sup_id"]);
    BaseFloadToNSString(self.strSup_id);
    
    AssignMentID(self.strSup_name, [aDataDict objectForKey:@"sup_name"]);
}
@end

@implementation JHLSList

- (instancetype)init
{
    if(self = [super init]){
        self.productList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)unPacketData:(NSDictionary *)aDataDict
{
    NSArray *arry = [aDataDict objectForKey:@"rows"];
    if(arry && arry.count > 0)
    {
        for(NSDictionary *dict in arry)
        {
            JHLSMode *mode = [[JHLSMode alloc] init];
            [mode unPacketData:dict];
            [self.productList addObject:mode];
        }
    }
}


@end
