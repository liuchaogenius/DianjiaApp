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
@property(nonatomic,strong) void(^ myBlock)(NSArray *);
@property(nonatomic,strong) NSArray *dataArr;
@end

@implementation SPKCViewController

- (instancetype)initWithBlock:(void (^)(NSArray *))aBlock
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
    _tvkc.tableFooterView = [UIView new];
//    _tvkc.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tvkc];
    
    _dataArr = [[LoginManager shareLoginManager] getStoreList];
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (void)touchOk
{
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    int j=0;
    for (int i=0; i<_dataArr.count; i++)
    {
        SPKCTableViewCell *cell = (SPKCTableViewCell *)[_tvkc cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.countTf.text && [self isPureFloat:cell.countTf.text])
        {
            j++;
            StoreMode *mode = _dataArr[i];
            NSString *strid = mode.strId;
            NSString *count = cell.countTf.text;
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:strid,@"sid",count,@"stockQty", nil];
            [resultArr addObject:dict];
        }
        else break;
    }
    if (j==_dataArr.count)
    {
        _myBlock(resultArr);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else [SVProgressHUD showErrorWithStatus:@"输入有误" cover:YES offsetY:kMainScreenHeight/2.0];
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
