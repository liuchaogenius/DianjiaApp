//
//  GateDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SupplierDetailViewController.h"
#import "ChooseLocaViewController.h"
#import "SupplierDetailViewController.h"
#import "SupplierMode.h"
#import "SupplierManage.h"

typedef enum : NSUInteger {
    FieldTypeSupplier,
    FieldTypeContact,
    FieldTypePhone,
    FieldTypeChuan,
    FieldTypeMail,
    FieldTypeLoca,
    FieldTypeBei,
    FieldTypeDate
} FieldType;

@interface SupplierDetailViewController ()<UIScrollViewDelegate, UIAlertViewDelegate>
{
    UIScrollView *_bgScrollView;
    NSArray *_titleArray;
}
@property(nonatomic,strong) UITextField *supplierTextfield;
@property(nonatomic,strong) UITextField *contactTextfield;
@property(nonatomic,strong) UITextField *phoneTextfield;
@property(nonatomic,strong) UITextField *chuanTextfield;
@property(nonatomic,strong) UITextField *mailTextfield;
@property(nonatomic,strong) UIButton *locaBtn;
@property(nonatomic,strong) UITextField *beiTextfield;
@property(nonatomic,strong) UITextField *dateTextfield;

@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;

@property(nonatomic) BOOL isEdit;

@property(nonatomic, strong) SupplierMode *myMode;
@property(nonatomic, strong) SupplierManage *manage;
@property(nonatomic, strong) void(^deleteBlock)(void);
@property(nonatomic, strong) void(^changeBlock)(SupplierMode *aMode);
@end

@implementation SupplierDetailViewController

- (instancetype)initWithSupplierMode:(SupplierMode *)aMode withDeleteBlock:(void (^)(void))aDeleteBlock withChangeBlock:(void (^)(SupplierMode *aMode))aChangeBlock
{
    if (self = [super init])
    {
        _myMode = aMode;
        _deleteBlock = aDeleteBlock;
        _changeBlock = aChangeBlock;
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-50)];
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
    
    _titleArray = @[@"供货商名称:",@"联系人:",@"联系电话:",@"传真:",@"电子邮件:",@"商户地址:",@"备注:",@"添加日期:"];
    
    CGFloat endHeight = 0;
    for (int i=0; i<_titleArray.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15+45*i, 16, 16)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"supp_%d", i]];
        [_bgScrollView addSubview:imgView];
        
        NSString *title = _titleArray[i];
        CGFloat stringWidth = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]].width;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+3, imgView.top, stringWidth, 16)];
        titleLabel.font = kFont12;
        titleLabel.text = title;
        [_bgScrollView addSubview:titleLabel];
        
        CGRect textFrame = CGRectMake(titleLabel.right+5, imgView.top, kMainScreenWidth-titleLabel.right-5-23, 16);
        if (i!=FieldTypeLoca)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:textFrame];
            textField.font = kFont12;
            textField.tag = 100+i;
            [_bgScrollView addSubview:textField];
//            textField.text = contentArray[i];
            if (i==FieldTypePhone || i==FieldTypeChuan || i==FieldTypeMail)
            {
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }
        }
        else
        {
            self.locaBtn = [[UIButton alloc] initWithFrame:textFrame];
            self.locaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.locaBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
            [self.locaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.locaBtn.titleLabel.font = kFont12;
//            [self.locaBtn setTitle:contentArray[i] forState:UIControlStateNormal];
            [self.locaBtn addTarget:self action:@selector(touchLoca) forControlEvents:UIControlEventTouchDown];
            [_bgScrollView addSubview:self.locaBtn];
        }
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.right, textFrame.origin.y+textFrame.size.height+2, textFrame.size.width+5, 0.5)];
        lineView.backgroundColor = RGBCOLOR(220, 220, 220);
        [_bgScrollView addSubview:lineView];
        
        if (i!=FieldTypeDate)
        {
            UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(lineView.right+2, imgView.top+3, 6, 10)];
            rightView.image = [UIImage imageNamed:@"rightArrow"];
            rightView.tag = 300+i;
            [_bgScrollView addSubview:rightView];
        }
        
        endHeight = lineView.bottom;
    }
    
    CGFloat contentH = _bgScrollView.height+1>endHeight+5?_bgScrollView.height+1:endHeight+5;
    _bgScrollView.contentSize = CGSizeMake(kMainScreenWidth, contentH);
    
    
    UIColor *btnColor = [UIColor orangeColor];
    for (int i=0; i<2; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+kMainScreenWidth/2.0*i, kMainScreenHeight-64-50, kMainScreenWidth/2.0-30, 30)];
        btn.tag = 200+i;
        [btn setTitleColor:btnColor forState:UIControlStateNormal];
        btn.layer.borderColor = [btnColor CGColor];
        btn.layer.cornerRadius = 3;
        btn.titleLabel.font = kFont13;
        btn.layer.borderWidth = 1;
        [self.view addSubview:btn];
    }
    [self.leftBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(touchLeftBtn) forControlEvents:UIControlEventTouchDown];
    [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchDown];
    
    self.isEdit = NO;
    [self reloadScrollView];
}

