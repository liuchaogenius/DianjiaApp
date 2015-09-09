//
//  ChooseLocaViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ChooseLocaViewController.h"
#import "TableViewWithBlock.h"
#import "CLTableViewCell.h"

#define cellHeight 30

@interface ChooseLocaViewController ()<UITextFieldDelegate>
{
    UITextField *_aTextField;
    UITextField *_bTextField;
    UITextField *_cTextField;
    UITextField *_dTextField;
    UITextField *_detailTF;
    void(^_myBlock)(NSString *);
    TableViewWithBlock *_aTB;
    TableViewWithBlock *_bTB;
    TableViewWithBlock *_cTB;
    UIButton *_aBtn;
    UIButton *_bBtn;
    UIButton *_cBtn;
    NSArray *_aArray;
    NSArray *_bArray;
    NSArray *_cArray;
    BOOL _aBool;
    BOOL _bBool;
    BOOL _cBool;
    
    UIButton *_leftBtn;
    UIButton *_rightBtn;
}
@end

@implementation ChooseLocaViewController

- (instancetype)initWithEditBlock:(void (^)(NSString *))aBlock
{
    if (self=[super init])
    {
        _myBlock = aBlock;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _aArray = @[@"fa",@"fa",@"fa",@"fad",@"hjkda"];
    _bArray = @[@"2",@"fa",@"fa",@"fad",@"hjkda"];
    _cArray = @[@"3",@"fa",@"fa",@"fad",@"hjkda"];
    
    CGFloat endWidth = 15;
    CGFloat endHeight = 0;
    NSArray *titleArray = @[@"省:", @"市:", @"区/县:"];
    for (int i=0; i<3; i++)
    {
        NSString *title = titleArray[i];
        CGSize stringSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]];
        CGFloat stringWidth = stringSize.width;
        UILabel *textLabel;
        kCreateLabel(textLabel, CGRectMake(endWidth, 15, stringWidth, 16), 12, [UIColor blackColor], title);
        [self.view addSubview:textLabel];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(textLabel.right+2, textLabel.top, 50, 16)];
        bgView.layer.cornerRadius = 2;
        bgView.layer.borderWidth = 0.5;
        bgView.tag = 1000+i;
        [self.view addSubview:bgView];
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(3, 0, bgView.width-3-11, 16)];
        tf.delegate = self;
        tf.font = kFont12;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.tag = 100+i;
        [bgView addSubview:tf];
        
        UIButton *imgView = [[UIButton alloc] initWithFrame:CGRectMake(bgView.width-11, bgView.height/2.0-4.5, 9, 9)];
        [imgView setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
        [imgView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        imgView.tag = 300+i;
        [bgView addSubview:imgView];
        
        endWidth = bgView.right+10;
        endHeight = textLabel.bottom;
    }

    
    UILabel *detailLabel;
    NSString *title = @"详细地址:";
    CGSize stringSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]];
    CGFloat stringWidth = stringSize.width;
    kCreateLabel(detailLabel, CGRectMake(15, endHeight+25, stringWidth, 16), 12, [UIColor blackColor], title);
    [self.view addSubview:detailLabel];
    
    _detailTF = [[UITextField alloc] initWithFrame:CGRectMake(detailLabel.right+3, detailLabel.top, kMainScreenWidth-detailLabel.right-20, 16)];
    _detailTF.delegate = self;
    _detailTF.font = kFont12;
    [self.view addSubview:_detailTF];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_detailTF.left, _detailTF.bottom+1, _detailTF.width, 0.8)];
    lineView.backgroundColor = RGBCOLOR(220, 220, 220);
    [self.view addSubview:lineView];
    
    UIColor *btnColor = KColor;
    for (int i=0; i<2; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+kMainScreenWidth/2.0*i, lineView.bottom+35, kMainScreenWidth/2.0-30, 30)];
        btn.tag = 500+i;
        [btn setTitleColor:btnColor forState:UIControlStateNormal];
        btn.layer.borderColor = [btnColor CGColor];
        btn.layer.cornerRadius = 3;
        btn.titleLabel.font = kFont13;
        btn.layer.borderWidth = 1;
        [self.view addSubview:btn];
    }
    
    _leftBtn = (UIButton *)[self.view viewWithTag:500];
    _rightBtn = (UIButton *)[self.view viewWithTag:501];
    
    [_leftBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(touchLeftBtn) forControlEvents:UIControlEventTouchDown];
    [_rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchDown];
    
    _aTextField = (UITextField *)[self.view viewWithTag:100];
    _bTextField = (UITextField *)[self.view viewWithTag:101];
    _cTextField = (UITextField *)[self.view viewWithTag:102];
    _aBtn = (UIButton *)[self.view viewWithTag:300];
    _bBtn = (UIButton *)[self.view viewWithTag:301];
    _cBtn = (UIButton *)[self.view viewWithTag:302];
    _aBool = NO;
    _bBool = NO;
    _cBool = NO;
    
    for (int i=0; i<3; i++)
    {
        UIView *bgView = [self.view viewWithTag:1000+i];
        TableViewWithBlock *tb = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(bgView.left, bgView.bottom, bgView.width, 0)];
        tb.tag = 200+i;
        [self.view addSubview:tb];
    }
    
    _aTB = (TableViewWithBlock *)[self.view viewWithTag:200];
    _bTB = (TableViewWithBlock *)[self.view viewWithTag:201];
    _cTB = (TableViewWithBlock *)[self.view viewWithTag:202];
    
    [self initTableWith:_aTB dataArray:_aArray textField:_aTextField btn:_aBtn ident:@"a"];
    [self initTableWith:_bTB dataArray:_bArray textField:_bTextField btn:_bBtn ident:@"b"];
    [self initTableWith:_cTB dataArray:_cArray textField:_cTextField btn:_cBtn ident:@"c"];
}

