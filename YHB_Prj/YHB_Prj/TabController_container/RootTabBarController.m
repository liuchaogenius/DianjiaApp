//
//  RootTabBarController.m
//  Hubanghu
//
//  Created by  striveliu on 14-10-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "RootTabBarController.h"
#import "FBKVOController.h"
#import "ViewInteraction.h"
#import "FactoryModel.h"
#import "LSNavigationController.h"

@interface RootTabBarController ()
{
    
    NSInteger newSelectIndex;
    NSInteger oldSelectIndex;
    NSMutableArray *navArry;
    FBKVOController *loginObserver;
    FBKVOController *leftViewObserver;
    
    BOOL isGoBack;
}
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self.delegate = self;
    isGoBack = NO;
    [self initTabViewController];
    [self initTabBarItem];
    [self initNotifyRegister];
}

- (void)initNotifyRegister
{
    [NotifyFactoryObject registerLoginMsgNotify:self action:@selector(showLoginViewController:)];
}

- (void)initTabViewController
{
    NSArray *arry = [[FactoryModel shareFactoryModel] getTabbarArrys];
    navArry = [NSMutableArray arrayWithCapacity:0];
    if(arry && arry.count>0)
    {
        for(UIViewController *vc in arry)
        {
            LSNavigationController *nav = [[LSNavigationController alloc] initWithRootViewController:vc];
            [navArry addObject:nav];
        }
    }

    self.viewControllers = navArry;
}

- (void)initTabBarItem
{
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_sel"]]];
    //if(kSystemVersion<7.0)
    {
        UIImage *img = [[UIImage imageNamed:@"tabbarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [[UITabBar appearance] setBackgroundImage:img];
    }
    for(int i=0; i<navArry.count;i++)
    {
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        UIImage *norimg = [UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_nor_%d",i+1]];
        UIImage *selimg = [UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_sel_%d",i+1]];

        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        tabBarItem.title = @" ";
        if(kSystemVersion>=7.0)
        {
            norimg = [norimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selimg = [selimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarItem.image = norimg;
            tabBarItem.selectedImage = selimg;
            tabBarItem.tag = i;
        }
    }
    
    MLOG(@"tabbarHeight=%f",self.tabBar.frame.size.height);

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    MLOG(@"shouldtabsel = %lu", (unsigned long)tabBarController.selectedIndex);
    oldSelectIndex = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    MLOG(@"tabsel = %ld", (unsigned long)tabBarController.selectedIndex);
    newSelectIndex = tabBarController.selectedIndex;
}


#pragma mark show login
- (void)showLoginViewController:(NSNotification *)aNotification
{
    
//    if(aNotification.object)
//    {
//        isGoBack = [[aNotification object] boolValue]; ///yes为goback  其他的不处理
//    }
//    __weak RootTabBarController *weakself = self;
//    if (![HbhUser sharedHbhUser].isLogin)
//    {
//        if(!self.loginVC)
//        {
//            self.loginVC = [[HbhLoginViewController alloc] init];
//        }
//        if(!self.loginNav)
//        {
//            self.loginNav = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
//            
//        }
//
//        [self presentViewController:self.loginNav animated:YES completion:^{
//            
//        }];
//        if(!loginObserver)
//        {
//            loginObserver = [[FBKVOController alloc] initWithObserver:self];
//        }
//        [loginObserver observe:self.loginVC keyPath:@"type" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//            int type = [[change objectForKey:@"new"] intValue];
//            if(type == eLoginSucc)
//            {
//
//            }
//            else if(type == eLoginBack)
//            {
//                if(isGoBack)
//                {
//                    weakself.selectedIndex = oldSelectIndex;
//                    isGoBack = NO;
//                }
//            }
//            [weakself.loginNav dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//        }];
//    }
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
