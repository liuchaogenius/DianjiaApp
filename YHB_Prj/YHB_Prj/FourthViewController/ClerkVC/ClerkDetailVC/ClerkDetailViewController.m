//
//  GateDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "ClerkDetailViewController.h"
#import "ChooseBtn.h"
#import "TableViewWithBlock.h"
#import "CLTableViewCell.h"
#import "EmpMode.h"

static const CGFloat cellHeight = 30;

typedef enum : NSUInteger {
    FieldTypeGate,
    FieldTypeWork,
    FieldTypeWorkId,
    FieldTypeMima,
    FieldTypeName,
    FieldTypePhone,
    FieldTypeBirth,
    FieldTypeSex,
    FieldTypeWeChat,
    FieldTypeQQ
} FieldType;

@interface ClerkDetailViewController ()<UIScrollViewDelegate, UITextFieldDelegate>
{
    UIScrollView *_bgScrollView;
    NSArray *_titleArray;
    
    UIView *_sexBgView;
    ChooseBtn *_wBtn;
    ChooseBtn *_mBtn;
    
    TableViewWithBlock *_gateTB;
    UIButton *_gateDownBtn;
    BOOL _gateBool;
    NSArray *_gateArray;
    
    TableViewWithBlock *_workTB;
    UIButton *_workDownBtn;
    BOOL _workBool;
    NSArray *_workArray;
}
//@property(nonatomic,strong) UIButton *gateBtn;
@property(nonatomic,strong) UITextField *gateTextfield;
//@property(nonatomic,strong) UIButton *workBtn;
@property(nonatomic,strong) UITextField *workTextfield;

@property(nonatomic,strong) UITextField *workIdTextfield;
@property(nonatomic,strong) UITextField *mimaTextfield;
@property(nonatomic,strong) UITextField *nameTextfield;
@property(nonatomic,strong) UITextField *phoneTextfield;

//@property(nonatomic,strong) UIButton *birthBtn;
@property(nonatomic,strong) UITextField *birthTextfield;

@property(nonatomic,strong) UITextField *sexTextfield;
@property(nonatomic,strong) UITextField *weChatTextfield;
@property(nonatomic,strong) UITextField *qqTextfield;

@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;

@property(nonatomic) BOOL isEdit;

@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic,strong) EmpMode *myMode;
@end

@implementation ClerkDetailViewController

- (instancetype)initWithMode:(EmpMode *)aMode
{
    if (self =[super init])
    {
        _myMode = aMode;
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self closeOtherTable:0];
    [self closeDate];
    return YES;
}

- (void)closeAll
{
    [self closeOtherTable:0];
    [self.view endEditing:YES];
    [self closeDate];
}

- (void)closeDate
{
    if (self.datePicker.superview)
    {
        [self chooseDate:self.datePicker];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.datePicker.bottom += self.datePicker.height;
        [UIView commitAnimations];
        [self performSelector:@selector(removeDatePicker) withObject:nil afterDelay:0.3];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self closeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _gateArray = @[@"22",@"12",@"34"];
    _workArray = @[@"2",@"2",@"4"];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
    
    
    _titleArray = @[@"门店:",@"职务:",@"工号:",@"密码:",@"姓名:",@"手机:",@"生日:",@"性别:",@"微信:",@"QQ:"];
//    NSArray *contentArray = @[_myMode.strstore_name,_myMode.stremp_type_name,_myMode.strsid,_myMode.strpassword,_myMode.stremp_name,_myMode.strphone,_myMode.strbirthday,sex,_myMode.strweixin,_myMode.strqq];
    
    CGFloat endHeight = 0;
    for (int i=0; i<_titleArray.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15+45*i, 16, 16)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"clerk_%d", i]];
        [_bgScrollView addSubview:imgView];
        
        NSString *title = _titleArray[i];
        CGFloat stringWidth = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]].width;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+3, imgView.top, stringWidth, 16)];
        titleLabel.font = kFont12;
        titleLabel.text = title;
        [_bgScrollView addSubview:titleLabel];
        
        CGRect textFrame = CGRectMake(titleLabel.right+5, imgView.top, kMainScreenWidth-titleLabel.right-5-23, 16);
