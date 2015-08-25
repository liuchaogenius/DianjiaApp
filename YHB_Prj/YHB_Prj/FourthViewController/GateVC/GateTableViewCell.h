//
//  GateTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GateTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *locaLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

+ (CGFloat)heightForGateCell;

@end
