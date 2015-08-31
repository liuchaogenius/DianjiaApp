//
//  SetTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTableViewCell : UITableViewCell

+ (CGFloat)heightForSetCell;
- (instancetype)initWithImgName:(NSString *)aImgName title:(NSString *)aTitle;

@end
