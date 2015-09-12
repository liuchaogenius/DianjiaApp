//
//  WYJHSXViewcontroller.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@interface WYJHSXViewcontroller : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIButton *dataBt;
@property (strong, nonatomic) IBOutlet UILabel *gongyingshangLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectGYSBT;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) IBOutlet UIButton *weijiesuanBT;
@property (strong, nonatomic) IBOutlet UIButton *yijiesuanBT;

@end