- (void)touchLeftBtn
{
    BOOL haveText = [self haveText];
    if (haveText==YES)
    {
        NSString *locaStr = [NSString stringWithFormat:@"%@%@%@%@", _aTextField.text,_bTextField.text,_cTextField.text,_detailTF.text];
        _myBlock(locaStr);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请核对输入信息" cover:YES offsetY:kMainScreenHeight/2.0];
    }
}

- (BOOL)haveText
{
    BOOL detailHaveText;
    kStringIsNotEmpty(detailHaveText, _detailTF.text);
    return detailHaveText;
}

- (void)touchRightBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self closeOtherTable:sender.tag];
    switch (sender.tag) {
        case 300:
            [self changeOpenStatus:_aBool tableView:_aTB array:_aArray];
            _aBool = !_aBool;
            break;
        case 301:
            [self changeOpenStatus:_bBool tableView:_bTB array:_bArray];
            _bBool = !_bBool;
            break;
        case 302:
            [self changeOpenStatus:_cBool tableView:_cTB array:_cArray];
            _cBool = !_cBool;
            break;
            
        default:
            break;
    }
}

- (void)closeOtherTable:(NSInteger)aTag
{
    for (int i=300; i<303; i++)
    {
        if (i!=aTag)
        {
            switch (i)
            {
                case 300:
                    if (_aBool)
                    {
                        _aBool=NO;
                        CGRect frame=_aTB.frame;
                        frame.size.height=0;
                        [_aTB setFrame:frame];
                    }
                    break;
                case 301:
                    if (_bBool)
                    {
                        _bBool=NO;
                        CGRect frame=_bTB.frame;
                        frame.size.height=0;
                        [_bTB setFrame:frame];
                    }
                    break;
                case 302:
                    if (_cBool)
                    {
                        _cBool=NO;
                        CGRect frame=_cTB.frame;
                        frame.size.height=0;
                        [_cTB setFrame:frame];
                    }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)changeOpenStatus:(BOOL)aisOpen tableView:(TableViewWithBlock *)aTB array:(NSArray *)aArray{
    
    if (aisOpen) {
        [UIView animateWithDuration:0.3 animations:^{            
            CGRect frame=aTB.frame;
            
            frame.size.height=0;
            [aTB setFrame:frame];
            
        } completion:^(BOOL finished){
            
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=aTB.frame;
            CGFloat height = aArray.count*cellHeight>150?aArray.count*cellHeight:150;
            frame.size.height=height;
            [aTB setFrame:frame];
        } completion:^(BOOL finished){
            
        }];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 100:
            [_aBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 101:
            [_bBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 102:
            [_cBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
    if (textField!=_detailTF)
    {
        return NO;
    }
    else
    {
        [self closeOtherTable:0];
        return YES;
    }
}

- (void)initTableWith:(TableViewWithBlock *)atb dataArray:(NSArray *)aDataArray textField:(UITextField *)atf btn:(UIButton *)aBtn ident:(NSString *)aIdent
{
    [atb initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section){
        return aDataArray.count;
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        CLTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:aIdent];
        if (!cell) {
            cell= [[CLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aIdent andWidth:atb.width];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        cell.height = 30;
        cell.titleLabel.font = kFont12;
        [cell.titleLabel setText:aDataArray[indexPath.row]];
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        CLTableViewCell *cell=(CLTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        atf.text=cell.titleLabel.text;
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [aBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [atb.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [atb.layer setBorderWidth:0.5];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self closeOtherTable:0];//关闭全部table
    [self.view endEditing:YES];
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
