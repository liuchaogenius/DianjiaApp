//
//  FXSLSDetailViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "FXSLSDetailViewController.h"
#import "LSDetailCell.h"
#import "FirstVCManager.h"
#import "LSDetailMode.h"
#import "LSMode.h"

@interface FXSLSDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *yuanjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekouLabel;
@property (strong, nonatomic) IBOutlet UILabel *lirunLabel;
@property (strong, nonatomic) IBOutlet UILabel *shishouLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) FirstVCManager *manager;
@property (strong, nonatomic) LSMode *mode;
@property (strong, nonatomic) NSMutableArray *modeArry;
@end

@implementation FXSLSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"流水详情"];
    self.manager = [FirstVCManager shareFirstVCManager];
    // Do any additional setup after loading the view from its nib.
    self.yuanjiaLabel.text = [NSString stringWithFormat:@"¥%@",self.mode.strPayable_money];
    self.zhekouLabel.text = [NSString stringWithFormat:@"%@%@",self.mode.strDiscount_rate,@"%"];
    self.lirunLabel.text = [NSString stringWithFormat:@"¥%@",self.mode.strProfit_money];
    self.shishouLabel.text = [NSString stringWithFormat:@"¥%@",self.mode.strReal_money];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    WS(weakself);
    [super viewWillAppear:animated];
    [self.manager getSaleSrlDetailByApp:self.mode.strId block:^(LSDetailModeList *list) {
       if(list && list.modeArry && list.modeArry.count>0)
       {
           weakself.modeArry = list.modeArry;
           [weakself.tableview reloadData];
       }
    }];
}
- (void)setCurrentLSMode:(LSMode *)aMode
{
    self.mode = aMode;
}

#pragma mark - UITableViewDataSource
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeArry.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lsdetailCell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LSDetailCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(LSDetailCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeArry.count)
    {
        LSDetailMode *mode = [self.modeArry objectAtIndex:indexPath.row];
        [cell setCellData:mode];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
