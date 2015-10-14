//
//  SPGLSearchVC.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPGLManager;
typedef NS_ENUM(NSUInteger, SearchFrom) {
    SearchFromSPGL = 0, //商品管理
    SearchFromPD, //盘点
};

@interface SPGLSearchVC : BaseViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, assign) SearchFrom serchFrom;
@property(nonatomic, assign) BOOL isJumpFromPanDian;
- (void)setMnager:(SPGLManager *)aManager;
- (void)setMnagerAndCode:(SPGLManager *)aManager procode:(NSString *)aProcode;
@end
