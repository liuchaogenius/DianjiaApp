//
//  SPEditViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "SPNewViewController.h"
#import "SupplierViewController.h"
#import "SupplierMode.h"
#import "SPGLCategoryMode.h"
#import "SPManager.h"
#import "NetManager.h"
#import "SPKCViewController.h"
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

@interface SPNewViewController ()<UIScrollViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,DJScanDelegate>//UITableViewDataSource,UITableViewDelegate>
{
    NSString *_cid;
    NSString *_supid;
    
    int _countNeedToUpload;
    CGFloat _imgWidth;
    CGFloat _interval;
    int _deleteIndex;
    
    BOOL _isHide;
}

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) NSMutableArray *photoArr;

@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) NSArray *contentArray;

@property(nonatomic,strong) UITextField *textfieldtm;
@property(nonatomic,strong) UITextField *textfieldpm;
@property(nonatomic,strong) UIButton *btnfl;
@property(nonatomic,strong) UIButton *btnkc;
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

//@property(nonatomic,strong) UITableView *tvkc;
//@property(nonatomic,strong) UIView *bgkc;
//@property(nonatomic,strong) UIView *maskingView;
@property(nonatomic,strong) SPKCViewController *kcvc;

@property(nonatomic,strong) NSMutableArray *picArray;
@property(nonatomic,strong) NSArray *resultArr;
@end

@implementation SPNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增商品";
    self.view.backgroundColor = [UIColor whiteColor];
    _picArray = [NSMutableArray arrayWithCapacity:0];
    
    _isHide = YES;
    
//    [self createkcView];
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
    [self.btnkc addTarget:self action:@selector(touchkc) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)createkcView
//{
//    _maskingView = [[UIView alloc] initWithFrame:self.view.bounds];
//    _maskingView.backgroundColor = [UIColor blackColor];
//    _maskingView.alpha=0.3;
//    [self.view addSubview:_maskingView];
//    
//    float bgWidth = 300;
//    float bgHeight = 120;
//    _bgkc = [[UIView alloc] initWithFrame:CGRectMake((kMainScreenWidth-bgWidth)/2.0, (kMainScreenHeight-bgHeight)/2.0, bgWidth, bgHeight)];
//    _bgkc.backgroundColor = [UIColor whiteColor];
//    [_maskingView addSubview:_bgkc];
//}

- (void)createScrollView
{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-50)];
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
    
    _titleArray = @[@"条码:",@"品名:",@"分类:",@"库存:",@"进价:",@"售价:",@"单位:",@"供货商:",@"折扣活动:",@"积分商品:"];
    NSString *isAct = @"参加";
    NSString *isScore = @"是";
    NSString *supName = @"";
    _contentArray = @[@"",@"输入商品名称",@"默认分类",@"0",@"￥0.00",@"￥0.00",@"如:400ml/瓶",supName,isAct,isScore];
    
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
        if (i!=FieldTypefl && i!=FieldTypegy && i!=FieldTypezk && i!= FieldTypejf && i!=FieldTypekc)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:textFrame];
            textField.font = kFont12;
            textField.tag = 100+i;
            [_bgScrollView addSubview:textField];
            textField.placeholder = _contentArray[i];
            if (i==FieldTypejj || i==FieldTypesj || i==FieldTypetm) textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        else
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:textFrame];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.contentEdgeInsets = UIEdgeInsetsMake(0,3, 0, 0);
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if (i==FieldTypezk || i==FieldTypejf || i==FieldTypegy) [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    
    _interval = 15;
    _imgWidth = (kMainScreenWidth-_interval*4)/3.0;
    
    _photoArr = [NSMutableArray arrayWithCapacity:0];
    _countNeedToUpload = 3;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, endHeight+10, kMainScreenWidth, _imgWidth)];
    [_bgScrollView addSubview:_bgView];
    [self reloadView];
    

    endHeight += _imgWidth+10;
    CGFloat contentH = _bgScrollView.height+1>endHeight+5?_bgScrollView.height+1:endHeight+5;
    _bgScrollView.contentSize = CGSizeMake(kMainScreenWidth, contentH);
}

