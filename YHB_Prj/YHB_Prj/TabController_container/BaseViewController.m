//
//  BaseViewController.m
//  FW_Project
//
//  Created by  striveliu on 13-10-3.
//  Copyright (c) 2013年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewInteraction.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface BaseViewController ()
{
    UILabel *titleLabel;
    BOOL isShowStorelist;
    BOOL isShowSLBT;
}
@end

@implementation BaseViewController
@synthesize g_OffsetY;
//@synthesize backgroundimg;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self setNavgtionBarBg];
    if(kSystemVersion>=7.0)
    {
        self.navigationController.navigationBar.barTintColor = KColor;
    }
    else
    {
        self.navigationController.navigationBar.tintColor = KColor;
    }
    //self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64);
    self.navigationController.navigationBar.alpha = 1;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    if (self != [self.navigationController.viewControllers objectAtIndex:0])
    {
        [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
    }

    if(kSystemVersion >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

    if(self.navigationController)
    {
        if(self.navigationController.navigationBarHidden == YES)
        {
            if(kSystemVersion >= 7.0)
            {
                g_OffsetY = 20;
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
            }
            else
            {
                g_OffsetY = 0;
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20);
            }
        }
        else
        {
            if(kSystemVersion >= 7.0)
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-self.navigationController.navigationBar.frame.size.height-20);
            }
            else
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-self.navigationController.navigationBar.frame.size.height-20);
            }
        }
    }
    else
    {
        if(kSystemVersion >= 7.0)
        {
            g_OffsetY = 20;
            self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
        }
        else
        {
            g_OffsetY = 0;
            self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20);
        }
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(isShowSLBT)
    {
        [self showSelectStoreButton];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenSelectStoreButton];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setBackgroundimg:(UIImage *)aBackgroundimg
{
    if(aBackgroundimg)
    {
        _backgroundimg = [aBackgroundimg resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        [imgview setImage:_backgroundimg];
        [self.view addSubview:imgview];
    }
}
- (void)setLeftButton:(UIImage *)aImg title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
{
    CGRect buttonFrame = CGRectMake(-5, 0, 88/2, 44);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    if(aImg)
    {
        [button setImage:aImg forState:UIControlStateNormal];
    }
    if(aTitle)
    {
        [button setTitle:aTitle forState:UIControlStateNormal];
    }
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    CGRect viewFrame = CGRectMake(0, 0, 88/2, 44);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    [view addSubview:button];
    
    if(self.navigationController && self.navigationItem)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
}

- (void)settitleLabel:(NSString*)aTitle
{
    if(titleLabel)
    {
        [titleLabel removeFromSuperview];
        titleLabel = nil;
    }
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, self.navigationController.navigationBar.frame.size.height)];
    self.navigationItem.titleView = titleLabel;
    
    titleLabel.center = self.navigationController.navigationBar.center;
    titleLabel.backgroundColor = kClearColor;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = kFont18;
    titleLabel.text = aTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)hiddenSelectStoreButton
{
    [self.storeListBT removeFromSuperview];
    self.storeListBT = nil;
}

- (void)showSelectStoreButton
{
    if(self.storeListBT)
    {
        [self.storeListBT removeFromSuperview];
        self.storeListBT = nil;
    }
    isShowSLBT = YES;
    UIImage *img = [UIImage imageNamed:@"selectStorelist_bt"];
    self.storeListBT = [[UIButton alloc] initWithFrame:CGRectMake(titleLabel.right+5, (44-img.size.height)/2, 44, 44)];
    [self.storeListBT setImage:img forState:UIControlStateNormal];
    self.storeListBT.tag = 101010;
    [self.storeListBT addTarget:self action:@selector(showStoreview) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:self.storeListBT];
}

- (void)showStoreview
{
    if(isShowStorelist == NO)
    {
        isShowStorelist = YES;
        self.sview = [[StoreListView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 150)];
        [self.view addSubview:self.sview];
        [self.sview setStoreList:[[LoginManager shareLoginManager] getStoreList]];
        [self obserStoreviewResult];
    }
    else
    {
        isShowStorelist = NO;
        [self.sview removeFromSuperview];
        self.sview = nil;
    }
}

- (void)obserStoreviewResult
{
    __weak typeof(self) weakself = self;
    [self.sview didSelectStoreMode:^(StoreMode *aMode) {
        isShowStorelist = NO;
        [weakself.sview removeFromSuperview];
        weakself.sview = nil;
    }];
}

