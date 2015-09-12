//
//  XSLSViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "XSLSViewController.h"
#import "XSLSTableViewCell.h"
#import "SPManager.h"
#import "SVPullToRefresh.h"
#import "XSLSMode.h"

@interface XSLSViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *productId;
}
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) XSLSManager *manager;
@property(nonatomic,strong) NSMutableArray *arrData;
@end

@implementation XSLSViewController

- (instancetype)initWithProductId:(NSString *)aId
{
    if (self=[super init]) {
        productId = aId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部门店";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    _arrData = [NSMutableArray arrayWithCapacity:0];
    _manager = [[XSLSManager alloc] init];
    [self addTableViewTrag];
    [_myTableView triggerPullToRefresh];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak XSLSViewController *weakself = self;
    [weakself.myTableView addPullToRefreshWithActionHandler:^{
        [_manager getSaleHisByProductIdApp:productId finishBlock:^(NSArray *resultArr) {
            if (resultArr && resultArr.count>0)
            {
                _arrData = [resultArr mutableCopy];
                [_myTableView reloadData];
            }
            else [SVProgressHUD showErrorWithStatus:@"无数据" cover:YES offsetY:kMainScreenHeight/2.0];
            [weakself.myTableView.pullToRefreshView stopAnimating];
        } isRefresh:YES];
    }];
    
    
    [weakself.myTableView addInfiniteScrollingWithActionHandler:^{
        if (_arrData.count%20==0 && _arrData.count!=0)
        {
            [_manager getSaleHisByProductIdApp:productId finishBlock:^(NSArray *resultArr) {
                if (resultArr && resultArr.count>0)
                {
                    [_arrData addObjectsFromArray:resultArr];
                    [_myTableView reloadData];
                }
                else [SVProgressHUD showErrorWithStatus:@"无数据" cover:YES offsetY:kMainScreenHeight/2.0];
                [weakself.myTableView.infiniteScrollingView stopAnimating];
            } isRefresh:NO];
        }
        else [weakself.myTableView.infiniteScrollingView stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XSLSTableViewCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"XSLSCell";
    XSLSTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"XSLSTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(XSLSTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSLSMode *mode = _arrData[indexPath.row];
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
