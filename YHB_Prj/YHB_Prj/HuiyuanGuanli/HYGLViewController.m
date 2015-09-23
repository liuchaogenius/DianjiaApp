//
//  HYGLViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "HYGLViewController.h"
#import "HYGLManager.h"
#import "VipInfoMode.h"
#import "HYCell.h"
#define kLeftViewWidth   0
@interface HYGLViewController ()
{
    //UISearchDisplayController *searchDisplay ;
    int lastPosition;
    BOOL isShowKeyboard;
    BOOL isSearch;
    BOOL isSelectAll;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *quanxuanBT;
@property (strong, nonatomic) IBOutlet UILabel *huiyuanshuliangDesx;
@property (strong, nonatomic) IBOutlet UIButton *sendMsgBT;
@property (strong, nonatomic) IBOutlet UITableView *tableiview;
@property (strong, nonatomic) HYGLManager *manager;
@property (strong, nonatomic) NSMutableArray *filteredListArry;
@property (nonatomic, strong) NSMutableArray *vipInfoArry;
@property (nonatomic, strong) NSMutableArray *noSelectCellArry;
@property (nonatomic, strong) NSMutableArray *selectCellArry;
@property (nonatomic, copy) void(^selectBlock)(NSMutableArray *list);
@end

@implementation HYGLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.manager = [[HYGLManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settitleLabel:@"会员管理"];
    self.filteredListArry = [NSMutableArray arrayWithCapacity:0];
    self.noSelectCellArry = [NSMutableArray arrayWithCapacity:0];
    self.selectCellArry = [NSMutableArray arrayWithCapacity:0];
    self.tableiview.delegate = self;
    self.tableiview.dataSource = self;
    self.searchBar.delegate = self;
    [self.manager appGetAllVip:^(VipInfoList *modeList) {
        if(modeList)
        {
            self.vipInfoArry = modeList.modeList;
            [self.tableiview reloadData];
            self.huiyuanshuliangDesx.text = [NSString stringWithFormat:@"共%d位会员",self.vipInfoArry.count];
        }
    }];
    [self.quanxuanBT addTarget:self action:@selector(selectAllButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [self.sendMsgBT addTarget:self action:@selector(sendMsgBTItem) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark 处理选择按钮
- (void)selectAllButtonItem
{
    isSelectAll = !isSelectAll;
    [self.noSelectCellArry removeAllObjects];
    [self.selectCellArry removeAllObjects];
    if(isSelectAll == YES)
    {
        [self.quanxuanBT setImage:[UIImage imageNamed:@"hyList_icon"] forState:UIControlStateNormal];
    }
    else
    {
        [self.quanxuanBT setImage:[UIImage imageNamed:@"hyList_icon_nor"] forState:UIControlStateNormal];
    }
    [self.tableiview reloadData];
}

#pragma mark keybode notify
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
    [self filterContentForSearchText:self.searchBar.text];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0f;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if(isSearch == YES)
    {
        return self.filteredListArry.count;
    }
    return self.vipInfoArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"huiyuanguanlicell"];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HYCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(HYCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isSearch == YES)
    {
        if(indexPath.row < self.filteredListArry.count)
        {
            VipInfoMode *mode = [self.filteredListArry objectAtIndex:indexPath.row];
            BOOL cellSele = isSelectAll;
            if(isSelectAll == YES && [self.noSelectCellArry containsObject:[self.vipInfoArry objectAtIndex:[self getModeIndex:mode]]])
            {
                cellSele = NO;
            }
            else if(isSelectAll == NO && [self.selectCellArry containsObject:[self.vipInfoArry objectAtIndex:[self getModeIndex:mode]]])
            {
                cellSele = YES;
            }
            [cell setCellData:mode isSelect:cellSele indexpath:[self getModeIndex:mode]];
            [cell addSelectButtonItemCallBack:self action:@selector(cellSelectCallback:)];
        }
    }
    else
    {
        if(indexPath.row < self.vipInfoArry.count)
        {
            VipInfoMode *mode = [self.vipInfoArry objectAtIndex:indexPath.row];
            BOOL cellSele = isSelectAll;
            if(isSelectAll == YES && [self.noSelectCellArry containsObject:[self.vipInfoArry objectAtIndex:indexPath.row]])
            {
                cellSele = NO;
            }
            else if(isSelectAll == NO && [self.selectCellArry containsObject:[self.vipInfoArry objectAtIndex:indexPath.row]])
            {
                cellSele = YES;
            }
            [cell setCellData:mode isSelect:cellSele indexpath:[self getModeIndex:mode]];
            [cell addSelectButtonItemCallBack:self action:@selector(cellSelectCallback:)];
        }
    }
}

#pragma mark 获取当前mode的index
- (int)getModeIndex:(VipInfoMode *)aMode
{
    for(int i =0; i<self.vipInfoArry.count; i++)
    {
        VipInfoMode*md = [self.vipInfoArry objectAtIndex:i];
        if([aMode.strId compare:md.strId] == 0)
        {
            return i;
        }
    }
    return 0;
}

#pragma mark cell select item
- (void)cellSelectCallback:(id)aParam
{
    HYCell *cell = aParam;
    VipInfoMode *mode = [self.vipInfoArry objectAtIndex:cell.cellIndex];
    mode.isSelect = cell.isSelect;
    if(cell.isSelect==NO && isSelectAll == YES)
    {
        if([self.noSelectCellArry containsObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]] == NO)
        {
            [self.noSelectCellArry addObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]];
        }
    }
    else if(isSelectAll == YES)
    {
        if([self.noSelectCellArry containsObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]])
        {
            [self.noSelectCellArry removeObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]];
        }
    }
    
    if(cell.isSelect==YES && isSelectAll == NO)
    {
        if([self.selectCellArry containsObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]] == NO)
        {
            [self.selectCellArry addObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]];
        }
    }
    else if(isSelectAll == NO)
    {
        if([self.selectCellArry containsObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]])
        {
            [self.selectCellArry removeObject:[self.vipInfoArry objectAtIndex:cell.cellIndex]];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VipInfoMode *mode = nil;
    if(isSearch)
    {
        mode = [self.filteredListArry objectAtIndex:indexPath.row];
    }
    else
    {
        mode = [self.vipInfoArry objectAtIndex:indexPath.row];
    }
    if(self.isNOPushDetail == NO)
    {
        [self pushXIBName:@"HYDetailViewController" animated:YES selector:@"setDetailData:" param:mode,nil];
    }
}

