//
//  DJProductCheckListVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckListVC.h"
#import "DJProductCheckListCell.h"
#import "LoginManager.h"
#import "DJProductCheckManager.h"
#import "DJProductCheckSrlResult.h"
#import "DJProductCheckSrl.h"
#import "SVPullToRefresh.h"
#import "DateSelectVC.h"

#define kPageSize 20

@interface DJProductCheckListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL isShowSLBT;
@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (nonatomic, strong) DJProductCheckSrlResult   *resultModel;
@property (nonatomic, strong) NSMutableArray            *produceCheckSrls;
@property (nonatomic, strong) NSString                  *beginTime;
@property (nonatomic, strong) NSString                  *endTime;

@end

@implementation DJProductCheckListVC

#pragma mark - getter and setter
- (NSMutableArray *)produceCheckSrls {
    if (!_produceCheckSrls) {
        _produceCheckSrls = [NSMutableArray array];
    }
    return _produceCheckSrls;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSelectStoreButton];
    [self settitleLabel:[LoginManager shareLoginManager].currentSelectStore ? [LoginManager shareLoginManager].currentSelectStore.strStoreName : @"全部门店"];
    [self addTableViewTragWithTableView:self.tableView];
    [self getDataWithIsFirst:YES];
    [self setExtraCellLineHidden:self.tableView];
}

- (void)getDataWithIsFirst: (BOOL)isFirst{
    [SVProgressHUD showWithStatus:@"加载中..." cover:YES offsetY:0];
     __weak typeof(self) weakself = self;
    if (isFirst) {
        [self.produceCheckSrls removeAllObjects];
    }
    NSInteger pageNum = isFirst ? 1 : weakself.resultModel.pageNo+1;
    [DJProductCheckManager getProductCheckSrlWithSid:[[LoginManager shareLoginManager] currentSelectStore].strId PageNum:pageNum pageSize:kPageSize beginTime:self.beginTime endTime:self.endTime success:^(DJProductCheckSrlResult *resultModel) {
        [SVProgressHUD dismiss];
        weakself.resultModel = resultModel;
        [weakself.produceCheckSrls addObjectsFromArray:resultModel.rows];
        [weakself.tableView reloadData];
    } fail:^(id msg) {
        [SVProgressHUD dismissWithError:@"加载失败"];
        [weakself.tableView reloadData];
    }];
}


#pragma mark 上拉下拉
- (void)addTableViewTragWithTableView:(UITableView *)tableView
{
    __weak typeof(self) weakself = self;
    __weak UITableView *weakTableView = tableView;
    [tableView addPullToRefreshWithActionHandler:^{
        int16_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakTableView.pullToRefreshView stopAnimating];
            [weakself getDataWithIsFirst:YES];
        });
    }];

    [tableView addInfiniteScrollingWithActionHandler:^{
         if (weakself.resultModel && weakself.resultModel.pageNo <= weakself.resultModel.totalPages) {
             int16_t delayInSeconds = 2.0;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
             dispatch_after(popTime, dispatch_get_main_queue(), ^{
             [weakTableView.infiniteScrollingView stopAnimating];
             [weakself getDataWithIsFirst:NO];
             });
         }else{
             [weakTableView.infiniteScrollingView stopAnimating];
         }
    }];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - tableView dataSource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.produceCheckSrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJProductCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List" forIndexPath:indexPath];
    
    DJProductCheckSrl *srlModel = self.produceCheckSrls[indexPath.row];
    cell.dateLabel.text = srlModel.ckTime;
    cell.peopleNameLabel.text = srlModel.checkName;
    cell.mainTitleLabel.text = srlModel.storeName;
    
    cell.leftTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)srlModel.itemNum];
    cell.middleTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)srlModel.pankui];
    cell.rightTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)srlModel.panying];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - filer with date

- (IBAction)touchDateItem:(id)sender {
    DateSelectVC *vc = [[DateSelectVC alloc] init];
    self.beginTime = nil;
    self.endTime = nil;
    [vc getUserSetTimer:^(NSString *sTimer, NSString *eTimer, NSString *ssTimer, NSString *seTimer, int btid)
    {
        self.beginTime = sTimer;
        self.endTime = eTimer;
        [self getDataWithIsFirst:YES];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark overwrite sel store
- (void)obserStoreviewResult
{
    __weak typeof(self) weakself = self;
    [self.sview didSelectStoreMode:^(StoreMode *aMode) {
        MLOG(@"sview====sview");
        if(aMode)
        {
            [weakself settitleLabel:aMode.strStoreName];
            [weakself.sview removeFromSuperview];
            weakself.sview = nil;
//            [weakself requestHomeData];
            weakself.tableView.contentOffset = CGPointZero;
            [weakself getDataWithIsFirst:YES];
        }
    }];
}

@end
