//
//  YDCXViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YDCXViewController.h"
#import "YDCXCell.h"
#import "YDCXManager.h"
#import "DJYDCXRows.h"

static const CGFloat topBtnHeight = 44;

@interface YDCXViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int _currentStatus;
}

@property(nonatomic,strong) UIButton *btnNo;
@property(nonatomic,strong) UIButton *btnYes;
@property(nonatomic,strong) UIButton *btnAll;
@property(nonatomic,strong) UIButton *btnChose;
@property(nonatomic,strong) UITableView *tableviewYudan;
@property(nonatomic,strong) YDCXManager *manage;

@property(nonatomic,strong) NSMutableArray *arrNo;
@property(nonatomic,strong) NSMutableArray *arrYes;
@property(nonatomic,strong) NSMutableArray *arrAll;
@property(nonatomic,strong) NSMutableArray *currentArray;
@end

@implementation YDCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赊账查询";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTopView];
    
    _tableviewYudan = [[UITableView alloc] initWithFrame:CGRectMake(0, topBtnHeight, kMainScreenWidth, kMainScreenHeight-topBtnHeight-64)];
    _tableviewYudan.delegate = self;
    _tableviewYudan.dataSource = self;
    _tableviewYudan.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableviewYudan];
    
    _arrNo = [NSMutableArray arrayWithCapacity:0];
    _arrYes = [NSMutableArray arrayWithCapacity:0];
    _arrAll = [NSMutableArray arrayWithCapacity:0];
    _currentArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.btnNo sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Btn相关
- (void)createTopView
{
    CGFloat btnWidth = kMainScreenWidth/4.0;
    NSArray *btnTitleArr = @[@"未结清",@"已结清",@"全部",@"筛选"];
    for (int i=0; i<4; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth*i, 0, btnWidth, topBtnHeight)];
        btn.tag = 100+i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont12;
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        if (i<3)
        {
            [btn setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        else [btn addTarget:self action:@selector(touchChose) forControlEvents:UIControlEventTouchUpInside];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topBtnHeight-0.5, kMainScreenWidth, 0.5)];
    lineView.backgroundColor = RGBCOLOR(220, 220, 220);
    [self.view addSubview:lineView];
}

- (void)touchBtn:(UIButton *)sender
{
    [self allBtnShowNo];
    [sender setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    if (sender==self.btnAll)
    {
        _currentStatus = VipCerditStatusAll;
        [self chooseBtnWithArr:_arrAll];
    }
    else if(sender==self.btnNo)
    {
        _currentStatus = VipCerditStatusNo;
        [self chooseBtnWithArr:_arrNo];
    }
    else if(sender==self.btnYes)
    {
        _currentStatus = VipCerditStatusYes;
        [self chooseBtnWithArr:_arrYes];
    }
}

- (void)allBtnShowNo
{
    for (int i=0; i<3; i++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        [btn setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    }
}

- (void)chooseBtnWithArr:(NSMutableArray *)aArray
{
    _currentArray = aArray;
    if (aArray.count==0)
    {
        [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
        [self.manage appGetVipCerditListArr:_currentStatus finishBlock:^(NSArray *list) {
            if (list && list.count!=0) [SVProgressHUD dismiss];
            else [SVProgressHUD showErrorWithStatus:@"无数据" cover:YES offsetY:kMainScreenHeight/2.0];
            [aArray addObjectsFromArray:list];
            [_tableviewYudan reloadData];
        }];
    }
    else
    {
        [_tableviewYudan reloadData];
    }
}

#pragma mark 筛选按钮
- (void)touchChose
{
    MLOG(@"%s筛选按钮", __func__);
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YDCXCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"YDCXCell";
    YDCXCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"YDCXCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YDCXCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJYDCXRows *mode;
    if (_currentStatus==VipCerditStatusAll)
    {
        mode = _arrAll[indexPath.row];
    }
    else if (_currentStatus==VipCerditStatusNo)
    {
        mode = _arrNo[indexPath.row];
    }
    else if (_currentStatus==VipCerditStatusYes)
    {
        mode = _arrYes[indexPath.row];
    }
    [cell setCellWithMode:mode];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark getter
- (UIButton *)btnNo
{
    if (!_btnNo)
    {
        _btnNo = (UIButton *)[self.view viewWithTag:100];
    }
    return _btnNo;
}

- (UIButton *)btnYes
{
    if (!_btnYes)
    {
        _btnYes = (UIButton *)[self.view viewWithTag:101];
    }
    return _btnYes;
}

- (UIButton *)btnAll
{
    if (!_btnAll)
    {
        _btnAll = (UIButton *)[self.view viewWithTag:102];
    }
    return _btnAll;
}

- (UIButton *)btnChose
{
    if (!_btnChose)
    {
        _btnChose = (UIButton *)[self.view viewWithTag:103];
    }
    return _btnChose;
}

- (YDCXManager *)manage
{
    if (!_manage)
    {
        _manage = [[YDCXManager alloc] init];
    }
    return _manage;
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
