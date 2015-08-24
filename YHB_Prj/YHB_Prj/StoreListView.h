//
//  StoreListView.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreMode;
@interface StoreListView : UIView<UITableViewDelegate,UITableViewDataSource>
- (void)didSelectStoreMode:(void(^)(StoreMode *aMode))aBlock;
- (void)setStoreList:(NSArray *)aStoreList;
@end
