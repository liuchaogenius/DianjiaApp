//
//  WYDHViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYDHViewController.h"
#import "WYJHManager.h"
#import "WYJHListCell.h"
#import "WYJHSXViewcontroller.h"

@interface WYDHViewController ()
{
    
}
@property (nonatomic, strong) WYJHManager *manager;
@property (strong, nonatomic) IBOutlet UIButton *weirukouBT;
@property (strong, nonatomic) IBOutlet UIButton *yirukouBT;
@property (strong, nonatomic) IBOutlet UIButton *quanbuBT;
@property (strong, nonatomic) IBOutlet UIButton *shaixuanBT;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *weishenheArry;
@property (strong,nonatomic) NSMutableArray *yishenheArry;
@property (strong,nonatomic) NSMutableArray *quanbuArry;
@property (strong, nonatomic) WYJHModeRows *modeRows;
@property (assign, nonatomic) int selType;
@end

@implementation WYDHViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[WYJHManager alloc] init];
        self.selType = 1;
        self.weishenheArry = [NSMutableArray arrayWithCapacity:0];
        self.yishenheArry = [NSMutableArray arrayWithCapacity:0];
        self.quanbuArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"我要订货"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.weirukouBT addTarget:self action:@selector(weirukuBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.yirukouBT addTarget:self action:@selector(yirukuBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.quanbuBT addTarget:self action:@selector(quanBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.shaixuanBT addTarget:self action:@selector(shaixuanBtItem) forControlEvents:UIControlEventTouchUpInside];
    [self.manager appGetStorageSrl:self.selType finishBlock:^(WYJHModeRows *llist) {
        if(llist)
        {
            self.modeRows = llist;
            if(llist)
            {
                [self.weishenheArry addObjectsFromArray:llist.modeRowsArry];
                [self.tableview reloadData];
            }
            [self.tableview reloadData];
        }
    }];
    [self.weirukouBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    [self.yirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.quanbuBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
}

- (void)weirukuBTItem
{
    self.selType = 1;//未处理
    [self.weirukouBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    [self.yirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.quanbuBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    if(self.weishenheArry.count == 0)
    {
        [self.manager appGetStorageSrl:self.selType finishBlock:^(WYJHModeRows *llist) {
            if(llist)
            {
                [self.weishenheArry addObjectsFromArray:llist.modeRowsArry];
                [self.tableview reloadData];
            }
            else
            {
                [self.tableview reloadData];
            }
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)yirukuBTItem
{
    self.selType = 2;//未收货
    [self.weirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.yirukouBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    [self.quanbuBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    if(self.yishenheArry.count == 0)
    {
        [self.manager appGetStorageSrl:self.selType finishBlock:^(WYJHModeRows *llist) {
            if(llist)
            {
                [self.yishenheArry addObjectsFromArray:llist.modeRowsArry];
                [self.tableview reloadData];
            }
            else
            {
                [self.tableview reloadData];
            }
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}
- (void)quanBTItem
{
    self.selType = 0;//已收货
    [self.weirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.yirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.quanbuBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    if(self.quanbuArry.count == 0)
    {
        [self.manager appGetStorageSrl:self.selType finishBlock:^(WYJHModeRows *llist) {
            if(llist)
            {
                [self.quanbuArry addObjectsFromArray:llist.modeRowsArry];
                [self.tableview reloadData];
            }
            else
            {
                [self.tableview reloadData];
            }
        }];
    }
    else
    {
        [self.tableview reloadData];
    }
}

#pragma mark 删选BTItem
- (void)shaixuanBtItem
{
    [self.weirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.yirukouBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.quanbuBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_self"] forState:UIControlStateNormal];
    WYJHSXViewcontroller *sxvc = (WYJHSXViewcontroller*)[self pushXIBName:@"WYJHSXViewcontroller" animated:YES selector:@"setRKSPManager:" param:self.manager,nil];
    [sxvc setOKItemFinishCallback:^(BOOL ret) {
        [self.manager clearePageNo];
        [self.weishenheArry removeAllObjects];
        [self.yishenheArry removeAllObjects];
        [self.quanbuArry removeAllObjects];
        [self weirukuBTItem];
    }];
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
    else if(self.selType == 0)
    {
        count = self.quanbuArry.count;
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
            WYJHModeList *list = [self.weishenheArry objectAtIndex:section];
            time = list.strOrderTime;
        }
    }
    else if(self.selType == 2)
    {
        if(section < self.yishenheArry.count)
        {
            WYJHModeList *list = [self.yishenheArry objectAtIndex:section];
            time = list.strOrderTime;
        }
    }
    else if(self.selType == 0)
    {
        if(section < self.quanbuArry.count)
        {
            WYJHModeList *list = [self.quanbuArry objectAtIndex:section];
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
            WYJHModeList *list = [self.weishenheArry objectAtIndex:section];
            if([list.strAccountType intValue] == 1)//未计算
            {
                status = @"未结算";
            }
            else
            {
                status = @"已结算";
            }
        }
    }
    else if(self.selType == 2)
    {
        if(section < self.yishenheArry.count)
        {
            WYJHModeList *list = [self.yishenheArry objectAtIndex:section];
            if([list.strAccountType intValue] == 1)//未计算
            {
                status = @"未结算";
            }
            else
            {
                status = @"已结算";
            }
        }
    }
    else if(self.selType == 0)
    {
        if(section < self.quanbuArry.count)
        {
            WYJHModeList *list = [self.quanbuArry objectAtIndex:section];
            if([list.strAccountType intValue] == 1)//未计算
            {
                status = @"未结算";
            }
            else
            {
                status = @"已结算";
            }
        }
    }
    
    labelStatus.text =  [NSString stringWithFormat:@"状态：%@",status];
    labelStatus.backgroundColor = [UIColor clearColor];
    [sectionHeadview addSubview:labelStatus];
    return sectionHeadview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
//    int count = 0;
//    if(self.selType == 1)
//    {
//        WYJHModeList *list = [self.weishenheArry objectAtIndex:section];
//        count = list.modeListArry.count;
//    }
//    else if(self.selType == 2)
//    {
//        WYJHModeList *list = [self.yishenheArry objectAtIndex:section];
//        count = list.modeListArry.count;
//    }
//    else if(self.selType == 0)
//    {
//        WYJHModeList *list = [self.quanbuArry objectAtIndex:section];
//        count = list.modeListArry.count;
//    }
//    return count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYJHListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wyjhlistcell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WYJHListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(WYJHListCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selType == 1)
    {
        if(indexPath.section < self.weishenheArry.count)
        {
            WYJHModeList *list = [self.weishenheArry objectAtIndex:indexPath.section];
//            WYJHMode *mode = [list.modeListArry objectAtIndex:indexPath.row];
            [cell setCellData:list];
        }
    }
    else if(self.selType == 2)
    {
        if(indexPath.section < self.yishenheArry.count)
        {
            WYJHModeList *list = [self.yishenheArry objectAtIndex:indexPath.section];
//            WYJHMode *mode = [list.modeListArry objectAtIndex:indexPath.row];
            [cell setCellData:list];
        }
    }
    else if(self.selType == 0)
    {
        if(indexPath.section < self.quanbuArry.count)
        {
            WYJHModeList *list = [self.quanbuArry objectAtIndex:indexPath.section];
//            WYJHMode *mode = [list.modeListArry objectAtIndex:indexPath.row];
            [cell setCellData:list];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYJHModeList *list = nil;
    WYJHMode *mode = nil;
    if(self.selType == 1)
    {
        if(indexPath.section < self.weishenheArry.count)
        {
             list = [self.weishenheArry objectAtIndex:indexPath.section];
             mode = [list.modeListArry objectAtIndex:indexPath.row];
        }
    }
    else if(self.selType == 2)
    {
        if(indexPath.section < self.yishenheArry.count)
        {
            list = [self.yishenheArry objectAtIndex:indexPath.section];
            mode = [list.modeListArry objectAtIndex:indexPath.row];
        }
    }
    else if(self.selType == 0)
    {
        if(indexPath.section < self.quanbuArry.count)
        {
            list = [self.quanbuArry objectAtIndex:indexPath.section];
            mode = [list.modeListArry objectAtIndex:indexPath.row];
        }
    }
    [self pushXIBName:@"WYJHDetailVC" animated:YES selector:@"setInitData:mode:modeList:" param:self.manager,mode,list,nil];
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
