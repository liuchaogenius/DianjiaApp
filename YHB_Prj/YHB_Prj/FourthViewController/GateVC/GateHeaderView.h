//
//  GateHeaderView.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GateHeaderView : UITableViewHeaderFooterView

+ (CGFloat)HeightForGateHeaderView;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setTitle:(NSString *)aTitle;
@end
