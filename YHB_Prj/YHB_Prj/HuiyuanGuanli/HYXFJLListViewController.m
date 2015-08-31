//
//  HYXFJLListViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYXFJLListViewController.h"
#import "HYGLManager.h"
#import "VipInfoMode.h"
#import "HYGLOneMothMode.h"
#import "HYLSXFCell.h"

@interface HYXFJLListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) HYGLManager *manager;
@property (nonatomic, strong) VipInfoMode *mode;
@property (nonatomic, strong) NSMutableArray *modeListArry;
@end

@implementation HYXFJLListViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[HYGLManager alloc] init];
        self.modeListArry = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.modeListArry = [NSMutableArray arrayWithCapacity:0];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.manager getVipSaleOneMonth:self.mode.strId finishBlock:^(HYGLDataModeList *mode) {
        if(mode)
        {
            [self.modeListArry addObjectsFromArray:mode.HYGLDataArry];
            [self.tableview reloadData];
        }
    }];
}

- (void)setDetailData:(id)aMode
{
    self.mode = aMode;

}

#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    
    label.textColor = [UIColor blackColor];
    label.font = kFont14;
    if(section < self.modeListArry.count)
    {
        HYGLOneMothTimeList *timlist = [self.modeListArry objectAtIndex:section];
        NSString *time = timlist.strOrderTime;
        label.text =  [NSString stringWithFormat:@"   消费时间：%@",time];
        label.backgroundColor = [UIColor grayColor];
    }
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modeListArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    HYGLOneMothTimeList *timlist = [self.modeListArry objectAtIndex:section];
    return timlist.oneMothDataArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYLSXFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYLSXFCellcell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HYLSXFCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(HYLSXFCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYGLOneMothTimeList *timlist = [self.modeListArry objectAtIndex:indexPath.section];
    HYGLOneMothMode *mode =  [timlist.oneMothDataArry objectAtIndex:indexPath.row];
    [cell setCellData:mode];
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
