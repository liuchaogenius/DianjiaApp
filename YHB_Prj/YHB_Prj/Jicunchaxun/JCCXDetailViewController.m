//
//  JCCXDetailViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/30.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "JCCXDetailViewController.h"
#import "JCCXDetailCell.h"
#import "JCCXManager.h"

@interface JCCXDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) JCCXManager *manager;
@property (strong, nonatomic) NSString *stayId;
@property (strong, nonatomic) JCCXDetailModeList *modeList;
@end

@implementation JCCXDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[JCCXManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"寄存详情"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)setStayId:(NSString *)aId
{
    _stayId = aId;
}

- (void)viewWillAppear:(BOOL)animated
{
    WS(weakself);
    [super viewWillAppear:animated];
    [self.manager appGetProductStayDetail:self.stayId finishBlock:^(JCCXDetailModeList *list) {
        weakself.modeList = list;
        [weakself.tableview reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeList.modeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCCXDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jccxDetailCellDque"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JCCXDetailCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(JCCXDetailCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeList.modeList.count)
    {
        JCCXDetailMode *mode = [self.modeList.modeList objectAtIndex:indexPath.row];
        [cell setCellData:mode];
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
