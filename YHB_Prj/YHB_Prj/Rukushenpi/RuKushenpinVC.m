//
//  RuKushenpinVC.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RuKushenpinVC.h"
#import "RKSPManager.h"
#import "RKSPMode.h"
#import "RKSPCell.h"
#import "SXViewController.h"
#import "RukuDetailViewController.h"
@interface RuKushenpinVC ()
@property (strong, nonatomic) IBOutlet UIButton *quanbuBT;
@property (nonatomic,strong) RKSPManager *manager;
@property (strong, nonatomic) IBOutlet UIButton *weishenheBT;
@property (strong, nonatomic) IBOutlet UIButton *shaixuanBT;
@property (strong, nonatomic) IBOutlet UIButton *yishenheBT;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *weishenheArry;
@property (strong,nonatomic) NSMutableArray *yishenheArry;
@property (strong,nonatomic) NSMutableArray *quanbuArry;
@property (assign, nonatomic)int selType;
@end

@implementation RuKushenpinVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.selType = 1;
        self.manager = [[RKSPManager alloc] init];
        self.yishenheArry = [NSMutableArray arrayWithCapacity:0];
        self.weishenheArry = [NSMutableArray arrayWithCapacity:0];
        self.quanbuArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.weishenheBT addTarget:self action:@selector(weishenheBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.yishenheBT addTarget:self action:@selector(yishenheBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.quanbuBT addTarget:self action:@selector(quanBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.shaixuanBT addTarget:self action:@selector(shaixuanBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.manager appGetProductStockSrl:self.selType finishBlock:^(RKSPModeListList *llist) {
        [self.weishenheArry addObjectsFromArray:llist.rksModeArryArry];
        [self.tableview reloadData];
    }];
}

#pragma mark 顶部按钮点击事件
- (void)weishenheBTItem
{
    self.selType = 1;//未审核
    if(self.weishenheArry.count == 0)
    {
        [self.manager appGetProductStockSrl:self.selType finishBlock:^(RKSPModeListList *llist) {
            [self.weishenheArry addObjectsFromArray:llist.rksModeArryArry];
            [self.tableview reloadData];
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)yishenheBTItem
{
    self.selType = 2;//已审核
    if(self.yishenheArry.count == 0)
    {
        [self.manager appGetProductStockSrl:self.selType finishBlock:^(RKSPModeListList *llist) {
            [self.yishenheArry addObjectsFromArray:llist.rksModeArryArry];
            [self.tableview reloadData];
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)quanBTItem
{
    self.selType = -1;//全部
    if(self.quanbuArry.count == 0)
    {
        [self.manager appGetProductStockSrl:self.selType finishBlock:^(RKSPModeListList *llist) {
            [self.quanbuArry addObjectsFromArray:llist.rksModeArryArry];
            [self.tableview reloadData];
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)shaixuanBTItem
{
    [self pushXIBName:@"SXViewController" animated:YES selector:@"setRKSPManager:" param:self.manager,nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    if(self.selType == 1)
    {
        count = self.weishenheArry.count;
    }
    else if(self.selType == 2)
    {
        count = self.yishenheArry.count;
    }
    else if(self.selType == -1)
    {
        count = self.quanbuArry.count;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if(self.selType == 1)
    {
        RKSPModeList *list = [self.weishenheArry objectAtIndex:section];
        count = list.rksModeArry.count;
    }
    else if(self.selType == 2)
    {
        RKSPModeList *list = [self.yishenheArry objectAtIndex:section];
        count = list.rksModeArry.count;
    }
    else if(self.selType == -1)
    {
        RKSPModeList *list = [self.quanbuArry objectAtIndex:section];
        count = list.rksModeArry.count;
    }
    return count;;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeadview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    sectionHeadview.backgroundColor = RGBCOLOR(229, 229, 229);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/2+50, 25)];
    NSString *time = nil;
    label.textColor = [UIColor blackColor];
    label.font = kFont12;
    if(self.selType == 1)
    {
        if(section < self.weishenheArry.count)
        {
            RKSPModeList *list = [self.weishenheArry objectAtIndex:section];
            time = list.strOrderTime;
        }
    }
    else if(self.selType == 2)
    {
        if(section < self.yishenheArry.count)
        {
            RKSPModeList *list = [self.yishenheArry objectAtIndex:section];
            time = list.strOrderTime;
        }
    }
    else if(self.selType == -1)
    {
        if(section < self.quanbuArry.count)
        {
            RKSPModeList *list = [self.quanbuArry objectAtIndex:section];
            time = list.strOrderTime;
        }
    }

    label.text =  [NSString stringWithFormat:@"   时间：%@",time];
    label.backgroundColor = [UIColor clearColor];
    [sectionHeadview addSubview:label];
    
    UILabel *labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-120, 0, kMainScreenWidth/2, 25)];
    NSString *status = nil;
    labelStatus.textColor = [UIColor blackColor];
    labelStatus.font = kFont12;
    if(self.selType == 1)
    {
        if(section < self.weishenheArry.count)
        {
            RKSPModeList *list = [self.weishenheArry objectAtIndex:section];
            time = list.strStatusDesc;
        }
    }
    else if(self.selType == 2)
    {
        if(section < self.yishenheArry.count)
        {
            RKSPModeList *list = [self.yishenheArry objectAtIndex:section];
            status = list.strStatusDesc;
        }
    }
    else if(self.selType == -1)
    {
        if(section < self.quanbuArry.count)
        {
            RKSPModeList *list = [self.quanbuArry objectAtIndex:section];
            status = list.strStatusDesc;
        }
    }
    
    labelStatus.text =  [NSString stringWithFormat:@"状态：%@",time];
    labelStatus.backgroundColor = [UIColor clearColor];
    [sectionHeadview addSubview:labelStatus];
    return sectionHeadview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKSPCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rukushenpincell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RKSPCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(RKSPCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selType == 1)
    {
        if(indexPath.section < self.weishenheArry.count)
        {
            RKSPModeList *list = [self.weishenheArry objectAtIndex:indexPath.section];
            RKSPMode *mode = [list.rksModeArry objectAtIndex:indexPath.row];
            [cell setCellData:mode];
        }
    }
    else if(self.selType == 2)
    {
        if(indexPath.section < self.yishenheArry.count)
        {
            RKSPModeList *list = [self.yishenheArry objectAtIndex:indexPath.section];
            RKSPMode *mode = [list.rksModeArry objectAtIndex:indexPath.row];
            [cell setCellData:mode];
        }
    }
    else if(self.selType == -1)
    {
        if(indexPath.section < self.quanbuArry.count)
        {
            RKSPModeList *list = [self.quanbuArry objectAtIndex:indexPath.section];
            RKSPMode *mode = [list.rksModeArry objectAtIndex:indexPath.row];
            [cell setCellData:mode];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKSPModeList *list = nil;
    if(self.selType == 1)
    {
        if(indexPath.section < self.weishenheArry.count)
        {
            list = [self.weishenheArry objectAtIndex:indexPath.section];
        }
    }
    else if(self.selType == 2)
    {
        if(indexPath.section < self.yishenheArry.count)
        {
            list = [self.yishenheArry objectAtIndex:indexPath.section];
        }
    }
    else if(self.selType == -1)
    {
        if(indexPath.section < self.quanbuArry.count)
        {
            list = [self.quanbuArry objectAtIndex:indexPath.section];
        }
    }
    [self pushXIBName:@"RukuDetailViewController" animated:YES selector:@"setRKSPManager:dateList:" param:self.manager,list,nil];
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
