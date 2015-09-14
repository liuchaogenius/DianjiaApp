//
//  SPKCViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPKCViewController.h"
#import "SPKCTableViewCell.h"
#import "LoginManager.h"
#import "LoginMode.h"

@interface SPKCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tvkc;
@property(nonatomic,strong) void(^ myBlock)(int);
@property(nonatomic,strong) NSArray *dataArr;
@end

@implementation SPKCViewController

- (instancetype)initWithBlock:(void (^)(int))aBlock
{
    if (self =[super init])
    {
        _myBlock = aBlock;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [_tvkc endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店库存";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchOk)];
    
    _tvkc = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _tvkc.delegate =self;
    _tvkc.dataSource =self;
//    _tvkc.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tvkc];
    
    _dataArr = [[LoginManager shareLoginManager] getStoreList];
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (void)touchOk
{
    int allCount = 0;
    for (int i=0; i<_dataArr.count; i++)
    {
        SPKCTableViewCell *cell = (SPKCTableViewCell *)[_tvkc cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.countTf.text)
        {
            allCount+=[cell.countTf.text intValue];
        }
    }
    _myBlock(allCount);
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SPKCTableViewCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPKCTableViewCell *cell = [[SPKCTableViewCell alloc] init];
    StoreMode *mode = _dataArr[indexPath.row];
    [cell setCell:mode.strStoreName];
    return cell;
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
