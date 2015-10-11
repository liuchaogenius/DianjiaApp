//
//  RukuDetailViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RukuDetailViewController.h"
#import "RKSPManager.h"
#import "RKSPMode.h"
#import "RukuDetailCell.h"
#import "UIImageView+WebCache.h"
#import "NetManager.h"

@interface RukuDetailViewController ()
@property (nonatomic, strong) RKSPManager *manager;
@property (nonatomic, strong) RKSPModeList *modeList;
@property (strong, nonatomic) IBOutlet UILabel *dianmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ghsNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headImgview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *shenhetongguoBT;
@property (strong, nonatomic) IBOutlet UIButton *qingchuBT;
@property (copy, nonatomic) void(^finishBlock)(int status);
@end

@implementation RukuDetailViewController

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
     [self settitleLabel:@"审核详情"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.dianmingLabel.text = self.modeList.strStoreName;
    self.timeLabel.text = self.modeList.strOrderTime;
    self.ghsNameLabel.text = self.modeList.strSupName;
    self.jinjiaLabel.text = [NSString stringWithFormat:@"¥%@",self.modeList.strTotalRealPay];
    self.descLabel.text = [NSString stringWithFormat:@"总计%d种商品，共%@件",(int)self.modeList.rksModeArry.count,self.modeList.strStockNum];
    [self.headImgview sd_setImageWithURL:[NSURL URLWithString:self.modeList.strCounterfoilUrl] placeholderImage:[UIImage imageNamed:@"hyList_head_defalut"]];
    if([self.modeList.strStatus intValue] == 2)//状态 1-未审核 2-已审核 0 全部
    {
        [self.shenhetongguoBT setTitle:@"已经审核通过" forState:UIControlStateNormal];
        self.shenhetongguoBT.userInteractionEnabled = NO;
        self.qingchuBT.hidden = YES;
    }
    else
    {
        [self.shenhetongguoBT addTarget:self action:@selector(shtgBTItem) forControlEvents:UIControlEventTouchUpInside];
        [self.qingchuBT addTarget:self action:@selector(clearBTItem) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)setRKSPManager:(RKSPManager *)aManager dateList:(RKSPModeList *)aModeList
{
    self.manager = aManager;
    self.modeList = aModeList;
}

#pragma mark 审核通过和清除按钮事件
- (void)shtgBTItem
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:self.modeList.strId forKey:@"id"];
    [NetManager requestWith:dict apiName:@"appExamineProductStock" method:@"POST" succ:^(NSDictionary *successDict) {
        [self.shenhetongguoBT setTitle:@"已经审核通过" forState:UIControlStateNormal];
        self.shenhetongguoBT.userInteractionEnabled = NO;
        self.finishBlock(type_shenhe_success);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}
- (void)clearBTItem
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:self.modeList.strId forKey:@"id"];
    [NetManager requestWith:dict apiName:@"appDelProductStock" method:@"POST" succ:^(NSDictionary *successDict) {
        self.finishBlock(type_shenhe_clear);
        [self popviewcontroller];
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

- (void)popviewcontroller
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 审核通过和清除的回调
- (void)obserModeDealStatus:(void(^)(int status))aDealBlock
{
    self.finishBlock = aDealBlock;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeList.rksModeArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RukuDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rkshDetailCell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RukuDetailCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(RukuDetailCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKSPMode *mode = [self.modeList.rksModeArry objectAtIndex:indexPath.row];
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
