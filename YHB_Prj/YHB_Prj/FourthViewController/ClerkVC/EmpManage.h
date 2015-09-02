//
//  EmpManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/2.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmpManage : NSObject

- (void)getEmpListWithFinishBlock:(void (^)(NSArray *resultArr))FBlock;

@end