//        if (i!=FieldTypeGate && i!=FieldTypeWork && i!=FieldTypeBirth)
//        {
//            if (i==FieldTypeSex)
//            {
//                _sexBgView = [[UIView alloc] initWithFrame:textFrame];
//                _sexBgView.hidden = YES;
//                [_bgScrollView addSubview:_sexBgView];
//                
//                UILabel *wLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 13, _sexBgView.height)];
//                wLabel.font = kFont12;
//                wLabel.text = @"女";
//                [_sexBgView addSubview:wLabel];
//                _wBtn = [[ChooseBtn alloc] initWithFrame:CGRectMake(wLabel.right+3, 0, _sexBgView.height, _sexBgView.height)];
//                [_wBtn addTarget:self action:@selector(touchWBtn) forControlEvents:UIControlEventTouchDown];
//                [_sexBgView addSubview:_wBtn];
//                
//                UILabel *mLabel = [[UILabel alloc] initWithFrame:CGRectMake(_wBtn.right+15, 0, _sexBgView.height, _sexBgView.height)];
//                mLabel.font = kFont12;
//                mLabel.text = @"男";
//                [_sexBgView addSubview:mLabel];
//                _mBtn = [[ChooseBtn alloc] initWithFrame:CGRectMake(mLabel.right+3, 0, _sexBgView.height, _sexBgView.height)];
//                [_mBtn addTarget:self action:@selector(touchMBtn) forControlEvents:UIControlEventTouchDown];
//                [_sexBgView addSubview:_mBtn];
//                
//            }
            UITextField *textField = [[UITextField alloc] initWithFrame:textFrame];
            textField.font = kFont12;
            textField.tag = 100+i;
            [_bgScrollView addSubview:textField];
            textField.delegate =self;
//            textField.text = contentArray[i];
            if (i==FieldTypePhone || i==FieldTypeQQ || i==FieldTypeWeChat)
            {
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }
//        }
//        else
//        {
//            NSString *title = contentArray[i];
//            CGFloat stringWidth = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]].width+5;
//            if (i==FieldTypeGate)
//            {
//                self.gateBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleLabel.right+5, imgView.top, stringWidth, 16)];
//                [self.gateBtn setTitle:title forState:UIControlStateNormal];
//                self.gateBtn.titleLabel.font = kFont12;
//                [self.gateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                self.gateBtn.tag = 1000;
//                [self.gateBtn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchDown];
//                self.gateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//                self.gateBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
//                [_bgScrollView addSubview:self.gateBtn];
//                
//                _gateDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.gateBtn.right, imgView.top+(16-9)/2.0+2, 15, 9)];
//                [_gateDownBtn setImage:[UIImage imageNamed:@"downArrow2"] forState:UIControlStateNormal];
//                [_bgScrollView addSubview:_gateDownBtn];
//            }
//            else if(i==FieldTypeWork)
//            {
//                self.workBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleLabel.right+5, imgView.top, stringWidth, 16)];
//                [self.workBtn setTitle:title forState:UIControlStateNormal];
//                self.workBtn.titleLabel.font = kFont12;
//                [self.workBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                self.workBtn.tag = 1001;
//                [self.workBtn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchDown];
//                [_bgScrollView addSubview:self.workBtn];
//                
//                _workDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.workBtn.right, imgView.top+(16-9)/2.0+2, 15, 9)];
//                [_workDownBtn setImage:[UIImage imageNamed:@"downArrow2"] forState:UIControlStateNormal];
//                [_bgScrollView addSubview:_workDownBtn];
//            }
//            else if(i==FieldTypeBirth)
//            {
//                self.birthBtn = [[UIButton alloc] initWithFrame:textFrame];
//                [self.birthBtn setTitle:title forState:UIControlStateNormal];
//                self.birthBtn.titleLabel.font = kFont12;
//                [self.birthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [self.birthBtn addTarget:self action:@selector(touchBirth) forControlEvents:UIControlEventTouchDown];
//                self.birthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//                self.birthBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
//                [_bgScrollView addSubview:self.birthBtn];
//            }
//        }
        
        CGRect lineFrame = CGRectMake(titleLabel.right, textFrame.origin.y+textFrame.size.height+2, textFrame.size.width+5, 0.5);
        if (i!=FieldTypeGate && i!=FieldTypeWork && i!=FieldTypeSex)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:lineFrame];
            lineView.backgroundColor = RGBCOLOR(220, 220, 220);
            [_bgScrollView addSubview:lineView];
        }
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(lineFrame.origin.x+lineFrame.size.width+2, imgView.top+3, 6, 10)];
        rightView.image = [UIImage imageNamed:@"rightArrow"];
        rightView.tag = 300+i;
        [_bgScrollView addSubview:rightView];
        
        endHeight = lineFrame.size.height+lineFrame.origin.y;
    }
    
    CGFloat contentH = _bgScrollView.height+1>endHeight+5?_bgScrollView.height+1:endHeight+5;
    _bgScrollView.contentSize = CGSizeMake(kMainScreenWidth, contentH);
    
    
