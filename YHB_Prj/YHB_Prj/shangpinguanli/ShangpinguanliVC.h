//
//  ShangpinguanliVC.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
#import "DJScanViewController.h"
@interface ShangpinguanliVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,DJScanDelegate>
//是否来自盘点车
@property(nonatomic, assign) BOOL isFromProductCheckCart;

@end
