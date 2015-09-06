//
//  FBViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/6.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "FBViewController.h"

@interface FBViewController ()
@property(nonatomic,strong) UITextView *textViewFB;
@property(nonatomic,strong) UIButton *btnChoose;
@end

@implementation FBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelText;
    kCreateLabel(labelText, CGRectMake(15, 15, kMainScreenWidth-30, 21), 12, [UIColor blackColor], @"请留下您的宝贵意见:");
    [self.view addSubview:labelText];
    
    _textViewFB = [[UITextView alloc] initWithFrame:CGRectMake(15, labelText.bottom+5, kMainScreenWidth-30, 140)];
    _textViewFB.layer.borderWidth=0.5;
    _textViewFB.layer.cornerRadius=3;
    [self.view addSubview:_textViewFB];
    
    CGFloat btnWidth = 200;
    _btnChoose = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2.0-btnWidth/2.0, _textViewFB.bottom+20, btnWidth, 40)];
    _btnChoose.titleLabel.font = kFont13;
    [_btnChoose setTitle:@"确认发送" forState:UIControlStateNormal];
    _btnChoose.backgroundColor = [UIColor orangeColor];
    _btnChoose.layer.cornerRadius = 3;
    [_btnChoose addTarget:self action:@selector(touchChoose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnChoose];
}

- (void)touchChoose
{
    MLOG(@"%s", __func__);
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
