//
//  JCCXSXViewController.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/5.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
@class YDCXManager;
@interface JCCXSXViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
- (void)setYDCXManager:(YDCXManager *)aManager andPopBlock:(void(^)(void))aPopBlock;
- (void)setOKButtonFinishBlock:(void(^)(void))aPopBlock;
@end