//    UIColor *btnColor = [UIColor orangeColor];
//    for (int i=0; i<2; i++)
//    {
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+kMainScreenWidth/2.0*i, kMainScreenHeight-64-50, kMainScreenWidth/2.0-30, 30)];
//        btn.tag = 200+i;
//        [btn setTitleColor:btnColor forState:UIControlStateNormal];
//        btn.layer.borderColor = [btnColor CGColor];
//        btn.layer.cornerRadius = 3;
//        btn.titleLabel.font = kFont13;
//        btn.layer.borderWidth = 1;
//        [self.view addSubview:btn];
//    }
//    [self.leftBtn setTitle:@"修改" forState:UIControlStateNormal];
//    [self.leftBtn addTarget:self action:@selector(touchLeftBtn) forControlEvents:UIControlEventTouchDown];
//    [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchDown];
    
    
//    _gateTB = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(self.gateBtn.left, self.gateBtn.bottom, self.gateBtn.width+_gateDownBtn.width, 0)];
//    [self initTableWith:_gateTB dataArray:_gateArray btn:self.gateBtn ident:@"gateCell"];
//    [_bgScrollView addSubview:_gateTB];
//    
//    _workTB = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(self.workBtn.left, self.workBtn.bottom, self.workBtn.width+_workDownBtn.width, 0)];
//    [self initTableWith:_workTB dataArray:_workArray btn:self.workBtn ident:@"workCell"];
//    [_bgScrollView addSubview:_workTB];

    self.isEdit = NO;
    _gateBool = NO;
    _workBool = NO;
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //    self.datePicker.minuteInterval = 30;
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:localeDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:+1];
    [adcomps setDay:0];
//    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:localeDate options:0];
//    self.datePicker.minimumDate = localeDate;
//    self.datePicker.maximumDate = newdate;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    
    [self reloadScorllView];
}

- (void)reloadScorllView
{
    //    NSArray *contentArray = @[_myMode.strstore_name,_myMode.stremp_type_name,_myMode.strsid,_myMode.strpassword,_myMode.stremp_name,_myMode.strphone,_myMode.strbirthday,sex,_myMode.strweixin,_myMode.strqq];
    self.gateTextfield.text = _myMode.strstore_name;
    self.workTextfield.text = _myMode.stremp_type_name;
    self.workIdTextfield.text = _myMode.strlogin_name;
    self.mimaTextfield.text = _myMode.strpassword;
    self.nameTextfield.text = _myMode.stremp_name;
    self.phoneTextfield.text = _myMode.strphone;
    self.birthTextfield.text = _myMode.strbirthday;
    NSString *sex = [_myMode.stremp_sex isEqualToString:@"1"]?@"男":@"女";
    self.sexTextfield.text = sex;
    self.weChatTextfield.text = _myMode.strweixin;
    self.qqTextfield.text = _myMode.strqq;
}

