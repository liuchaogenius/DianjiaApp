//
//  DJInputCodeViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJInputCodeViewController.h"

@interface DJInputCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation DJInputCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settitleLabel:@"手工输入条码"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.codeTextField resignFirstResponder];
}

- (IBAction)touchComfirm:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.codeTextField resignFirstResponder];
    if (self.sHandler) {
        self.sHandler(self.codeTextField.text);
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