#pragma mark scrollview delegate
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
            if(!self.searchBar.resignFirstResponder)
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
}

#pragma mark Content Filtering
/*
 用于搜索并得到搜索结果的方法使用searchText
 */
- (void)filterContentForSearchText:(NSString*)searchText
{
    if(isSearch == NO)
    {
        [self.filteredListArry removeAllObjects];
        [self.tableiview reloadData];
        return;
    }
    [self.filteredListArry removeAllObjects];
    if(self.vipInfoArry)
    {
        for(VipInfoMode *data in self.vipInfoArry)
        {
            if(data)
            {
                NSRange range = [data.strVipName rangeOfString:searchText];
                NSRange rangePhone = [data.strVipPhone rangeOfString:searchText];
                if(range.location != NSNotFound || rangePhone.location != NSNotFound)
                {
                    [_filteredListArry addObject:data];
                }
            }
        }
        if(_filteredListArry.count > 0)
        {
            [self.tableiview reloadData];
        }
    }
}

#pragma mark 获取用户选择会员list
- (void)getUserSelectList:(void(^)(NSMutableArray *selectList))aSelectBlock
{
    self.selectBlock = aSelectBlock;
}

#pragma mark 发送短信
- (void)sendMsgBTItem
{
    if(self.selectCellArry)
    {
        NSMutableArray *telArry = [NSMutableArray arrayWithCapacity:0];
        for(VipInfoMode *mode in self.selectCellArry)
        {
            if(mode.strVipPhone)
            {
                [telArry addObject:mode.strVipPhone];
            }
        }
        [SVProgressHUD showWithStatus:kLoadingText cover:NO offsetY:64];
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"";
            controller.recipients = telArry;
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:^{
                [SVProgressHUD dismiss];
            }];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请选择会员" cover:NO offsetY:64];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    if(self.selectBlock)
    {
        self.selectBlock(self.selectCellArry);
        self.selectBlock = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableiview.delegate = nil;
    self.tableiview.dataSource = nil;
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
