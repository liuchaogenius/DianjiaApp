//
//  ForgetViewController1.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/25.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#import "ForgetViewController1.h"
#import "JKCountDownButton.h"
#import "NetManager.h"

@interface ForgetViewController1 ()

@property(nonatomic,strong) UITextField *phoneTF;
@property(nonatomic,strong) UITextField *yanTF;
@property(nonatomic,strong) UIButton *okBtn;
@property(nonatomic,strong) JKCountDownButton *countBtn;
@property(nonatomic,copy) NSString *yanStr;
@end

@implementation ForgetViewController1

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
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
    label.text = @"第一步:发送验证短信";
    [topView addSubview:label];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(20, label.bottom+20, kMainScreenWidth-40, 16)];
    _phoneTF.font = kFont12;
    _phoneTF.placeholder = @"请输入已绑定的手机号码";
    [self.view addSubview:_phoneTF];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(_phoneTF.left-5, _phoneTF.bottom+1, _phoneTF.width+6, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView1];
    
    _yanTF = [[UITextField alloc] initWithFrame:CGRectMake(20, lineView1.bottom+20, kMainScreenWidth-40-120, 16)];
    _yanTF.font = kFont12;
    _yanTF.placeholder = @"请输入验证码";
    [self.view addSubview:_yanTF];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(_yanTF.left-5, _yanTF.bottom+1, _yanTF.width+6, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    
    _countBtn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(lineView2.right, _yanTF.top-10, 120, _yanTF.height+12)];
    _countBtn.backgroundColor = KColor;
    _countBtn.titleLabel.font = kFont12;
    [_countBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    __weak ForgetViewController1 *weakSelf = self;
    [_countBtn addToucheHandler:^(JKCountDownButton *sender, NSInteger tag) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:weakSelf.phoneTF.text forKey:@"smsTo"];
        [dict setObject:@0 forKey:@"smsCheckType"];
        [dict setObject:@2 forKey:@"smsType"];
        [NetManager requestWith:dict apiName:@"djSMSSendVerCode" method:@"POST" succ:^(NSDictionary *successDict) {
            NSString *msg = successDict[@"msg"];
            if ([msg isEqualToString:@"success"])
            {
                [weakSelf startBtn:sender];
            }
            else [SVProgressHUD showErrorWithStatus:@"请输入正确号码" cover:YES offsetY:kMainScreenHeight/2.0];
        } failure:^(NSDictionary *failDict, NSError *error) {
            
        }];
    }];
    [self.view addSubview:_countBtn];
    
    _okBtn = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth-100)/2.0, lineView2.bottom+20, 100, 20)];
    [self.view addSubview:_okBtn];
}

- (void)startBtn:(JKCountDownButton *)sender
{
    sender.enabled = NO;
    [sender startWithSecond:119];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"(%d)秒后,重新获取",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
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
