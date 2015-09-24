//
//  WYJHEditViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/9/16.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "WYJHEditViewController.h"
#import "WYJHMode.h"
#import "NetManager.h"

#define kStringIsNotEmpty(aBool, str) do{\
if (!str) {\
aBool=false;\
} else {\
NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];\
NSString *trimedString = [str stringByTrimmingCharactersInSet:set];\
if ([trimedString length] == 0) {\
aBool=false;\
} else {\
aBool=true;\
}\
}\
}while(0)

@interface WYJHEditViewController ()
@property(nonatomic,strong) WYJHMode *myMode;
@property(nonatomic,strong) WYJHModeList *myModeList;
@property(nonatomic,strong) void(^ myBlock)(void);
@property(nonatomic,assign) BOOL canNull;

@property(nonatomic,strong) UITextField *tfJJ;
@property(nonatomic,strong) UITextField *tfSJ;
@property(nonatomic,strong) UITextField *tfJH;
@end

@implementation WYJHEditViewController

- (instancetype)initWithMode:(WYJHMode *)aMode modeList:(WYJHModeList *)aList andChangeBlock:(void(^)(void))aBlock canNull:(BOOL)aBool
{
    if (self=[super init])
    {
        _myBlock = aBlock;
        _myMode = aMode;
        _myModeList = aList;
        _canNull = aBool;
    }
    return self;
}

- (NSString *)strFormMode:(NSString *)aModeStr
{
    NSString *str = aModeStr&&aModeStr.length>0?aModeStr:@"";
    return str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchOk)];
    
    NSArray *titleArray = @[@"条码",@"品名",@"供应商",@"库存",@"存货",@"进价",@"售价",@"进货"];
    NSString *strStockNum = _myMode.strStockNum&&[_myMode.strStockNum intValue]>0?_myMode.strStockNum:@"";
    NSArray *contentArray = @[[self strFormMode:_myMode.strProductCode],[self strFormMode:_myMode.strProductName], [self strFormMode:_myMode.strSupName],[self strFormMode:_myMode.strStockQty],[self strFormMode:_myMode.strStayQty],[NSString stringWithFormat:@"%.2f", [[self strFormMode:_myMode.strStockPrice] floatValue]],[NSString stringWithFormat:@"%.2f", [[self strFormMode:_myMode.strSalePrice] floatValue]],strStockNum];
    
    for (int i=0; i<8; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15+25*i, 10, 10)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"jh_%d", i]];
        [self.view addSubview:imgView];
        
        NSString *str = titleArray[i];
        CGFloat stringWidth = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFont12,NSFontAttributeName, nil]].width;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+5, imgView.top-5, stringWidth, 20)];
        label.font = kFont12;
        label.text = str;
        [self.view addSubview:label];
        
        CGRect frame = CGRectMake(label.right+5, label.top, 240, 20);
        if (i<5)
        {
            UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
            textLabel.font = kFont12;
            textLabel.text = contentArray[i];
            [self.view addSubview:textLabel];
        }
        else
        {
            UITextField *tf = [[UITextField alloc] initWithFrame:frame];
            tf.font=kFont12;
            tf.text = contentArray[i];
            tf.tag = i;
            tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            [self.view addSubview:tf];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tf.left-2, tf.bottom, tf.width, 0.5)];
            lineView.backgroundColor = [UIColor blackColor];
            [self.view addSubview:lineView];
        }
    }
    
    self.tfJJ.placeholder = @"请输入进价";
    self.tfJH.placeholder = @"请输入进货数量";
    self.tfSJ.placeholder = @"请输入售价";
}

- (void)touchOk
{
    if (_canNull==NO)
    {
        if ([self isPureFloat:self.tfJJ.text] && [self isPureFloat:self.tfSJ.text] && [self isPureInt:self.tfJH.text])
        {
            int aJH = [self.tfJH.text intValue];
            int bJH = [_myMode.strStockNum intValue];
            float aJJ = [self.tfJJ.text floatValue];
            float bJJ = [_myMode.strStockPrice floatValue];
            int chaN = aJH-bJH;
            float chaP = aJH*aJJ-bJH*bJJ;
            _myMode.strStockPrice = self.tfJJ.text;
            _myMode.strSalePrice = self.tfSJ.text;
            _myMode.strStockNum = self.tfJH.text;
            
            int allJH = [_myModeList.strStockNum intValue];
            float allPrice = [_myModeList.strTotalRealPay floatValue];
            _myModeList.strStockNum = [NSString stringWithFormat:@"%d", chaN+allJH];
            _myModeList.strTotalRealPay = [NSString stringWithFormat:@"%.2f", chaP+allPrice];
            
            _myBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }
        else [SVProgressHUD showErrorWithStatus:@"请输入数字" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    else
    {
        if ([self isPureFloat:self.tfJJ.text] && [self isPureFloat:self.tfSJ.text])
        {
            BOOL a;
            kStringIsNotEmpty(a, self.tfJH.text);
            if (a==YES)
            {
                if([self isPureInt:self.tfJH.text])
                {
                    int aJH = [self.tfJH.text intValue];
                    float aJJ = [self.tfJJ.text floatValue];
                    _myMode.strStockPrice = self.tfJJ.text;
                    _myMode.strSalePrice = self.tfSJ.text;
                    _myMode.strStockNum = self.tfJH.text;
                    
                    int allJH = [_myModeList.strStockNum intValue];
                    float allPrice = [_myModeList.strTotalRealPay floatValue];
                    _myModeList.strStockNum = [NSString stringWithFormat:@"%d", aJH+allJH];
                    _myModeList.strTotalRealPay = [NSString stringWithFormat:@"%.2f", aJH*aJJ+allPrice];
                    
                    for (int i=0; i<_myModeList.modeListArry.count; i++)
                    {
                        WYJHMode *mode = _myModeList.modeListArry[i];
                        if ([mode.strId isEqualToString:_myMode.strId])
                        {
                            [_myModeList.modeListArry removeObjectAtIndex:i];
                            break;
                        }
                    }
                    [_myModeList.modeListArry addObject:_myMode];
                    _myBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else [SVProgressHUD showErrorWithStatus:@"请输入数字" cover:YES offsetY:kMainScreenHeight/2.0];
            }
            else [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    if ([scan scanFloat:&val] && [scan isAtEnd])
    {
        if ([string floatValue]>0)
        {
            return YES;
        }else return NO;
    }
    else return NO;
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    if ([scan scanInt:&val] && [scan isAtEnd]) {
        if ([string intValue]>0)
        {
            return YES;
        }else return NO;
    }
    else return NO;
}

- (UITextField *)tfJJ
{
    if (!_tfJJ) {
        _tfJJ = (UITextField *)[self.view viewWithTag:5];
    }
    return _tfJJ;
}

- (UITextField *)tfSJ
{
    if (!_tfSJ) {
        _tfSJ = (UITextField *)[self.view viewWithTag:6];
    }
    return _tfSJ;
}

- (UITextField *)tfJH
{
    if (!_tfJH) {
        _tfJH = (UITextField *)[self.view viewWithTag:7];
    }
    return _tfJH;
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