#pragma mark touchBtn
- (void)touchfl
{
    [self.view endEditing:YES];
    void(^selectBlock)(SPGLCategoryMode *) = ^(SPGLCategoryMode *aMode){
        [_btnfl setTitle:aMode.strCateName forState:UIControlStateNormal];
        [self.btnfl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

- (void)touchkc
{
    [self.navigationController pushViewController:self.kcvc animated:YES];
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
        self.btnOK.enabled = NO;
        [SVProgressHUD showWithStatus:@"上传商品中" cover:YES offsetY:kMainScreenHeight/2.0];
        [self.manager saveOrUpdateDict:dict finishBlock:^(NSString *resultCode) {
            if (resultCode)
            {
                if (_photoArr.count>0)
                {
                    [SVProgressHUD showWithStatus:@"上传图片中" cover:YES offsetY:kMainScreenHeight/2.0];
                    int count = (int)_photoArr.count;
                    __block int chuanOK=0;
                    for (int i=0; i<count; i++)
                    {
                        [NetManager uploadImgArry:@[_photoArr[i]] parameters:@{@"id":resultCode} apiName:@"uploadProductPic" uploadUrl:nil uploadimgName:nil progressBlock:nil succ:^(NSDictionary *successDict) {
                            NSString *msg = successDict[@"msg"];
                            MLOG(@"%@", successDict);
                            if ([msg isEqualToString:@"success"])
                            {
                                chuanOK++;
                                NSDictionary *temDict = successDict[@"result"];
                                
                                NSString *domain = temDict[@"picDomain"];
                                NSString *picName = temDict[@"picName"];
                                NSString *url = [temDict[@"picUrl"] stringByAppendingString:picName];
                                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
                                [dict setObject:url forKey:@"pic_url"];
                                [dict setObject:domain forKey:@"pic_domain"];
                                [dict setObject:resultCode forKey:@"pid"];
                                [_picArray addObject:dict];
                                
                                if (chuanOK==count)
                                {
                                    [NetManager requestWith:@{@"id":resultCode,@"picList":_picArray} apiName:@"updateProductPicApp" method:@"POST" succ:^(NSDictionary *successDict) {
                                        NSString *msg = successDict[@"msg"];
                                        if ([msg isEqualToString:@"success"])
                                        {
                                            [SVProgressHUD showSuccessWithStatus:@"商品发布成功" cover:YES offsetY:kMainScreenHeight/2.0];
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }
                                        else
                                        {
                                            self.btnOK.enabled = YES;
                                            [SVProgressHUD showErrorWithStatus:@"上传失败" cover:YES offsetY:kMainScreenHeight/2.0];
                                        }
                                    } failure:^(NSDictionary *failDict, NSError *error) {
                                        self.btnOK.enabled = YES;
                                        [SVProgressHUD showErrorWithStatus:@"上传失败" cover:YES offsetY:kMainScreenHeight/2.0];
                                    }];
                                }
                                
                            }
                            else
                            {
                                self.btnOK.enabled = YES;
                                [SVProgressHUD showErrorWithStatus:@"上传失败" cover:YES offsetY:kMainScreenHeight/2.0];
                            }
                        } failure:^(NSDictionary *failDict, NSError *error) {
                            self.btnOK.enabled = YES;
                            [SVProgressHUD dismiss];
                        }];
                    }

                }
                else
                {
                    [SVProgressHUD showSuccessWithStatus:@"商品发布成功" cover:YES offsetY:kMainScreenHeight/2.0];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            else
            {
                self.btnOK.enabled = YES;
                [SVProgressHUD showErrorWithStatus:@"发布失败" cover:YES offsetY:kMainScreenHeight/2.0];
            }
        }];
    }
}


- (NSDictionary *)getDict
{
    if ([self isAllOK])
    {
        NSDictionary *dict = [self dictFromMode];
        
        return dict;
    }
    else return nil;
}

- (NSDictionary *)dictFromMode
{    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@0 forKey:@"operateType"];
    if (_cid)
    {
        [dict setObject:_cid forKey:@"cid"];
        [dict setObject:[self.btnfl.titleLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"cls_name"];
    }
    if (_supid)
    {
        [dict setObject:_supid forKey:@"sup_id"];
        [dict setObject:self.btngy.titleLabel.text forKey:@"sup_name"];
    }
    NSString *kc = _btnkc.titleLabel.text?_btnkc.titleLabel.text:@"0";
    [dict setObject:kc forKey:@"stock"];
    if (![kc isEqualToString:@"0"]) {
        [dict setObject:_resultArr forKey:@"pStockList"];
    }
    [dict setObject:[self.textfieldpm.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"product_name"];
    [dict setObject:self.textfieldtm.text forKey:@"product_code"];
    NSString *jj = [self isNotEmpty:self.textfieldjj.text]?self.textfieldjj.text:@"0";
    [dict setObject:jj forKey:@"buying_price"];
    [dict setObject:self.textfieldsj.text forKey:@"sale_price"];
    [dict setObject:[self.textfielddw.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"sale_unit"];
    NSString *act;
    NSString *score;
    if ([self.btnzk.titleLabel.text isEqualToString:@"参加"]) act = @"1";
    else act = @"0";
    if ([self.btnjf.titleLabel.text isEqualToString:@"是"]) score = @"1";
    else score = @"0";
    [dict setObject:score forKey:@"is_score"];
    [dict setObject:act forKey:@"act_enabled"];

    return [dict copy];
}

- (BOOL)isAllOK
{
    if (![self isAllNum1:self.textfieldtm.text] || ![self isNotEmpty:self.textfieldtm.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确条码" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
    else if(![self isNotEmpty:self.textfieldpm.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入商品名" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
    else if(![self isNotEmpty:self.btnfl.titleLabel.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择商品分类" cover:YES offsetY:kMainScreenHeight/2.0];
        return NO;
    }
//    else if(![self isPureFloat:self.textfieldjj.text])
//    {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确进价" cover:YES offsetY:kMainScreenHeight/2.0];
//        return NO;
//    }
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
    }else if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        
        if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) { // 从相册选择
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            
            if (kSystemVersion>7) {
                picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self presentViewController:picker animated:YES completion:nil];
        } else if (buttonIndex == UIImagePickerControllerSourceTypeCamera) { // 拍照
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            picker.delegate = self;
            if (kSystemVersion>7) {
                picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self presentViewController:picker animated:YES completion:nil];
        }
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

- (UIButton *)btnkc
{
    if (!_btnkc)
    {
        _btnkc = (UIButton *)[_bgScrollView viewWithTag:103];
    }
    return _btnkc;
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

- (SPKCViewController *)kcvc
{
    if (!_kcvc) {
        _kcvc= [[SPKCViewController alloc] initWithBlock:^(NSArray *aArr) {
            float allCount = 0;
            for (NSDictionary *dict in aArr)
            {
                allCount += [dict[@"stockQty"] floatValue];
            }
            _resultArr = aArr;
            [self.btnkc setTitle:[NSString stringWithFormat:@"%.2f", allCount] forState:UIControlStateNormal];
            [self.btnkc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }];
    }
    return _kcvc;
}

- (void)reloadView
{
    [self removeSubviews:_bgView];
    CGFloat endWidth=0;
    for (int i=0; i<_photoArr.count; i++)
    {
        UIImage *img = _photoArr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(endWidth+_interval, 0, _imgWidth, _imgWidth)];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(touchPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:img forState:UIControlStateNormal];
        [_bgView addSubview:btn];
        endWidth += _interval+_imgWidth;
    }
    if (_photoArr.count<_countNeedToUpload)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(endWidth+_interval, 0, _imgWidth, _imgWidth)];
        btn.layer.borderWidth=0.5;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"+" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:btn];
    }
}

- (void)addPhoto
{
    [self.view endEditing:YES];
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_photoArr addObject:image];
    [self reloadView];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage * oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 保存图片到相册中
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(oriImage, self,selectorToCall, NULL);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
        paramImage = nil;
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}

- (void)touchPhoto:(UIButton *)sender
{
    _deleteIndex = (int)sender.tag-100;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否要删除这张图片" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [_photoArr removeObjectAtIndex:_deleteIndex];
        [self reloadView];
    }
}

- (void)removeSubviews:(UIView *)aView
{
    while (aView.subviews.count)
    {
        UIView* child = aView.subviews.lastObject;
        [child removeFromSuperview];
    }
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
