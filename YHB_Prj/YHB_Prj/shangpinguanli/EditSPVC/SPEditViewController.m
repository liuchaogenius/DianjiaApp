//
//  SPEditViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPEditViewController.h"
#import "SPGLProductMode.h"
#import "SupplierViewController.h"
#import "SupplierMode.h"
#import "SPGLCategoryMode.h"
#import "SPManager.h"
#import "DJScanViewController.h"

typedef NS_ENUM(NSInteger, FieldType) {
    FieldTypetm,
    FieldTypepm,
    FieldTypefl,
    FieldTypekc,
    FieldTypejj,
    FieldTypesj,
    FieldTypedw,
    FieldTypegy,
    FieldTypezk,
    FieldTypejf
};

@interface SPEditViewController ()<UIScrollViewDelegate, UIActionSheetDelegate,DJScanDelegate>
{
    NSString *_cid;
    NSString *_supid;
}

@property(nonatomic,strong) SPGLProductMode *myMode;

@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) NSArray *contentArray;

@property(nonatomic,strong) UITextField *textfieldtm;
@property(nonatomic,strong) UITextField *textfieldpm;
@property(nonatomic,strong) UIButton *btnfl;
@property(nonatomic,strong) UITextField *textfieldkc;
@property(nonatomic,strong) UITextField *textfieldjj;
@property(nonatomic,strong) UITextField *textfieldsj;
@property(nonatomic,strong) UITextField *textfielddw;
@property(nonatomic,strong) UIButton *btngy;
@property(nonatomic,strong) UIButton *btnzk;
@property(nonatomic,strong) UIButton *btnjf;

@property(nonatomic,strong) UIButton *btntm;

@property(nonatomic,strong) UIButton *btnOK;

@property(nonatomic,strong) UIActionSheet *sheetzk;
@property(nonatomic,strong) UIActionSheet *sheetjf;

@property(nonatomic,strong) SPManager *manager;

@property(nonatomic,strong) UITapGestureRecognizer *tapGR;

@property(nonatomic,strong) void(^changeBlock)(void);
@end

@implementation SPEditViewController

- (instancetype)initWithMode:(SPGLProductMode *)aMode changeBlock:(void(^)(void))aChangeBlock
{
    if (self=[super init])
    {
        _myMode = aMode;
        if (aMode.strCid) _cid = aMode.strCid;
        if (aMode.strSupid) _supid = aMode.strSupid;
        _changeBlock = aChangeBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改商品";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    
    _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView)];
    [_bgScrollView addGestureRecognizer:_tapGR];
    
    CGFloat btnWidth = 200;
    _btnOK = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2.0-btnWidth/2.0, kMainScreenHeight-64-50+10, btnWidth, 30)];
    _btnOK.backgroundColor = KColor;
    [_btnOK setTitle:@"确定" forState:UIControlStateNormal];
    _btnOK.titleLabel.font = kFont12;
    [_btnOK addTarget:self action:@selector(touchOK) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnOK];
    
    [self.btnfl addTarget:self action:@selector(touchfl) forControlEvents:UIControlEventTouchUpInside];
    [self.btngy addTarget:self action:@selector(touchgy) forControlEvents:UIControlEventTouchUpInside];
    [self.btnzk addTarget:self action:@selector(touchzk) forControlEvents:UIControlEventTouchUpInside];
    [self.btnjf addTarget:self action:@selector(touchjf) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createScrollView
{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-50)];
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
    
    _titleArray = @[@"条码:",@"品名:",@"分类:",@"库存:",@"进价:",@"售价:",@"单位:",@"供货商:",@"折扣活动:",@"积分商品:"];
    NSString *isAct = [_myMode.strActEnable intValue]==1?@"参加":@"不参加";
    NSString *isScore = [_myMode.strIsScore intValue]==1?@"是":@"否";
    NSString *supName = _myMode.strSupName?_myMode.strSupName:@"";
    _contentArray = @[_myMode.strProductCode,_myMode.strProductName,_myMode.strClsName,_myMode.strStockQty,_myMode.strBuyingPrice,_myMode.strSalePrice,_myMode.strSaleUnit,supName,isAct,isScore];
    
    CGFloat endHeight = 0;
    for (int i=0; i<_titleArray.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15+45*i, 16, 16)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sp_%d", i]];
        [_bgScrollView addSubview:imgView];
        
        NSString *title = _titleArray[i];
        CGFloat stringWidth = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]].width;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+3, imgView.top, stringWidth, 16)];
        titleLabel.font = kFont12;
        titleLabel.text = title;
        [_bgScrollView addSubview:titleLabel];
        
        CGRect textFrame = CGRectMake(titleLabel.right+5, imgView.top, kMainScreenWidth-titleLabel.right-5-23, 16);
        if (i!=FieldTypefl && i!=FieldTypegy && i!=FieldTypezk && i!= FieldTypejf)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:textFrame];
            textField.font = kFont12;
            textField.tag = 100+i;
            [_bgScrollView addSubview:textField];
            textField.text = _contentArray[i];
            if (i==FieldTypejj || i==FieldTypesj || i==FieldTypetm) textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            if (i==FieldTypekc) textField.enabled = NO;
            if (i==FieldTypekc) textField.textColor = [UIColor lightGrayColor];
        }
        else
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:textFrame];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.contentEdgeInsets = UIEdgeInsetsMake(0,3, 0, 0);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = kFont12;
            [btn setTitle:_contentArray[i] forState:UIControlStateNormal];
            btn.tag = 100+i;
            [_bgScrollView addSubview:btn];
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.right, textFrame.origin.y+textFrame.size.height+2, textFrame.size.width+5, 0.5)];
        if (i==FieldTypetm) lineView.width-=5;
        lineView.backgroundColor = RGBCOLOR(220, 220, 220);
        [_bgScrollView addSubview:lineView];
        
        //        if (i!=FieldTypeDate)
        //        {
        //            UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(lineView.right+2, imgView.top+3, 6, 10)];
        //            rightView.image = [UIImage imageNamed:@"rightArrow"];
        //            rightView.tag = 300+i;
        //            [_bgScrollView addSubview:rightView];
        //        }
        if (i==FieldTypetm)
        {
            _btntm = [[UIButton alloc] initWithFrame:CGRectMake(lineView.right+1, imgView.top+1, 25, 18)];
            [_btntm setImage:[UIImage imageNamed:@"sp_sao"] forState:UIControlStateNormal];
            [_btntm addTarget:self action:@selector(touchtm) forControlEvents:UIControlEventTouchUpInside];
            [_bgScrollView addSubview:_btntm];
        }
        
        endHeight = lineView.bottom;
    }
    
    CGFloat contentH = _bgScrollView.height+1>endHeight+5?_bgScrollView.height+1:endHeight+5;
    _bgScrollView.contentSize = CGSizeMake(kMainScreenWidth, contentH);
}

