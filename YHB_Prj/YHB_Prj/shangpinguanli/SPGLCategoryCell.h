//
//  SPGLCategoryCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPGLCategoryCell : UITableViewCell
{
    UIView *line;
}
@property (nonatomic, strong) UILabel *label;

- (void)setCategoryName:(NSString *)aName tableviewTag:(int)aTag;
@end
