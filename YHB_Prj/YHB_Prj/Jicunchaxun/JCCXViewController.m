//
//  JCCXViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JCCXViewController.h"
#import "JCCXManager.h"
#import "JCCXMode.h"
#import "JCCXCell.h"
#import "JCCXSXViewController.h"

@interface JCCXViewController ()
@property (strong, nonatomic) IBOutlet UIButton *weiquwanBT;
@property (strong, nonatomic) IBOutlet UIButton *yiquwanBT;
@property (strong, nonatomic) IBOutlet UIButton *shaixuanBT;
@property (strong, nonatomic) IBOutlet UITableView *tableiview;
@property (strong, nonatomic) JCCXManager *manager;
@property (strong, nonatomic) JCCXModeList *modeList;
@end

@implementation JCCXViewController
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
    [self settitleLabel:@"存货查询"];
    self.tableiview.dataSource = self;
    self.tableiview.delegate = self;
    [self.manager appGetProductStaySrl:1 finishBlock:^(JCCXModeList *list) {
        if(list)
        {
            self.modeList = list;
            [self.tableiview reloadData];
        }
    }];
    [self.weiquwanBT addTarget:self action:@selector(weiquwanBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.yiquwanBT addTarget:self action:@selector(quwanBTItem) forControlEvents:UIControlEventTouchUpInside];
    [self.shaixuanBT addTarget:self action:@selector(shuaixuanBTItem) forControlEvents:UIControlEventTouchUpInside];
}

- (void)weiquwanBTItem
{
    [self.weiquwanBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    [self.yiquwanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.manager appGetProductStaySrl:1 finishBlock:^(JCCXModeList *list) {
        if(list)
        {
            self.modeList = list;
            [self.tableiview reloadData];
        }
    }];
}
-(void)quwanBTItem
{
    [self.weiquwanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.yiquwanBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
    [self.manager appGetProductStaySrl:2 finishBlock:^(JCCXModeList *list) {
        if(list)
        {
            self.modeList = list;
            [self.tableiview reloadData];
        }
        else
        {
            
        }
    }];
}

#pragma mark 点击筛选按钮
- (void)shuaixuanBTItem
{
//    [self.weiquwanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
//    [self.yiquwanBT setImage:[UIImage imageNamed:@"gy_yuan_nor"] forState:UIControlStateNormal];
//    [self.shaixuanBT setImage:[UIImage imageNamed:@"gy_yuan_sel"] forState:UIControlStateNormal];
    JCCXSXViewController *svc = (JCCXSXViewController *)[self pushXIBName:@"JCCXSXViewController" animated:YES selector:@"setJCCXManager:" param:self.manager,nil];
    [svc setOKButtonFinishBlock:^{
        [self weiquwanBTItem];
    }];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170.0f;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.modeList.modeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCCXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jccxcell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JCCXCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(JCCXCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.modeList.modeList.count)
    {
        JCCXMode *mode = [self.modeList.modeList objectAtIndex:indexPath.row];
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
