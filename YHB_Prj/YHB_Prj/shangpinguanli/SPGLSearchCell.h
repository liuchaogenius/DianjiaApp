//
//  SPGLSearchCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGLProductMode.h"

@interface SPGLSearchCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headUrl;
@property (strong, nonatomic) IBOutlet UILabel *pinming;
@property (strong, nonatomic) IBOutlet UILabel *jinjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *kucunlabel;
@property (strong, nonatomic) IBOutlet UILabel *shoujiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekouLabel;
- (void)setCellData:(SPGLProductMode *)aMode;

@end
