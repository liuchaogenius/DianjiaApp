//
//  DateSelectVC.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

typedef NS_ENUM(int, dateBtTag)
{
    jt_enum=0,
    zt_enum,
    j3t_enum,
    j7t_enum,
    j10t_enum,
    bz_enum,
    by_enum,
    bjd_enum,
    j30t_enum,
    j90t_enum
};

#import "DateSelectVC.h"

@interface DateSelectVC ()
{
    dateBtTag dtag;
    int btTag;
    NSString *startDate;
    NSString *endDate;
    NSString *showStartDate;
    NSString *showEndDate;
}
@property (strong, nonatomic) IBOutlet UIButton *jinTian_BT;
@property (strong, nonatomic) IBOutlet UIButton *zuoTian_BT;
@property (strong, nonatomic) IBOutlet UIButton *jin3Tian_bt;
@property (strong, nonatomic) IBOutlet UIButton *jin7tian_bt;
@property (strong, nonatomic) IBOutlet UIButton *jin10tian_bt;
@property (strong, nonatomic) IBOutlet UIButton *benzhou_bt;
@property (strong, nonatomic) IBOutlet UIButton *benyue_bt;
@property (strong, nonatomic) IBOutlet UIButton *benjidu_bt;
@property (strong, nonatomic) IBOutlet UIButton *jin30tian_bt;
@property (strong, nonatomic) IBOutlet UIButton *jin90tian_bt;
@property (strong, nonatomic) IBOutlet UIButton *startDatePick_bt;
@property (strong, nonatomic) IBOutlet UIButton *endDatePick_bt;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateStart_Pick;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateEnd_pick;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIButton *okButton;

@property (copy ,nonatomic) void(^dateBlock)(NSString *sTimer, NSString *eTimer,NSString *ssTimer,NSString *seTimer, int btid);

@end

@implementation DateSelectVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    btTag = -1;
    [self setTitle:@"选择日期"];
    // Do any additional setup after loading the view from its nib.
    CGFloat height = self.okButton.bottom;
    [self.scrollview setContentSize:CGSizeMake(kMainScreenWidth, height+20)];
    self.jinTian_BT.tag = jt_enum;
    [self.jinTian_BT addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.zuoTian_BT.tag = zt_enum;
    [self.zuoTian_BT addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.jin3Tian_bt.tag = j3t_enum;
    [self.jin3Tian_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.jin7tian_bt.tag = j7t_enum;
    [self.jin7tian_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.jin10tian_bt.tag = j10t_enum;
    [self.jin10tian_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.benzhou_bt.tag = bz_enum;
    [self.benzhou_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.benyue_bt.tag = by_enum;
    [self.benyue_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.benjidu_bt.tag = bjd_enum;
    [self.benjidu_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.jin30tian_bt.tag = j30t_enum;
    [self.jin30tian_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.jin90tian_bt.tag = j90t_enum;
    [self.jin90tian_bt addTarget:self action:@selector(dateButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dateStart_Pick.tag = 0;
    [self.dateStart_Pick addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateEnd_pick.tag = 1;
    [self.dateEnd_pick addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.okButton addTarget:self action:@selector(okButtonItem) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dateButtonItem:(UIButton *)aBt
{
    btTag = (int)aBt.tag;
    switch (aBt.tag) {
        case jt_enum:
        {

            showEndDate = @"今天";
        }
            break;
        case zt_enum:
        {

            showEndDate = @"昨天";
        }
            break;
        case j3t_enum:
        {

            showEndDate = @"近3天";
        }
            break;
        case j7t_enum:
        {

            showEndDate = @"近7天";
        }
            break;
        case j10t_enum:
        {

            showEndDate =  @"近10天";
        }
            break;
        case bz_enum:
        {

            showEndDate =  @"本周";
        }
            break;
        case by_enum:
        {

            showEndDate = @"本月";
        }
            break;
        case bjd_enum:
            showEndDate = @"本季度";
            break;
        case j30t_enum:
        {
            showEndDate =@"近30天";
        }
            break;
        case j90t_enum:
        {
            showEndDate = @"近90天";
        }
            break;
        default:
            break;
    }
}

- (void)onDatePickerValueChanged:(UIDatePicker *)aDatePicker
{
    btTag = -1;
    if(aDatePicker.tag == 0)
    {
        NSDate *select = [aDatePicker date]; // 获取被选中的时间
        startDate = [NSDateTool dateToNSString:select formate:@"yyyy-MM-dd"];
        if(startDate)
        {
            startDate = [NSString stringWithFormat:@"%@ 00:00:00",startDate];
        }
        showStartDate = [NSDateTool dateToNSString:select formate:@"yyyy-MM-dd"];
        
        NSDate *selectend = [self.dateEnd_pick date]; // 获取被选中的时间
        endDate = [NSDateTool dateToNSString:selectend formate:@"yyyy-MM-dd"];
        if(endDate)
        {
            endDate = [NSString stringWithFormat:@"%@ 23:59:59",endDate];
        }
        showEndDate = [NSDateTool dateToNSString:selectend formate:@"yyyy-MM-dd"];
    }
    else if(aDatePicker.tag == 1)
    {
        NSDate *select = [aDatePicker date]; // 获取被选中的时间
        endDate = [NSDateTool dateToNSString:select formate:@"yyyy-MM-dd"];
        if(endDate)
        {
            endDate = [NSString stringWithFormat:@"%@ 23:59:59",endDate];
        }
        showEndDate = [NSDateTool dateToNSString:select formate:@"yyyy-MM-dd"];
        
        NSDate *selectstart = [aDatePicker date]; // 获取被选中的时间
        startDate = [NSDateTool dateToNSString:selectstart formate:@"yyyy-MM-dd"];
        if(startDate)
        {
            startDate = [NSString stringWithFormat:@"%@ 00:00:00",startDate];
        }
        showStartDate = [NSDateTool dateToNSString:selectstart formate:@"yyyy-MM-dd"];
    }
}

- (void)getUserSetTimer:(void(^)(NSString *sTimer, NSString *eTimer,NSString *ssTimer,NSString *seTimer, int btid))aBlock
{
    self.dateBlock = aBlock;
}

#pragma mark okbuttonItem 
- (void)okButtonItem
{
    if(btTag >= 0 || (startDate && endDate && startDate.length>0 && endDate.length > 0))
    {
         self.dateBlock(startDate, endDate,showStartDate,showEndDate,btTag);
        [self.navigationController popViewControllerAnimated:YES];
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