- (void)reloadScrollView
{
    self.supplierTextfield.text = _myMode.strSupName;
    self.contactTextfield.text = _myMode.strContact;
    self.phoneTextfield.text = _myMode.strTel;
    self.chuanTextfield.text = _myMode.strFax;
    self.mailTextfield.text = _myMode.strEmail;
    self.beiTextfield.text = _myMode.strRemark;
    self.dateTextfield.text = @"2015-07-14 14:32:34";
    [self.locaBtn setTitle:_myMode.strAddress forState:UIControlStateNormal];
}

- (void)touchLoca
{
    ChooseLocaViewController *vc = [[ChooseLocaViewController alloc] initWithEditBlock:^(NSString *str) {
        [self.locaBtn setTitle:str forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:vc animated:YES];
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
        [self showdeleteAlertView];
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
    _myMode.strSupName = self.supplierTextfield.text;
    _myMode.strContact = self.contactTextfield.text;
    _myMode.strTel = self.phoneTextfield.text;
    _myMode.strFax = self.chuanTextfield.text;
    _myMode.strEmail = self.mailTextfield.text;
    _myMode.strRemark = self.beiTextfield.text;
    self.dateTextfield.text = @"2015-07-14 14:32:34";
    _myMode.strAddress = self.locaBtn.titleLabel.text;
    [self.manage changeSupplier:_myMode withFinishBlock:^(NSString *aCode) {
        if ([aCode isEqualToString:@"1"])
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功" cover:YES offsetY:kMainScreenHeight/2.0];
            self.isEdit = NO;
            [self.leftBtn setTitle:@"修改" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
            _changeBlock(_myMode);
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"修改失败" cover:YES offsetY:kMainScreenHeight/2.0];
        }
    }];
}

- (void)showdeleteAlertView
{
    UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要删除此供货商吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    deleteAlert.delegate = self;
    [deleteAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self delete];
    }
}

- (void)delete
{
    [self.manage deleteSupplier:_myMode.strid withFinishBlock:^(NSString *aCode) {
        if ([aCode isEqualToString:@"1"])
        {
            [SVProgressHUD showSuccessWithStatus:@"删除成功" cover:YES offsetY:kMainScreenHeight/2.0];
            _deleteBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"删除失败" cover:YES offsetY:kMainScreenHeight/2.0];
        }
    }];
}

- (void)cancel
{
    self.isEdit = NO;
    [self.leftBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self reloadScrollView];
}


#pragma mark setter isEdit
- (void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    if (_isEdit==YES)
    {
        self.locaBtn.enabled = YES;
        for (int i=0; i<_titleArray.count; i++)
        {
            if (i!=FieldTypeDate)
            {
                if (i!=FieldTypeLoca)
                {
                    UITextField *textfield = (UITextField *)[_bgScrollView viewWithTag:100+i];
                    textfield.enabled = YES;
                }
                UIImageView *imgView = (UIImageView *)[_bgScrollView viewWithTag:300+i];
                imgView.hidden = NO;
            }
        }
    }
    else if(_isEdit==NO)
    {
        self.locaBtn.enabled = NO;
        for (int i=0; i<_titleArray.count; i++)
        {
            if (i!=FieldTypeLoca)
            {
                UITextField *textfield = (UITextField *)[_bgScrollView viewWithTag:100+i];
                textfield.enabled = NO;
            }
            UIImageView *imgView = (UIImageView *)[_bgScrollView viewWithTag:300+i];
            imgView.hidden = YES;
        }
    }
}

#pragma mark getter
-(UITextField *)supplierTextfield
{
    if (!_supplierTextfield)
    {
        _supplierTextfield = (UITextField *)[_bgScrollView viewWithTag:100];
    }
    return _supplierTextfield;
}

-(UITextField *)contactTextfield
{
    if (!_contactTextfield)
    {
        _contactTextfield = (UITextField *)[_bgScrollView viewWithTag:101];
    }
    return _contactTextfield;
}

- (UITextField *)phoneTextfield
{
    if (!_phoneTextfield)
    {
        _phoneTextfield = (UITextField *)[_bgScrollView viewWithTag:102];
    }
    return _phoneTextfield;
}

-(UITextField *)chuanTextfield
{
    if (!_chuanTextfield)
    {
        _chuanTextfield = (UITextField *)[_bgScrollView viewWithTag:103];
    }
    return _chuanTextfield;
}

-(UITextField *)mailTextfield
{
    if (!_mailTextfield)
    {
        _mailTextfield = (UITextField *)[_bgScrollView viewWithTag:104];
    }
    return _mailTextfield;
}

-(UITextField *)beiTextfield
{
    if (!_beiTextfield)
    {
        _beiTextfield = (UITextField *)[_bgScrollView viewWithTag:106];
    }
    return _beiTextfield;
}

- (UITextField *)dateTextfield
{
    if (!_dateTextfield)
    {
        _dateTextfield = (UITextField *)[_bgScrollView viewWithTag:107];
    }
    return _dateTextfield;
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

- (SupplierManage *)manage
{
    if (!_manage)
    {
        _manage = [[SupplierManage alloc] init];
    }
    return _manage;
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
