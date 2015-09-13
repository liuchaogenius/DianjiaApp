//
//  YPDMTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPDMTableViewCell : UITableViewCell

@property(nonatomic) int row;

+ (CGFloat)heightForCell:(NSString *)str;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellWithString:(NSString *)str andDeleteBlock:(void(^)(int))aDeleteBlock;
@end
