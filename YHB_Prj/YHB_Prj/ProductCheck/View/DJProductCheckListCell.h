//
//  DJProductCheckListCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJProductCheckListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTextLabel;

@end
