//
//  CLTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)aWidth;
@end
