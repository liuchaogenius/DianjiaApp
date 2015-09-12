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
#import "DJStoryboadManager.h"
#import "SVProgressHUD.h"

#define StringValueWithNum(a) [NSString stringWithFormat:@"%ld",(NSInteger)a]

@interface DJProductCheckVC ()

@property (nonatomic, assign) NSInteger originNum;
@property (nonatomic, assign) NSInteger calculateNum;
@property (nonatomic, strong) NSDictionary *operationDic;
@property (nonatomic, strong) id<DJCheckCartItemComponent> currentItem;

@end

@implementation DJProductCheckVC

- (void)setCurrentItem:(id<DJCheckCartItemComponent>)currentItem {
    _currentItem = currentItem;
    _originNum = [_currentItem checkQuanity];
    _calculateNum = _originNum;
    //刷新UI
    [self resetUI];
}

- (void)setCalculateNum:(NSInteger)calculateNum {
    _calculateNum = calculateNum;
    self.checkNumTextField.text = StringValueWithNum(_calculateNum);
    [self.currentItem setCheckQuanity:_calculateNum];
    self.stateLabel.text = [self.currentItem checkStateString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculateNum = 0;
    self.numPadTextField.text = StringValueWithNum(self.calculateNum);
    self.operationDic = @{@(DJNumPadTagTypePlus):@"+"};
    
    [self next:nil];
}

- (IBAction)next:(id)sender {
    if ([self.currentItem  checkState] == DJCheckItemStateNotCheck) {
        [SVProgressHUD showErrorWithStatus:@"请输入盘底数量" cover:YES offsetY:0];
        return;
    }
    
    if (self.currentItem && [self.currentItem checkState] != DJCheckItemStateNotCheck) {
        [self.currentItem setCheckQuanity:self.calculateNum];
        [DJCheckCartEngine addCheckCartItemComponent:self.currentItem withStoreId:[[LoginManager shareLoginManager] currentSelectStore].strId];
    }
    self.currentItem = nil;
    if ([self.dataSoure respondsToSelector:@selector(nextItem)]) {
        self.currentItem = [self.dataSoure nextItem];
    }
    if (!self.currentItem) {
        if ([self.delegate respondsToSelector:@selector(didNeedDissmiss:)]) {
            [self.delegate didNeedDissmiss: self];
        }
    }
}

- (void)rollBack {
    [[self currentItem] setCheckQuanity:_originNum];
    if ([self.delegate respondsToSelector:@selector(didNeedDissmiss:)]) {
        [self.delegate didNeedDissmiss: self];
    }
}


- (IBAction)touchGoToCart:(UIButton *)sender {
    if (self.currentItem && [self.currentItem  checkState] != DJCheckItemStateNotCheck) {
        [self.currentItem setCheckQuanity:self.calculateNum];
        [DJCheckCartEngine addCheckCartItemComponent:self.currentItem withStoreId:[[LoginManager shareLoginManager] currentSelectStore].strId];
    }
    self.currentItem = nil;
    
    if ([self.delegate respondsToSelector:@selector(didNeedGoCheckCart:)]) {
        [self.delegate didNeedGoCheckCart: self];
    }
}

- (IBAction)touchNum:(UIButton *)sender {
    if ([self.numPadTextField.text isEqualToString:@"0"]) {
        self.numPadTextField.text = [NSString stringWithFormat:@"%ld",sender.tag];
    }else {
        self.numPadTextField.text = [NSString stringWithFormat:@"%@%ld",self.numPadTextField.text,sender.tag];
    }
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
    self.productNameLabel.text = [self.currentItem productName];
    self.lastCheckTimeLabel.text = [self.currentItem lastCheckTime];
    self.stockQuantityLabel.text = [NSString stringWithFormat:@"%ld",[self.currentItem stockQuanity]];
    self.stayQuantityLabel.text = [NSString stringWithFormat:@"%ld",[self.currentItem stayQuanity]];
    self.stateLabel.text = [self.currentItem checkStateString];
    if ([self.currentItem checkState] != DJCheckItemStateNotCheck) {
        self.checkNumTextField.text = [NSString stringWithFormat:@"%ld",[self.currentItem checkQuanity]];
    }else{
        self.checkNumTextField.text = @"";
    }
    
    self.numPadTextField.text = self.checkNumTextField.text;
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
