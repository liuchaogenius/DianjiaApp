//
//  YDCXDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YDCXDetailViewController.h"
#import "YDCXDetailCell.h"
#import "DJYDCXDetailList.h"

@interface YDCXDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) NSArray *arrData;
@property(nonatomic,strong) UITableView *tableViewDetail;
@end

@implementation YDCXDetailViewController

- (instancetype)initWithDataArray:(NSArray *)aDataArray
{
    if (self=[super init])
    {
        _arrData = aDataArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赊单明细";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createHeaderView];
    
    _tableViewDetail = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _tableViewDetail.delegate = self;
    _tableViewDetail.dataSource = self;
    _tableViewDetail.tableHeaderView = _headerView;
    _tableViewDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewDetail.tableFooterView = [UIView new];
    [self.view addSubview:_tableViewDetail];
}

- (void)createHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    _headerView.backgroundColor = RGBCOLOR(220, 220, 220);
    
    DJYDCXDetailList *mode = _arrData[0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (_headerView.height-21)/2.0, kMainScreenWidth-30, 21)];
    titleLabel.font = kFont12;
    titleLabel.text = [NSString stringWithFormat:@"流水单号:%@", mode.srl];
    [_headerView addSubview:titleLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YDCXDetailCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"YDCXDetailCell";
    YDCXDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"YDCXDetailCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YDCXDetailCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJYDCXDetailList *mode = _arrData[indexPath.row];
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