#pragma mark touchBtn
- (void)touchfl
{
    [self.view endEditing:YES];
    void(^selectBlock)(SPGLCategoryMode *) = ^(SPGLCategoryMode *aMode){
        [self.btnfl setTitle:aMode.strCateName forState:UIControlStateNormal];
        _cid = aMode.strId;
    };
    [self pushXIBName:@"ShangpinguanliVC" animated:YES selector:@"setSelectBlock:" param:selectBlock,nil];
}

- (void)touchgy
{
    [self.view endEditing:YES];
    SupplierViewController *vc = [[SupplierViewController alloc] initWithSelectBlock:^(SupplierMode *mode) {
        [self.btngy setTitle:mode.strSupName forState:UIControlStateNormal];
        _supid = mode.strid;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchzk
{
    [self.view endEditing:YES];
    [self.sheetzk showInView:self.view];
}

- (void)touchjf
{
    [self.view endEditing:YES];
    [self.sheetjf showInView:self.view];
}

- (void)touchtm
{
    [self.view endEditing:YES];
    DJScanViewController *vc=  [[DJScanViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scanController:(UIViewController *)vc didScanedAndTransToMessage:(NSString *)message
{
    MLOG(@"%@",message);
    self.textfieldtm.text = message;
}

- (void)touchView
{
    [self.view endEditing:YES];
}

- (void)touchOK
{
    NSDictionary *dict = [self getDict];
    if (dict)
    {
        [self.manager saveOrUpdateDict:dict finishBlock:^(NSString *resultCode) {
            if ([resultCode isEqualToString:@"1"])
            {
                [SVProgressHUD showSuccessWithStatus:@"修改成功" cover:YES offsetY:kMainScreenHeight/2.0];
                _changeBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }
            else [SVProgressHUD showErrorWithStatus:@"修改失败" cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
}
    

- (NSDictionary *)getDict
{
    if ([self isAllOK])
    {
        _myMode.strProductCode = self.textfieldtm.text;
        _myMode.strProductName = self.textfieldpm.text;
        if (_cid) _myMode.strCid = _cid;
        if (_supid) _myMode.strSupid = _supid;
        _myMode.strClsName = self.btnfl.titleLabel.text;
        _myMode.strBuyingPrice = self.textfieldjj.text;
        _myMode.strSalePrice = self.textfieldsj.text;
        _myMode.strSaleUnit = self.textfielddw.text;
        if (!self.btngy.titleLabel.text) _myMode.strSupName = @"";
        else _myMode.strSupName = self.btngy.titleLabel.text;
        if ([self.btnzk.titleLabel.text isEqualToString:@"参加"]) _myMode.strActEnable = @"1";
        else _myMode.strActEnable = @"0";
        if ([self.btnjf.titleLabel.text isEqualToString:@"是"]) _myMode.strIsScore = @"1";
        else _myMode.strIsScore = @"0";
        
        NSDictionary *dict = [self dictFromMode];
        
        return dict;
    }
    else return nil;
}

- (NSDictionary *)dictFromMode
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@1 forKey:@"operateType"];
    if (_cid)
    {
        [dict setObject:_cid forKey:@"cid"];
        [dict setObject:[_myMode.strClsName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"cls_name"];
    }
    if (_supid)
    {
        [dict setObject:_supid forKey:@"sup_id"];
        [dict setObject:_myMode.strSupName forKey:@"sup_name"];
    }
    [dict setObject:_myMode.strId forKey:@"id"];
    [dict setObject:[_myMode.strProductName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"product_name"];
    [dict setObject:_myMode.strProductCode forKey:@"product_code"];
    [dict setObject:_myMode.strBuyingPrice forKey:@"buying_price"];
    [dict setObject:_myMode.strSalePrice forKey:@"sale_price"];
    [dict setObject:_myMode.strIsScore forKey:@"is_score"];
    [dict setObject:_myMode.strSaleUnit forKey:@"sale_unit"];
    [dict setObject:_myMode.strActEnable forKey:@"act_enabled"];
    return [dict copy];
}

- (BOOL)isAllOK
{
    if (![self isAllNum1:self.textfieldtm.text] || ![self isNotEmpty:self.textfieldpm.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确条码" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
    else if(![self isNotEmpty:self.textfieldpm.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入商品名" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
    else if(![self isPureFloat:self.textfieldjj.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确进价" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
    else if(![self isPureFloat:self.textfieldsj.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确售价" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
    return YES;
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

- (BOOL)isAllNum1:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c) && c!=',') {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==self.sheetzk)
    {
        if (buttonIndex==0) [self.btnzk setTitle:@"参加" forState:UIControlStateNormal];
        else if(buttonIndex==1) [self.btnzk setTitle:@"不参加" forState:UIControlStateNormal];
    }
    else if(actionSheet==self.sheetjf)
    {
        if (buttonIndex==0) [self.btnjf setTitle:@"是" forState:UIControlStateNormal];
        else if(buttonIndex==1) [self.btnjf setTitle:@"否" forState:UIControlStateNormal];
    }
}

#pragma mark getter
- (UITextField *)textfieldtm
{
    if (!_textfieldtm)
    {
        _textfieldtm = (UITextField *)[_bgScrollView viewWithTag:100];
    }
    return _textfieldtm;
}

- (UITextField *)textfieldpm
{
    if (!_textfieldpm)
    {
        _textfieldpm = (UITextField *)[_bgScrollView viewWithTag:101];
    }
    return _textfieldpm;
}

- (UIButton *)btnfl
{
    if (!_btnfl)
    {
        _btnfl = (UIButton *)[_bgScrollView viewWithTag:102];
    }
    return _btnfl;
}

- (UITextField *)textfieldkc
{
    if (!_textfieldkc)
    {
        _textfieldkc = (UITextField *)[_bgScrollView viewWithTag:103];
    }
    return _textfieldkc;
}

- (UITextField *)textfieldjj
{
    if (!_textfieldjj)
    {
        _textfieldjj = (UITextField *)[_bgScrollView viewWithTag:104];
    }
    return _textfieldjj;
}

- (UITextField *)textfieldsj
{
    if (!_textfieldsj)
    {
        _textfieldsj = (UITextField *)[_bgScrollView viewWithTag:105];
    }
    return _textfieldsj;
}

- (UITextField *)textfielddw
{
    if (!_textfielddw)
    {
        _textfielddw = (UITextField *)[_bgScrollView viewWithTag:106];
    }
    return _textfielddw;
}

- (UIButton *)btngy
{
    if (!_btngy)
    {
        _btngy = (UIButton *)[_bgScrollView viewWithTag:107];
    }
    return _btngy;
}

- (UIButton *)btnzk
{
    if (!_btnzk)
    {
        _btnzk = (UIButton *)[_bgScrollView viewWithTag:108];
    }
    return _btnzk;
}

- (UIButton *)btnjf
{
    if (!_btnjf)
    {
        _btnjf = (UIButton *)[_bgScrollView viewWithTag:109];
    }
    return _btnjf;
}

- (UIActionSheet *)sheetzk
{
    if (!_sheetzk)
    {
        _sheetzk  = [[UIActionSheet alloc] initWithTitle:@"是否参加折扣" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"参加", @"不参加", nil];
    }
    return _sheetzk;
}

- (UIActionSheet *)sheetjf
{
    if (!_sheetjf)
    {
        _sheetjf  = [[UIActionSheet alloc] initWithTitle:@"是否是积分商品" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"是", @"否", nil];
    }
    return _sheetjf;
}

- (SPManager *)manager
{
    if (!_manager)
    {
        _manager = [[SPManager alloc] init];
    }
    return _manager;
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
