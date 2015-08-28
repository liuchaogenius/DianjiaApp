//
//  DJProductCheckListCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJProductCheckListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UILabel *checkLittle;

@property (weak, nonatomic) IBOutlet UILabel *checkMuch;

@end
