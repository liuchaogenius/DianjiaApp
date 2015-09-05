//
//  HYGLViewController.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@interface HYGLViewController : BaseViewController< UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDataSource>

@property (nonatomic, assign)BOOL isNOPushDetail;
- (void)getUserSelectList:(void(^)(NSMutableArray *selectList))aSelectBlock;
@end
