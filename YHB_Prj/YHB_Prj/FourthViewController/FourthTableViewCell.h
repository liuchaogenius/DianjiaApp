//
//  FourthTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/24.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cellImgView;
@property (strong, nonatomic) IBOutlet UILabel *cellTitleLabel;

+ (CGFloat)heightForFourthCell;

@end