- (void)setRightButton:(UIImage *)aImg title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
{
    CGRect buttonFrame = CGRectMake(5, 0, 59.0f, 44.0f);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    if(aTitle)
    {
        [button setTitle:aTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if(aImg)
    {
        [button setImage:aImg forState:UIControlStateNormal];
    }
    CGRect viewFrame = CGRectMake(kMainScreenWidth-100/2, 0, 59, 44);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    [view addSubview:button];
    if(self.navigationController && self.navigationItem)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
    _rightButton = button;
}

- (void)pushView:(UIView*)aView
{
    [ViewInteraction viewPresentAnimationFromRight:self.view toView:aView];
}

- (void)popView:(UIView*)aView completeBlock:(void(^)(BOOL isComplete))aCompleteblock
{
    [ViewInteraction viewDissmissAnimationToRight:aView isRemove:NO completeBlock:^(BOOL isComplete) {
        aCompleteblock(isComplete);
    }];
}

- (UIViewController *)pushVCName:(NSString *)aVCName
          animated:(BOOL)animated
          selector:(NSString *)aSelecotorName
             param:(id)aParam, ...
{
    Class vcClass = NSClassFromString(aVCName);
    UIViewController *vc = [[vcClass alloc] init];
    SEL sel = NSSelectorFromString(aSelecotorName);
    NSMutableArray *paramArry = [NSMutableArray arrayWithCapacity:0];
    if(vc && sel && [vc respondsToSelector:sel])
    {
        
        va_list args;
        va_start(args, aParam);
        id firstParam = aParam;
        if(firstParam)
        {
            [paramArry addObject:firstParam];
            while (firstParam) {
                MLOG(@"firstParam = %@",firstParam);
                firstParam = va_arg(args, id);
                //MLOG(@"firstParam111 = %@",firstParam);
                if(!firstParam)
                {
                    break;
                }
                [paramArry addObject:firstParam];
            }
        }
        else
        {
            void (*action)(id, SEL) = (void (*)(id, SEL)) objc_msgSend;
            action(vc, sel);
        }
        va_end(args);
        if(paramArry.count > 0)
        {
            [self perforVCSelector:paramArry selector:sel target:vc];
        }
    }
    [self.navigationController pushViewController:vc animated:animated];
    return vc;
}

- (UIViewController *)pushXIBName:(NSString *)aXIBName
           animated:(BOOL)animated
           selector:(NSString *)aSelecotorName
              param:(id)aParam, ...
{
    Class vcClass = NSClassFromString(aXIBName);
    UIViewController *vc = [[vcClass alloc] initWithNibName:aXIBName bundle:nil];
    SEL sel = NSSelectorFromString(aSelecotorName);
    NSMutableArray *paramArry = [NSMutableArray arrayWithCapacity:0];
    if(vc && sel && [vc respondsToSelector:sel])
    {
        va_list args;
        va_start(args, aParam);
        id firstParam = aParam;
        if(firstParam)
        {
            [paramArry addObject:firstParam];
            while (firstParam) {
                MLOG(@"firstParam = %@",firstParam);
                firstParam = va_arg(args, id);
                //MLOG(@"firstParam111 = %@",firstParam);
                if(!firstParam)
                {
                    break;
                }
                [paramArry addObject:firstParam];
            }
        }
        else
        {
            void (*action)(id, SEL) = (void (*)(id, SEL)) objc_msgSend;
            action(vc, sel);
        }
        va_end(args);
        if(paramArry.count > 0)
        {
            [self perforVCSelector:paramArry selector:sel target:vc];
        }
    }
    
    if ([self isKindOfClass:NSClassFromString(@"ShangpinguanliVC")]) {
        BOOL boolValue = [[self valueForKey:@"isFromProductCheckCart"] boolValue];
        if (boolValue) {
            [vc setValue:@(1) forKey:@"serchFrom"];
        }
    }
    
    [self.navigationController pushViewController:vc animated:animated];
    return vc;
}

- (void)perforVCSelector:(NSArray *)aParArry
                selector:(SEL)aSelecotor
                  target:(id)aTarget
{
    switch (aParArry.count) {
        case 1:
        {
            void (*action)(id, SEL,id) = (void (*)(id, SEL,id)) objc_msgSend;
            action(aTarget, aSelecotor,[aParArry objectAtIndex:0]);
        }
            break;
        case 2:
        {
            void (*action)(id, SEL,id,id) = (void (*)(id, SEL,id,id)) objc_msgSend;
            action(aTarget, aSelecotor,[aParArry objectAtIndex:0],[aParArry objectAtIndex:1]);
        }
            break;
        case 3:
        {
            void (*action)(id, SEL,id,id,id) = (void (*)(id, SEL,id,id,id)) objc_msgSend;
            action(aTarget, aSelecotor,[aParArry objectAtIndex:0],[aParArry objectAtIndex:1],[aParArry objectAtIndex:2]);
        }
            break;
        case 4:
        {
            void (*action)(id, SEL,id,id,id,id) = (void (*)(id, SEL,id,id,id,id)) objc_msgSend;
            action(aTarget, aSelecotor,[aParArry objectAtIndex:0],[aParArry objectAtIndex:1],[aParArry objectAtIndex:2],[aParArry objectAtIndex:3]);
        }
            break;
        case 5:
        {
            void (*action)(id, SEL,id,id,id,id,id) = (void (*)(id, SEL,id,id,id,id,id)) objc_msgSend;
            action(aTarget, aSelecotor,[aParArry objectAtIndex:0],[aParArry objectAtIndex:1],[aParArry objectAtIndex:2],[aParArry objectAtIndex:3],[aParArry objectAtIndex:4]);
        }
            break;
        case 6:
        {
            void (*action)(id, SEL,id,id,id,id,id,id) = (void (*)(id, SEL,id,id,id,id,id,id)) objc_msgSend;
            action(aTarget, aSelecotor,[aParArry objectAtIndex:0],[aParArry objectAtIndex:1],[aParArry objectAtIndex:2],[aParArry objectAtIndex:3],[aParArry objectAtIndex:4],[aParArry objectAtIndex:5]);
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