- (void)touchLeftBtn
{
    if (self.isEdit==NO)//执行编辑
    {
        [self edit];
    }
    else//执行保存
    {
        [self save];
    }
}

- (void)touchRightBtn
{
    if (self.isEdit==NO)//执行删除
    {
        [self delete];
    }
    else//执行取消
    {
        [self cancel];
    }
}

- (void)edit
{
    self.isEdit = YES;
    [self.leftBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
}

- (void)save
{
    
}

- (void)delete
{
    
}

- (void)cancel
{
    self.isEdit = NO;
    [self.leftBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
}



//- (void)touchArrow:(UIButton *)sender
//{
//    if (sender == _gateDownBtn)
//    {
//        [_gateBtn sendActionsForControlEvents:UIControlEventTouchDown];
//    }
//    else
//    {
//        [_workBtn sendActionsForControlEvents:UIControlEventTouchDown];
//    }
//}

- (void)touchBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self closeOtherTable:sender.tag];
    switch (sender.tag) {
        case 1000:
            [self changeOpenStatus:_gateBool tableView:_gateTB array:_gateArray];
            _gateBool = !_gateBool;
            break;
        case 1001:
            [self changeOpenStatus:_workBool tableView:_workTB array:_workArray];
            _workBool = !_workBool;
            break;
            
        default:
            break;
    }
}

- (void)closeOtherTable:(NSInteger)aTag
{
    for (int i=1000; i<1002; i++)
    {
        if (i!=aTag)
        {
            switch (i)
            {
                case 1000:
                    if (_gateBool)
                    {
                        _gateBool=NO;
                        CGRect frame=_gateTB.frame;
                        frame.size.height=0;
                        [_gateTB setFrame:frame];
                    }
                    break;
                case 1001:
                    if (_workBool)
                    {
                        _workBool=NO;
                        CGRect frame=_workTB.frame;
                        frame.size.height=0;
                        [_workTB setFrame:frame];
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
            CGFloat height = aArray.count*cellHeight>90?aArray.count*cellHeight:90;
            frame.size.height=height;
            [aTB setFrame:frame];
        } completion:^(BOOL finished){
            
        }];
    }
}

- (void)initTableWith:(TableViewWithBlock *)atb dataArray:(NSArray *)aDataArray btn:(UIButton *)aBtn ident:(NSString *)aIdent
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
        [aBtn setTitle:cell.titleLabel.text forState:UIControlStateNormal];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [aBtn sendActionsForControlEvents:UIControlEventTouchDown];
    }];
    [atb.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [atb.layer setBorderWidth:0.5];
}

- (void)touchBirth
{
    //UIDatePicker以及在当前视图上就不用再显示了
    if (self.datePicker.superview == nil)
    {
        //close all keyboard or data picker visible currently
        [self.view endEditing:YES];
        [self closeOtherTable:0];
        
        //此处将Y坐标设在最底下，为了一会动画的展示
        self.datePicker.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 216);
        [self.view addSubview:self.datePicker];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.datePicker.bottom -= self.datePicker.height;
        [UIView commitAnimations];
    }
    
}

- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:selectedDate];
    //    [self.timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.timeBtn setTitle:dateString forState:UIControlStateNormal];
//    [self.birthBtn setTitle:dateString forState:UIControlStateNormal];
    
}

- (void)removeDatePicker
{
    [self.datePicker removeFromSuperview];
}

- (NSString *)changeTime:(NSString *)aTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:aTime];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    
    return timeSp;
}


