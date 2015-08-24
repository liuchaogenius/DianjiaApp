//
//  KCYJViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "KCYJViewController.h"
#import "LoginManager.h"
#import "KCYJMode.h"
#import "KCYJManager.h"

@interface KCYJViewController ()
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIButton *head_kuyjBT;
@property (strong, nonatomic) IBOutlet UIButton *head_zxbjBT;
@property (strong, nonatomic) IBOutlet UIButton *head_zkcBT;
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)KCYJManager *manager;
@end

@implementation KCYJViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[KCYJManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.head_kuyjBT addTarget:self action:@selector(kcyjBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.head_zxbjBT addTarget:self action:@selector(zxyjBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.head_zkcBT addTarget:self action:@selector(zkcBTItem) forControlEvents:UIControlEventTouchUpInside];
    
    [self.manager getStockWarningDetailPageApp:YES storeId:[[LoginManager shareLoginManager] getStoreId]];
}

- (void)createTableview
{

    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, kMainScreenWidth, self.view.height-self.headView.height)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];//[UIColor colorWithHexValue:kMSColorBC5];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    //self.tableview.tableHeaderView = [self createTableviewHeadview];
    [self.view addSubview:self.tableview];
}
#pragma mark 顶部三个按钮事件函数
- (void)kcyjBTItem
{
}
- (void)zxyjBTItem
{
}
- (void)zkcBTItem
{
}

#pragma mark tableview delegate datesource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kcyuviewtableviewcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kcyuviewtableviewcell"];
    }
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
