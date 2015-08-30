//
//  DJCheckCartCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJCheckCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *statyQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;


@end
