//
//  DJCheckCartViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJCheckCartViewController.h"
#import "DJProductSearchBar.h"
#import "DJCheckCartEngine.h"
#import "LoginManager.h"
#import "DJCheckCartCell.h"
#import "DJScanViewController.h"
#import "ShangpinguanliVC.h"
#import "DJProductCheckViewManager.h"

#define StringValueWithNum(a) [NSString stringWithFormat:@"%ld",(NSInteger)a]

@interface DJCheckCartViewController ()<UITableViewDataSource,UITableViewDelegate,DJProductCheckViewDataSoure>

@property (weak, nonatomic) IBOutlet DJProductSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) id<DJCheckCartItemComponent> currentCheckItem;

@end

@implementation DJCheckCartViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExtraCellLineHidden:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:DJCheckCartDataChangedNotification object:nil];
    [self registEnigine];
    
    [self.searchBar setNeedShowSearchVCHandler:^{
        //TODO:跳转搜索框
        ShangpinguanliVC *vc = [[ShangpinguanliVC alloc] init];
        vc.isFromProductCheckCart = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } andShowScanVCHandler:^{
        ShangpinguanliVC *vc = [[ShangpinguanliVC alloc] init];
        vc.isFromProductCheckCart = YES;
        vc.isNeedJumpToScan = YES;
        [self.navigationController pushViewController:vc animated:YES];
//        DJScanViewController *vc=  [[DJScanViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [DJCheckCartEngine switchEngineWithStoreId:[[LoginManager shareLoginManager] getStoreId]];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)registEnigine {
    __weak typeof(self) weakself = self;
    [DJCheckCartEngine registActionHandler:^(id model) {
        [SVProgressHUD dismissWithSuccess:@"成功"];
        [weakself refreshUI];
    } forActionTyp:DJCheckCartActionTypeSubmitChecksSuccess];
    
    [DJCheckCartEngine registActionHandler:^(id model) {
        [SVProgressHUD dismissWithError:@"上传盘点失败,请重试"];
        [weakself refreshUI];
    } forActionTyp:DJCheckCartActionTypeSubmitFail];
    
    [DJCheckCartEngine registActionHandler:^(id model) {
        [SVProgressHUD dismissWithError:@"上传盘点失败,请重试"];
        [weakself refreshUI];
    } forActionTyp:DJCheckCartActionTypeSubmitFail];
    
    [DJCheckCartEngine registActionHandler:^(id model) {
        [SVProgressHUD showErrorWithStatus:@"本次盘点期间这些库存发生变化,请重新盘点" cover:YES offsetY:0];
        [weakself refreshUI];
    } forActionTyp:DJCheckCartActionTypeSubmitChecksNeedRechack];
}


- (void)refreshUI{
    [self.tableView reloadData];
    self.numberLabel.text = StringValueWithNum([DJCheckCartEngine chekCartItemComponents].count);
}

#pragma mark - tableview data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DJCheckCartEngine chekCartItemComponents].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DJItemCell";
    DJCheckCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row < [DJCheckCartEngine chekCartItemComponents].count) {
        id<DJCheckCartItemComponent> item = [[DJCheckCartEngine chekCartItemComponents] objectAtIndex:indexPath.row];
        cell.productNameLabel.text = [item productName];
        cell.lastCheckTimeLabel.text = [item lastCheckTime];
        cell.stockQuantityLabel.text = StringValueWithNum([item stockQuanity]);
        cell.checkQuantityLabel.text = StringValueWithNum([item checkQuanity]);
        cell.statyQuantityLabel.text = StringValueWithNum([item stayQuanity]);
        cell.stateLabel.text = [item checkStateString];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < [DJCheckCartEngine chekCartItemComponents].count) {
        id<DJCheckCartItemComponent> item = [DJCheckCartEngine chekCartItemComponents][indexPath.row];
        if (item) {
            self.currentCheckItem = item;
            [[DJProductCheckViewManager sharedInstance] showCheckViewFromViewController:self withDataSource:self];
            return;
        }
    }
    //由于check中数量顺序等会变化，所以不给于连续下一下检索功能
    self.currentCheckItem = nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([DJCheckCartEngine chekCartItemComponents].count > indexPath.row) {
            [DJCheckCartEngine deleteCheckCartItemComponents:[[DJCheckCartEngine chekCartItemComponents] objectAtIndex:indexPath.row]];
            [self refreshUI];
        }
    }
}

#pragma mark - check DataSource
- (id<DJCheckCartItemComponent>)nextItem {
    id<DJCheckCartItemComponent> item = self.currentCheckItem;
    self.currentCheckItem = nil;
    return item;
}

#pragma mark - action
#pragma mark submit
- (IBAction)touchSubmitButton:(UIButton *)sender {
    if ([DJCheckCartEngine chekCartItemComponents].count > 0) {
        [SVProgressHUD showWithStatus:@"上传中..." cover:YES offsetY:0];
        [DJCheckCartEngine submitCheckCartItemComponentsWithStoreId:[[LoginManager shareLoginManager] getStoreId]];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
