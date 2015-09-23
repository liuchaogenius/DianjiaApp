//
//  RukuDetailViewController.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
typedef enum
{
    type_shenhe_none, //没有操作
    type_shenhe_success, //审核成功
    type_shenhe_clear = 2, //清除成功
}type_shenhe_status;
@interface RukuDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
- (void)obserModeDealStatus:(void(^)(int status))aDealBlock;
@end
