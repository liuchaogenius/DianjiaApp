//
//  DJProductCheckVC.h
//  YHB_Prj
//
//  Created by yato_kami on 15/8/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
#import "DJCheckCartItemComponent.h"

typedef NS_ENUM(NSUInteger, DJNumPadTagType) {
    DJNumPadTagTypePlus = 11,
    DJNumPadTagTypeDelete,
};

@protocol DJProductCheckViewDataSoure <NSObject>

@required
- (id<DJCheckCartItemComponent>)nextItem;

@end

@protocol DJProductCheckViewDelegate <NSObject>

- (void)didNeedDissmiss: (UIViewController *)vc;

- (void)didNeedGoCheckCart: (UIViewController *)vc;

@end

@interface DJProductCheckVC : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stayQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *gotoCartButton;
@property (weak, nonatomic) IBOutlet UITextField *numPadTextField;
@property (weak, nonatomic) id<DJProductCheckViewDataSoure> dataSoure;
@property (weak, nonatomic) id<DJProductCheckViewDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numPadButtons;

- (void)rollBack;

@end
