//
//  SPGLSearchVC.m
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPGLSearchVC.h"
#import "SPGLManager.h"
#import "SPGLSearchCell.h"
#import "DJProductCheckViewManager.h"
#import "DJCheckCartItemComponent.h"
#import "WYJHMode.h"
#import "WYJHEditViewController.h"
#import "SPNewViewController.h"

@interface SPGLSearchVC ()<DJProductCheckViewDataSoure,UIAlertViewDelegate>
{
    NSString *cateId;
    int isGetNetdata; //1 分类id，2 条形码
    BOOL isShowKeyboard;
    BOOL isSearch;
    int lastPosition;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  UISearchBar *searchBar;
@property (strong, nonatomic)  UIButton *scanerButton;
@property (strong, nonatomic)  UIButton *backButton;
@property (strong, nonatomic)  SPGLManager *manager;
@property (strong, nonatomic) SPGLProductList *productList;
@property (assign, nonatomic) NSUInteger currentCheckRow;

@property(nonatomic,strong) void(^changeBlock)(WYJHModeList *);
@property(nonatomic,strong) WYJHModeList *WYJHModeList;
@end

@implementation SPGLSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // [self setRightButton:[UIImage imageNamed:@"icon_2_saoma"] title:nil target:self action:@selector(back)];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 20, 200, 44)];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.delegate = self;
    [self.navigationController.view addSubview:self.searchBar];
    __weak typeof(self) weakself = self;
    if(isGetNetdata == 1)
    {
        [self.searchBar resignFirstResponder];
        [self.manager getProductListByClsApp:cateId finishBlock:^(SPGLProductList *aList) {
            if(aList && aList.productList.count > 0)
            {
                weakself.productList = aList;
                [weakself.tableview reloadData];
            }
        }];
    }
    else if(isGetNetdata == 2)
    {
        [[self searchBar] resignFirstResponder];
        [self.manager getProductListByCodeApp:cateId finishBlock:^(SPGLProductList *aList) {
            if(aList && aList.productList.count > 0)
            {
                weakself.productList = aList;
                [weakself.tableview reloadData];
            }else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有该商品，要添加商品吗？" message:@"是否添加？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                alertView.tag = 101;
                [alertView show];
            }
        }];
    }else {
        [self.searchBar becomeFirstResponder];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif{
    isShowKeyboard = YES;
}

- (void) keyboardWasHidden:(NSNotification *) notif{
    isShowKeyboard = NO;
    if(self.searchBar.text && self.searchBar.text.length > 0)
    {
        isSearch = YES;
    }
    else
    {
        isSearch = NO;
    }
}

#pragma mark 设置初始值
- (void)setMnager:(SPGLManager *)aManager
{
    self.manager = aManager;
}
- (void)setMnagerAndid:(SPGLManager *)aManager cateID:(NSString *)aCateId
{
    self.manager = aManager;
    cateId = aCateId;
    isGetNetdata = 1;
}

- (void)setMnagerAndid:(SPGLManager *)aManager cateID:(NSString *)aCateId modeList:(WYJHModeList *)aModeList andChangeBlock:(void(^)(WYJHModeList *))aChangeBlock
{
    self.manager = aManager;
    cateId = aCateId;
    isGetNetdata = 1;
    _WYJHModeList = aModeList;
    _changeBlock = aChangeBlock;
}

- (void)setMnagerAndCode:(SPGLManager *)aManager procode:(NSString *)aProcode
{
    self.manager = aManager;
    cateId = aProcode;
    isGetNetdata = 2;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.productList.productList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPGLSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spglsearchcell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SPGLSearchCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(SPGLSearchCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.productList.productList.count)
    {
        SPGLProductMode *mode = [self.productList.productList objectAtIndex:indexPath.row];
        [cell setCellData:mode];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.searchBar.isFirstResponder) [self.searchBar resignFirstResponder];
    if (self.serchFrom == SearchFromPD) {
        //商品管理
        self.currentCheckRow = indexPath.row - 1; //-1因为调用数据源是需要+1
        [[DJProductCheckViewManager sharedInstance] showCheckViewFromViewController:self withDataSource:self];
        return;
    }
    
    if(indexPath.row < self.productList.productList.count)
    {
        SPGLProductMode *mode = [self.productList.productList objectAtIndex:indexPath.row];
        if (_changeBlock)
        {
            WYJHMode *model = [[WYJHMode alloc] initWithProductMode:mode];
            WYJHEditViewController *vc = [[WYJHEditViewController alloc] initWithMode:model modeList:_WYJHModeList andChangeBlock:^{
                _changeBlock(_WYJHModeList);
            } canNull:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            void(^changeBlock)(void) = ^(){
                [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            };
            [self pushXIBName:@"SPGLProductDetail" animated:YES selector:@"setInitData:mode:changeBlock:" param:self.manager,mode,changeBlock,nil];
        }
    }
    
    
}
#pragma mark search bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    MLOG(@"fsafas");
}

#pragma mark - check Delegate
- (id<DJCheckCartItemComponent>)nextItem {
    if (++self.currentCheckRow < self.productList.productList.count) {
        return [self itemWithProductListModel:self.productList.productList[self.currentCheckRow]];
    }
    return nil;
}

#pragma mark - adapter

- (id<DJCheckCartItemComponent>)itemWithProductListModel: (SPGLProductMode *)mode {
    id<DJCheckCartItemComponent> item = [[DJCheckCartItemComponent alloc] init];
    
    [item setSid:[[LoginManager shareLoginManager] getStoreId]];
    [item setCheckId:[mode strCid]];
    [item setProductId:[mode strId]];
    [item setProductCode:[mode strProductCode]];
    [item setProductName:[mode strProductName]];
//    item setStoreStockId:[mode strst]
    [item setStockQuanity:[[mode strStockQty] integerValue]];
    [item setStayQuanity:[[mode strStayQty] integerValue]];
//    item setCheckQuanity:
    [item setLastCheckTime:[mode strCheckLasttime]];
    [item setCheckState:DJCheckItemStateNotCheck];
    [item setCheckName:[[[LoginManager shareLoginManager] getLoginMode] strUname]];
    
    return item;
}

#pragma mark scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(self.searchBar.isFirstResponder) [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - lastPosition > 25) {
        lastPosition = currentPostion;
        NSLog(@"ScrollUp now");
    }
    else if (lastPosition - currentPostion > 10)
    {
        lastPosition = currentPostion;
        NSLog(@"ScrollDown now");
        //if(textview.hidden == NO)
        {
            //[self hiddenTView];
            if(!self.searchBar.isFirstResponder)
            {
                [self.searchBar resignFirstResponder];
            }
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if(isShowKeyboard == YES)
    {
        lastPosition = scrollView.contentOffset.y;
    }
    else
    {
        lastPosition = scrollView.contentOffset.y;
    }
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.manager getProductListByKeywordApp:searchBar.text finishBlock:^(SPGLProductList *aList) {
        if(aList && aList.productList.count > 0)
        {
            self.productList = aList;
            [self.tableview reloadData];
        }
    }];
}

#pragma mark 返回
- (void)back
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.searchBar.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.searchBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101 && buttonIndex == 1) {
        // add product
        SPNewViewController *vc = [[SPNewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
