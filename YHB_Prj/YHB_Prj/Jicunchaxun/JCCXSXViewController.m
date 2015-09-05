//
//  JCCXSXViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/5.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JCCXSXViewController.h"
#import "JCCXManager.h"
#import "DateSelectVC.h"
#import "HYGLViewController.h"
#import "VipInfoMode.h"
#import "HYCell.h"
#import "YDCXManager.h"
@interface JCCXSXViewController ()
{
     __weak JCCXSXViewController *weakself;
}
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *dateSelectBT;
@property (strong, nonatomic) IBOutlet UILabel *selectHYName;
@property (strong, nonatomic) IBOutlet UIButton *selectHYBT;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) JCCXManager *manager;
@property (nonatomic, strong) NSMutableArray *huyuanArry;
@property (nonatomic, strong) DateSelectVC *dateVC;
@property (strong, nonatomic) NSString *strStartTime;
@property (strong, nonatomic) NSString *strEndTime;
@property (strong, nonatomic) NSString *strVipeId;

@property (strong, nonatomic) YDCXManager *YDCXmanager;
@property (strong, nonatomic) void(^myPopBlock)(void);
@end

@implementation JCCXSXViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.huyuanArry = [NSMutableArray arrayWithCapacity:0];
        weakself = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.dateSelectBT addTarget:self action:@selector(dataBtItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectHYBT addTarget:self action:@selector(pushSelectHuiYuanVC) forControlEvents:UIControlEventTouchUpInside];
    [self.OKButton addTarget:self action:@selector(okButtonItem) forControlEvents:UIControlEventTouchUpInside];
    //self.tableview.hidden = YES;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)setJCCXManager:(JCCXManager *)aManager
{
    self.manager = aManager;
}

- (void)setYDCXManager:(YDCXManager *)aManager andPopBlock:(void(^)(void))aPopBlock
{
    _YDCXmanager = aManager;
    _myPopBlock = aPopBlock;
}
#pragma mark 进入日期页面
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
            weakself.timeLabel.text = seTimer;
            sTimer = [NSString stringWithFormat:@"%d",tag];
        }
        else
        {
            weakself.timeLabel.text = [NSString stringWithFormat:@"%@--%@",ssTimer,seTimer];
        }
        weakself.strStartTime = sTimer;
        weakself.strEndTime = eTimer;
    }];
}
#pragma mark 进入选择会员的页面
- (void)pushSelectHuiYuanVC
{
    HYGLViewController *hvc = [[HYGLViewController alloc] initWithNibName:@"HYGLViewController" bundle:nil];
    hvc.isNOPushDetail = YES;
    [self.navigationController pushViewController:hvc animated:YES];
    [hvc getUserSelectList:^(NSMutableArray *selectList) {
        if(selectList)
        {
            [self.huyuanArry addObjectsFromArray:selectList];
            [self.tableview reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.huyuanArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jcxccellshuaixuan"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HYCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(HYCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.huyuanArry.count)
    {
        VipInfoMode *mode = [self.huyuanArry objectAtIndex:indexPath.row];
        [cell setCellData:mode isSelect:NO indexpath:-1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VipInfoMode *mode = nil;
    if(indexPath.row < self.huyuanArry.count)
    {
        mode = [self.huyuanArry objectAtIndex:indexPath.row];
    }
    self.selectHYName.text = mode.strVipName;
    self.strVipeId = mode.strId;
}

- (void)okButtonItem
{
    if(self.manager)
    {
        if (self.strEndTime&& _strEndTime.length > 0)
        {
            [self.manager setEndTime:_strEndTime];
        }
        if(self.strStartTime &&self.strStartTime.length>0)
        {
            [self.manager setStartTime:self.strStartTime];
        }
        if(self.strVipeId)
        {
            [self.manager setCurrentVipid:_strVipeId];
        }
    }
    if (_YDCXmanager)
    {
        if (self.strEndTime&& _strEndTime.length > 0)
        {
            [_YDCXmanager setEndTime:_strEndTime];
        }
        if(self.strStartTime &&self.strStartTime.length>0)
        {
            [_YDCXmanager setStartTime:self.strStartTime];
        }
        if(self.strVipeId)
        {
            [_YDCXmanager setCurrentVipid:_strVipeId];
        }
    }
    if (_myPopBlock) {
        _myPopBlock();
        [self.navigationController popViewControllerAnimated:YES];
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
