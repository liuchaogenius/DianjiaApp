//
//  ForgetViewController2.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "ForgetViewController2.h"
#import "NetManager.h"

@interface ForgetViewController2 ()

@property(nonatomic,strong) NSDictionary *myDict;
@property(nonatomic,strong) UITextField *tf1;
@property(nonatomic,strong) UITextField *tf2;
@property(nonatomic,strong) UIButton *okBtn;
@end

@implementation ForgetViewController2

- (instancetype)initWithDict:(NSMutableDictionary *)aDict
{
    if (self = [super init])
    {
        _myDict = aDict;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
}

- (void)createView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 20)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, kMainScreenWidth-20, 16)];
    label.font = kFont12;
    label.text = @"第二步:重新设置密码";
    [topView addSubview:label];
    
    NSArray *titleArray = @[@"设置密码:",@"确认密码:"];
    for (int i=0; i<titleArray.count; i++)
    {
        UILabel *labelTop = [[UILabel alloc] initWithFrame:CGRectMake(30, 40+40*i, 55, 18)];
        labelTop.font = kFont12;
        labelTop.text = titleArray[i];
        [self.view addSubview:labelTop];
        
        UITextField *tf= [[UITextField alloc] initWithFrame:CGRectMake(labelTop.right, labelTop.top, kMainScreenWidth-30-labelTop.right, labelTop.height)];
        tf.font = kFont12;
        tf.secureTextEntry = YES;
        tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        tf.tag = 100+i;
        [self.view addSubview:tf];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tf.left, tf.bottom, tf.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineView];
    }
    
    _okBtn = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth-150)/2.0, 140, 150, 30)];
    _okBtn.layer.cornerRadius = 2.5;
    _okBtn.layer.borderColor = [KColor CGColor];
    _okBtn.layer.borderWidth = 1;
    [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
    _okBtn.titleLabel.font = kFont12;
    [_okBtn setTitleColor:KColor forState:UIControlStateNormal];
    [_okBtn addTarget:self action:@selector(touchOk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_okBtn];
}

- (void)touchOk
{
    if([self isOK])
    {
        [_myDict setValue:self.tf1.text forKey:@"newPassWord"];
        [NetManager requestWith:_myDict apiName:@"appForgetPassword" method:@"POST" succ:^(NSDictionary *successDict) {
            NSString *msg = successDict[@"msg"];
            if ([msg isEqualToString:@"success"])
            {
                [SVProgressHUD showSuccessWithStatus:@"修改成功" cover:YES offsetY:kMainScreenHeight/2.0];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else [SVProgressHUD showErrorWithStatus:@"修改失败" cover:YES offsetY:kMainScreenHeight/2.0];
        } failure:^(NSDictionary *failDict, NSError *error) {
            
        }];
    }
}

- (BOOL)isOK
{
    BOOL a=NO;
    if ([self isNotEmpty:self.tf1.text] && [self isNotEmpty:self.tf2.text])
    {
        if ([self.tf1.text isEqualToString:self.tf2.text])
        {
            a=YES;
        }
        else [SVProgressHUD showErrorWithStatus:@"两次密码不一致" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    else [SVProgressHUD showErrorWithStatus:@"密码不能为空" cover:YES offsetY:kMainScreenHeight/2.0];

    return a;
}

- (BOOL)isNotEmpty:(NSString *)str
{
    BOOL aBool;
    if (!str) {
        aBool=false;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            aBool=false;
        } else {
            aBool=true;
        }
    }
    return aBool;
}

#pragma mark getter
- (UITextField *)tf1
{
    if (!_tf1)
    {
        _tf1 = (UITextField *)[self.view viewWithTag:100];
    }
    return _tf1;
}

- (UITextField *)tf2
{
    if (!_tf2)
    {
        _tf2 = (UITextField *)[self.view viewWithTag:101];
    }
    return _tf2;
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
