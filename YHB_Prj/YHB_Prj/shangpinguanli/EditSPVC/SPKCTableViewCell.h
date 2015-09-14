//
//  SPKCTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPKCTableViewCell : UITableViewCell
@property(nonatomic,strong) UITextField *countTf;
+ (CGFloat)heightForCell;
- (void)setCell:(NSString *)aStr;
- (instancetype)init;
@end