#pragma mark setter isEdit
- (void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    if (_isEdit==YES)
    {
//        self.gateBtn.enabled = YES;
//        self.workBtn.enabled = YES;
        _gateDownBtn.hidden = NO;
        _workDownBtn.hidden = NO;
        self.sexTextfield.hidden = YES;
        _sexBgView.hidden = NO;
        for (int i=0; i<_titleArray.count; i++)
        {
            UITextField *textfield = (UITextField *)[_bgScrollView viewWithTag:100+i];
            textfield.enabled = YES;
            if (i!=FieldTypeGate && i!=FieldTypeWork && i!=FieldTypeSex)// && i!=FieldTypeBirth)
            {
                UIImageView *imgView = (UIImageView *)[_bgScrollView viewWithTag:300+i];
                imgView.hidden = NO;
            }
        }
    }
    else if(_isEdit==NO)
    {
//        self.gateBtn.enabled = NO;
//        self.workBtn.enabled = NO;
        _gateDownBtn.hidden = YES;
        _workDownBtn.hidden = YES;
        self.sexTextfield.hidden = NO;
        _sexBgView.hidden = YES;
        for (int i=0; i<_titleArray.count; i++)
        {
            UITextField *textfield = (UITextField *)[_bgScrollView viewWithTag:100+i];
            textfield.enabled = NO;
            UIImageView *imgView = (UIImageView *)[_bgScrollView viewWithTag:300+i];
            imgView.hidden = YES;
        }
    }
}

#pragma mark getter
-(UITextField *)gateTextfield
{
    if (!_gateTextfield)
    {
        _gateTextfield = (UITextField *)[_bgScrollView viewWithTag:100];
    }
    return _gateTextfield;
}

-(UITextField *)workTextfield
{
    if (!_workTextfield)
    {
        _workTextfield = (UITextField *)[_bgScrollView viewWithTag:101];
    }
    return _workTextfield;
}

-(UITextField *)workIdTextfield
{
    if (!_workIdTextfield)
    {
        _workIdTextfield = (UITextField *)[_bgScrollView viewWithTag:102];
    }
    return _workIdTextfield;
}

-(UITextField *)mimaTextfield
{
    if (!_mimaTextfield)
    {
        _mimaTextfield = (UITextField *)[_bgScrollView viewWithTag:103];
    }
    return _mimaTextfield;
}

- (UITextField *)nameTextfield
{
    if (!_nameTextfield)
    {
        _nameTextfield = (UITextField *)[_bgScrollView viewWithTag:104];
    }
    return _nameTextfield;
}

- (UITextField *)phoneTextfield
{
    if (!_phoneTextfield)
    {
        _phoneTextfield = (UITextField *)[_bgScrollView viewWithTag:105];
    }
    return _phoneTextfield;
}

- (UITextField *)birthTextfield
{
    if (!_birthTextfield)
    {
        _birthTextfield = (UITextField *)[_bgScrollView viewWithTag:106];
    }
    return _birthTextfield;
}

- (UITextField *)sexTextfield
{
    if (!_sexTextfield)
    {
        _sexTextfield = (UITextField *)[_bgScrollView viewWithTag:107];
    }
    return _sexTextfield;
}

- (UITextField *)weChatTextfield
{
    if (!_weChatTextfield)
    {
        _weChatTextfield = (UITextField *)[_bgScrollView viewWithTag:108];
    }
    return _weChatTextfield;
}

- (UITextField *)qqTextfield
{
    if (!_qqTextfield)
    {
        _qqTextfield = (UITextField *)[_bgScrollView viewWithTag:109];
    }
    return _qqTextfield;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        _leftBtn = (UIButton *)[self.view viewWithTag:200];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = (UIButton *)[self.view viewWithTag:201];
    }
    return _rightBtn;
}

- (void)touchWBtn
{
    self.sexTextfield.text = @"女";
    [_wBtn becomeChoose];
    [_mBtn becomeHidden];
}

- (void)touchMBtn
{
    self.sexTextfield.text = @"男";
    [_wBtn becomeHidden];
    [_mBtn becomeChoose];
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
