//
//  LoginViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"
#import "AppDelegate.h"
#import "ForgetViewController1.h"
#define kUserInputTFTag 0
#define kPassInputTFTag 1
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userInputTF;
@property (strong, nonatomic) IBOutlet UITextField *passInputTF;
@property (strong, nonatomic) IBOutlet UIButton *forgetPassBT;
@property (strong, nonatomic) IBOutlet UIButton *loginBT;
@property (nonatomic, strong) NSString *strUserNick;
@property (nonatomic, strong) NSString *strPasswork;
@property (nonatomic, assign) BOOL islogOut;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userInputTF.leftViewMode = UITextFieldViewModeAlways;
    self.userInputTF.leftView = [self textfieldLeftView:@"login_user_icon"];
    self.userInputTF.tag = kUserInputTFTag;
    self.userInputTF.delegate = self;
    
    self.passInputTF.leftViewMode = UITextFieldViewModeAlways;
    self.passInputTF.leftView = [self textfieldLeftView:@"login_pass_icon"];
    self.passInputTF.tag = kPassInputTFTag;
    self.passInputTF.delegate = self;
    
    [self.loginBT addTarget:self action:@selector(loginBTItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forgetPassBT addTarget:self action:@selector(forgetPassBTItem:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 获取textfiled的leftview
- (UIView *)textfieldLeftView:(NSString *)aIconName{
    UIImage *userIcon = [UIImage imageNamed:aIconName];    UIImageView *userIconImgview = [[UIImageView alloc] initWithImage:userIcon];
    userIconImgview.frame = CGRectMake(5, 0, userIcon.size.width, userIcon.size.height);
    UIView *userLeftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, userIcon.size.width+5, userIcon.size.height)];
    [userLeftview addSubview:userIconImgview];
    return userLeftview;
}

#pragma mark textfiled 回调函数处理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == kUserInputTFTag){
        self.strUserNick = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    else if(textField.tag == kPassInputTFTag)
    {
        self.strPasswork = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 登录按钮点击事件
- (void)loginBTItem:(UIButton *)aBT
{
    LoginManager *login = [LoginManager shareLoginManager];
    [login login_request:@"test" pass:@"1213" retblock:^(BOOL ret) {
        if(ret == YES)
        {
            if(self.islogOut == NO)
            {
                [[AppDelegate shareAppdelegate] changeWindowRootviewcontroller];
            }
            else
            {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
    }];
}

- (void)logOut
{
    LoginManager *login = [LoginManager shareLoginManager];
    [login logout];
    self.islogOut = YES;
}
#pragma mark 忘记密码按钮点击事件
- (void)forgetPassBTItem:(UIButton *)aBT
{
    ForgetViewController1 *vc= [[ForgetViewController1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
