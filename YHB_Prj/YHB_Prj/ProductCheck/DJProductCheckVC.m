//
//  DJProductCheckVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckVC.h"
#import "DJCheckCartEngine.h"
#import "LoginManager.h"

#define StringValueWithNum(a) [NSString stringWithFormat:@"%ld",(NSInteger)a]

@interface DJProductCheckVC ()

@property (nonatomic, assign) NSInteger calculateNum;
@property (nonatomic, strong) NSDictionary *operationDic;
@property (nonatomic, weak) id<DJCheckCartItemComponent> currentItem;

@end

@implementation DJProductCheckVC

- (void)setCalculateNum:(NSInteger)calculateNum {
    _calculateNum = calculateNum;
    self.checkNumTextField.text = StringValueWithNum(_calculateNum);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculateNum = 0;
    self.numPadTextField.text = StringValueWithNum(self.calculateNum);
    self.operationDic = @{@(DJNumPadTagTypePlus):@"+"};
}

- (IBAction)next:(id)sender {
    if (self.currentItem) {
        [self.currentItem setCheckQuanity:self.calculateNum];
        [DJCheckCartEngine addCheckCartItemComponent:self.currentItem withStoreId:[[LoginManager shareLoginManager] currentSelectStore].strId];
    }
    self.currentItem = [self.dataSoure nextItem];
    if (!self.currentItem) {
        //TODO:dismiss
    }else {
        self.calculateNum = 0;
        [self resetUI];
    }
}


- (IBAction)touchGoToCart:(UIButton *)sender {
    //TODO
}

- (IBAction)touchNum:(UIButton *)sender {
    self.numPadTextField.text = [NSString stringWithFormat:@"%@%ld",self.numPadTextField.text,sender.tag];
    self.calculateNum = [self calculateNumberWithString:self.numPadTextField.text];
}

- (IBAction)touchOperation:(UIButton *)sender {
    [self.operationDic enumerateKeysAndObjectsUsingBlock:^(id key, NSString *str, BOOL *stop) {
        if ([self.numPadTextField.text hasSuffix:str]) {
            return;
        }
    }];
    self.numPadTextField.text = [NSString stringWithFormat:@"%@%@",self.numPadTextField.text,self.operationDic[@(sender.tag)]];
}
- (IBAction)touchDelete:(id)sender {
    NSMutableString *muStr = [NSMutableString stringWithString:self.numPadTextField.text];
    if (muStr.length) {
        [muStr deleteCharactersInRange:NSMakeRange(muStr.length-1, 1)];
    }
    self.numPadTextField.text = muStr;
    self.calculateNum = [self calculateNumberWithString:self.numPadTextField.text];
}

- (NSInteger)calculateNumberWithString: (NSString *)str{
    NSArray *nums = [str componentsSeparatedByString:@"+"];
    __block NSInteger calNum = 0;
    [nums enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        calNum += [str integerValue];
    }];
    return calNum;
}

- (void)resetUI {
    //TODO
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
