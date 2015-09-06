//
//  ProblemGoodsViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/6.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ProblemGoodsViewController.h"
#import "ProblemGoodsManager.h"
#import "ProblemGoodsCell.h"
#import "PGRows.h"
#import "SVPullToRefresh.h"

@interface ProblemGoodsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) ProblemGoodsManager *manager;
@property(nonatomic,strong) UITableView *tvGood;
@property(nonatomic,strong) NSMutableArray *arrData;
@end

@implementation ProblemGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题商品";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    
    _arrData = [NSMutableArray arrayWithCapacity:0];
    
    self.manager = [[ProblemGoodsManager alloc] init];
    
    [self addTableViewTrag];
    [_tvGood triggerPullToRefresh];
}

- (void)createView
{
    _tvGood = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _tvGood.delegate = self;
    _tvGood.dataSource = self;
    _tvGood.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tvGood];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak ProblemGoodsViewController *weakself = self;
    [weakself.tvGood addPullToRefreshWithActionHandler:^{
        [self.manager getProblemGoodsListWithFinishBlock:^(NSArray *resultArr) {
            if (resultArr && resultArr.count>0)
            {
                _arrData = [resultArr mutableCopy];
                [_tvGood reloadData];
            }
            else [SVProgressHUD showErrorWithStatus:@"无数据" cover:YES offsetY:kMainScreenHeight/2.0];
            [weakself.tvGood.pullToRefreshView stopAnimating];
        } isRefresh:YES];
    }];
    
    
    [weakself.tvGood addInfiniteScrollingWithActionHandler:^{
        if (_arrData.count%20==0 && _arrData.count!=0)
        {
            [self.manager getProblemGoodsListWithFinishBlock:^(NSArray *resultArr) {
                if (resultArr && resultArr.count>0)
                {
                    [_arrData addObjectsFromArray:resultArr];
                    [_tvGood reloadData];
                }
                else [SVProgressHUD showErrorWithStatus:@"无数据" cover:YES offsetY:kMainScreenHeight/2.0];
                [weakself.tvGood.infiniteScrollingView stopAnimating];
            } isRefresh:NO];
        }
        else [weakself.tvGood.infiniteScrollingView stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ProblemGoodsCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ProblemGoodsCell";
    ProblemGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"ProblemGoodsCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ProblemGoodsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PGRows *mode = _arrData[indexPath.row];
    [cell setCellWithMode:mode];
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
