//
//  GateDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "TenantViewController.h"
#import "ChooseLocaViewController.h"

typedef enum : NSUInteger {
    FieldTypeTenant,
    FieldTypeName,
    FieldTypeContact,
    FieldTypePhone,
    FieldTypeMail,
    FieldTypeLoca,
    FieldTypeHang,
    FieldTypeDate
} FieldType;

@interface TenantViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_bgScrollView;
    NSArray *_titleArray;
}
@property(nonatomic,strong) UITextField *gateTextfield;
@property(nonatomic,strong) UITextField *contactTextfield;
@property(nonatomic,strong) UITextField *phoneTextfield;
@property(nonatomic,strong) UIButton *locaBtn;
@property(nonatomic,strong) UITextField *dateTextfield;

@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;

@property(nonatomic) BOOL isEdit;
@end

@implementation TenantViewController

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
    
    _titleArray = @[@"商户名称:",@"昵称:",@"联系人:",@"联系电话:",@"电子邮件",@"商户地址:",@"所属行业:",@"注册日期:"];
    NSArray *contentArray = @[@"南京母婴乐嘉店",@"追梦人",@"董枫",@"13311251225",@"323@gmail.com",@"北京市朝阳区团结湖北头条",@"母婴",@"2015-07-14 14:32:34"];
    
    CGFloat endHeight = 0;
    for (int i=0; i<_titleArray.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15+45*i, 16, 16)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tenant_%d", i]];
        [_bgScrollView addSubview:imgView];
        
        NSString *title = _titleArray[i];
        CGFloat stringWidth = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]].width;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+3, imgView.top, stringWidth, 16)];
        titleLabel.font = kFont12;
        titleLabel.text = title;
        [_bgScrollView addSubview:titleLabel];
        
        CGRect textFrame = CGRectMake(titleLabel.right+5, imgView.top-1, kMainScreenWidth-titleLabel.right-5-23, 17);
        if (i!=FieldTypeLoca)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:textFrame];
            textField.font = kFont12;
            textField.tag = 100+i;
            [_bgScrollView addSubview:textField];
            textField.text = contentArray[i];
            if (i==FieldTypePhone || i==FieldTypeMail)
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
            [self.locaBtn setTitle:contentArray[i] forState:UIControlStateNormal];
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
-(UITextField *)gateTextfield
{
    if (!_gateTextfield)
    {
        _gateTextfield = (UITextField *)[_bgScrollView viewWithTag:100];
    }
    return _gateTextfield;
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

- (UITextField *)dateTextfield
{
    if (!_dateTextfield)
    {
        _dateTextfield = (UITextField *)[_bgScrollView viewWithTag:104];
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
