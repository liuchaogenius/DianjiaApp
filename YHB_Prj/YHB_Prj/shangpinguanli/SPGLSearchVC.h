//
//  SPGLSearchVC.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPGLManager;
@interface SPGLSearchVC : BaseViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
- (void)setMnagerAndCode:(SPGLManager *)aManager procode:(NSString *)aProcode;
@end
