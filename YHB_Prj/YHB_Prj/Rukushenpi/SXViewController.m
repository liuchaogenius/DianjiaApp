//
//  SXViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SXViewController.h"
#import "DateSelectVC.h"
#import "RKSPManager.h"
#import "NetManager.h"
#import "GysMode.h"

@interface SXViewController ()
{
    __weak SXViewController *weakself;
    NSString *strSupId;
}
@property (nonatomic, strong) NSMutableArray *gysArry;
@property (nonatomic, strong) DateSelectVC *dateVC;
@property (nonatomic, strong) RKSPManager *manager;
@property (nonatomic, strong) GysModeList *modeList;
@property (strong, nonatomic) NSString *strStartTime;
@property (strong, nonatomic) NSString *strEndTime;
@end

@implementation SXViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.gysArry = [NSMutableArray arrayWithCapacity:0];
        weakself = self;
    }
    return self;
}

- (void)setRKSPManager:(RKSPManager *)aManager
{
    self.manager = aManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.dataBt addTarget:self action:@selector(dataBtItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectGYSBT addTarget:self action:@selector(gysBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.okButton addTarget:self action:@selector(okButtonItem) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.hidden = YES;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.modeList = [[GysModeList alloc] init];
    [self appGetAllSupplier];
}

#pragma mark 获取供应商数据
- (void)appGetAllSupplier
{
    [NetManager requestWith:nil apiName:@"appGetAllSupplier" method:@"POST" succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        if(successDict && [successDict objectForKey:@"result"])
        {
            [self.modeList unPacketData:[successDict objectForKey:@"result"]];
            [self.tableview reloadData];
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

#pragma mark Head 部分 日期按钮的事件及页面操作回调
- (void)dataBtItem:(UIButton *)abt
{
    self.dateVC = (DateSelectVC *)[self pushXIBName:@"DateSelectVC" animated:YES selector:nil param:nil];
    [self obserDateVCValue];
}

- (void)obserDateVCValue
{
    [self.dateVC getUserSetTimer:^(NSString *sTimer, NSString *eTimer,NSString *ssTimer,NSString *seTimer,int tag) {
        if(tag>=0)
        {
            weakself.dataLabel.text = seTimer;
            sTimer = [NSString stringWithFormat:@"%d",tag];
        }
        else
        {
            weakself.dataLabel.text = [NSString stringWithFormat:@"%@--%@",ssTimer,seTimer];
        }
        weakself.strStartTime = sTimer;
        weakself.strEndTime = eTimer;
    }];
}
#pragma mark OK 按钮事件
- (void)okButtonItem
{
    [self.manager setStartTime:self.strStartTime];
    [self.manager setEndTime:self.strEndTime];
    [self.manager setSupIdTime:strSupId];
}

#pragma mark 处理供应商按钮
- (void)gysBTItem
{
    self.tableview.hidden = !self.tableview.hidden;
    if(self.tableview.hidden == NO)
    {
        [self.tableview reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeList.modeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sxgyscell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sxgyscell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    GysMode *mode = [self.modeList.modeList objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = mode.strSupName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GysMode *mode = [self.modeList.modeList objectAtIndex:indexPath.row];
    self.gongyingshangLabel.text = mode.strSupName;
    strSupId = mode.strId;
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
