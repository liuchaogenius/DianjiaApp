//
//  YPDMViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YPDMViewController.h"
#import "SPGLProductMode.h"
#import "YPDMTableViewCell.h"
#import "NetManager.h"

@interface YPDMViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) SPGLProductMode *productMode;
@property(nonatomic,strong) UITextField *textFieldTop;
@property(nonatomic,strong) UITableView *tvMa;
@property(nonatomic,strong) UIButton *btnSao;
@property(nonatomic,strong) UIButton *btnJia;
@property(nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YPDMViewController

- (instancetype)initWithProductMode:(SPGLProductMode *)aMode
{
    if (self=[super init])
    {
        _productMode = aMode;
    }
    return self;
}

- (void)touchOk
{
    if (_dataArr.count>0)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:_productMode.strId forKey:@"id"];
        NSMutableString *mutableStr = [NSMutableString stringWithCapacity:0];
        for (NSString *str in _dataArr)
        {
            [mutableStr appendString:[NSString stringWithFormat:@"%@,", str]];
        }
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length-1, 1)];
        [dict setObject:mutableStr forKey:@"product_code"];
        [NetManager requestWith:dict apiName:@"updateProductCodeApp" method:@"POST" succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict);
            NSString *msg = successDict[@"msg"];
            if ([msg isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功" cover:YES offsetY:kMainScreenHeight/2.0];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else [SVProgressHUD showErrorWithStatus:@"修改失败" cover:YES offsetY:kMainScreenHeight/2.0];
        } failure:^(NSDictionary *failDict, NSError *error) {
            
        }];
    }
    else [SVProgressHUD showErrorWithStatus:@"条码不能为空" cover:YES offsetY:kMainScreenHeight/2.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一品多码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(touchOk)];
    
    [self createTopView];
    
    _dataArr = [NSMutableArray arrayWithArray:[_productMode.strProductCode componentsSeparatedByString:@","]];
    
    _tvMa = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight-64-50)];
    _tvMa.delegate = self;
    _tvMa.dataSource = self;
    _tvMa.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tvMa];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YPDMTableViewCell heightForCell:_dataArr[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    YPDMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[YPDMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.row = (int)indexPath.row;
    [cell setCellWithString:_dataArr[indexPath.row] andDeleteBlock:^(int aRow) {
        [_dataArr removeObjectAtIndex:aRow];
        [_tvMa reloadData];
    }];
    return cell;
}

- (void)createTopView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, kMainScreenWidth-30, 21)];
    nameLabel.font=kFont12;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = _productMode.strProductName;
    [bgView addSubview:nameLabel];
    
    _textFieldTop = [[UITextField alloc] initWithFrame:CGRectMake(5, bgView.bottom+5, kMainScreenWidth-5-60, 21)];
    _textFieldTop.font = kFont12;
    _textFieldTop.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textFieldTop];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_textFieldTop.left, _textFieldTop.bottom, _textFieldTop.width, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];
    
    _btnSao = [[UIButton alloc] initWithFrame:CGRectMake(_textFieldTop.right, _textFieldTop.top+2, 24, 17)];
    [_btnSao setImage:[UIImage imageNamed:@"icon_2_saoma"] forState:UIControlStateNormal];
    [_btnSao addTarget:self action:@selector(touchSao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSao];
    
    _btnJia = [[UIButton alloc] initWithFrame:CGRectMake(_btnSao.right+7, _textFieldTop.top, 20, 20)];
    [_btnJia setImage:[UIImage imageNamed:@"sp_jia"] forState:UIControlStateNormal];
    [_btnJia addTarget:self action:@selector(touchJia) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnJia];
}

- (void)touchSao
{
    
}

- (void)touchJia
{
    if ([self isNotEmpty:_textFieldTop.text] && [self isAllNum:_textFieldTop.text])
    {
        [self.view endEditing:YES];
        [_dataArr addObject:_textFieldTop.text];
        [_tvMa reloadData];
        _textFieldTop.text = @"";
    }
    else [SVProgressHUD showErrorWithStatus:@"请正确输入条码" cover:YES offsetY:kMainScreenHeight/2.0];
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

- (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
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
