//
//  ProblemGoodsManager.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/6.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProblemGoodsManager : NSObject

-(void)getProblemGoodsListWithFinishBlock:(void (^)(NSArray *))FBlock isRefresh:(BOOL)isRefresh;
@end
