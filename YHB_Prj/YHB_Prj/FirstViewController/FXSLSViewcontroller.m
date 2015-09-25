//
//  XSLSViewcontroller.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "FXSLSViewcontroller.h"
#import "FirstVCManager.h"
#import "LSMode.h"
#import "LSCell.h"
#import "DateSelectVC.h"

@interface FXSLSViewcontroller ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic)FirstVCManager *manager;
@property (strong, nonatomic) IBOutlet UIButton *dateBT;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *yingyeeLabel;
@property (strong, nonatomic) IBOutlet UILabel *zonglirunLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongdanshuLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSString *strStartTime;
@property (strong, nonatomic) NSString *strEndTime;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) NSMutableArray *modeArry;

@end

@implementation FXSLSViewcontroller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"销售流水"];
    self.manager = [FirstVCManager shareFirstVCManager];
    self.strStartTime = @"0";
    self.tableview.delegate = self;
    self.tableview.dataSource = self;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestHeadData];
    WS(weakself);
    [self.manager getSaleSrlPageApp:^(LSModeList *list) {
        if(list && list.modeArry && list.modeArry.count > 0)
        {
            weakself.modeArry = list.modeArry;
            [weakself.tableview reloadData];
        }
    }];
}
#pragma mark 添加日期bt时间
- (void)dateBtItem
{
#warning 添加日期事件
}
#pragma mark 请求头部数据
- (void)requestHeadData
{
    [self.manager getSaleSrlStatisticsApp:self.strStartTime endDate:self.strEndTime finishBlock:^(FirstMode *mode) {
        if(mode)
        {
            self.yingyeeLabel.text = [NSString stringWithFormat:@"￥%@",mode.ssMode.strRealMoney];//;
            self.zonglirunLabel.text = [NSString stringWithFormat:@"￥%@",mode.ssMode.strProFitMoney];//;
            self.zongdanshuLabel.text = mode.ssMode.strSaleCount;
        }
    }];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xslscell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LSCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(LSCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeArry.count)
    {
        LSMode *mode = [self.modeArry objectAtIndex:indexPath.row];
        [cell setCellData:mode];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeArry.count)
    {
        LSMode *mode = [self.modeArry objectAtIndex:indexPath.row];
        [self pushXIBName:@"FXSLSDetailViewController" animated:YES selector:@"setCurrentLSMode:" param:mode,nil];
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
