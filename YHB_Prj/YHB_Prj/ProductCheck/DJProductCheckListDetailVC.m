//
//  DJProductCheckListDetailVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJProductCheckListDetailVC.h"
#import "DJProductCheckListCell.h"
#import "DJProductCheckManager.h"
#import "DJProductCheckDetail.h"

typedef NS_ENUM(NSUInteger, DJProductCheckDetailType) {
    DJProductCheckDetailTypeALL = 0, //全部
    DJProductCheckDetailTypeLess,    //盘亏
    DJProductCheckDetailTypeMore,    //盘盈
    DJProductCheckDetailTypeNormal   //正常
};

@interface DJProductCheckListDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel                               *desNumLabel;
@property (nonatomic, strong) NSArray                               *productDetails;
@property (weak, nonatomic) IBOutlet UITableView                    *tableView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray  *segmentButtons;

@end

@implementation DJProductCheckListDetailVC

#pragma mark - getter and setter
- (UILabel *)desNumLabel {
    if (!_desNumLabel) {
        _desNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kMainScreenHeight-20., 200, 20)];
        _desNumLabel.font = kFont12;
        _desNumLabel.text = @"总共盘点0种";
    }
    return _desNumLabel;
}

#pragma marl - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"全部门店"];
    [self.view addSubview:self.desNumLabel];
    [self initialSegementButtons];

    [self getCheckDetailData];
    [self setExtraCellLineHidden:self.tableView];
    
}

- (void)initialSegementButtons {
    for (UIButton *btn in self.segmentButtons) {
        [btn setTitleColor:KColor forState:UIControlStateSelected];
    }
    ((UIButton *)self.segmentButtons.firstObject).selected = YES;
}

#pragma mark - net work
- (void)getCheckDetailData {
    [SVProgressHUD showWithStatus:@"加载中..." cover:YES offsetY:0];
    [DJProductCheckManager getProductCheckDetailWithCheckId:self.checkId success:^(NSArray *resultArray) {
        [SVProgressHUD dismiss];
        self.productDetails = resultArray;
        self.desNumLabel.text = [NSString stringWithFormat:@"总计盘点%ld种",resultArray.count];
        [self.tableView reloadData];
    } fail:^(id msg) {
        [SVProgressHUD dismissWithError:@"加载失败"];
    }];
}

#pragma mark - table View data source and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJProductCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DJProductCheckDetail *detail = self.productDetails[indexPath.row];
    cell.detailTextLabel.text = detail.orderTime;
    cell.mainTitleLabel.text = detail.productName;
    cell.rightTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger) detail.realQty];
    cell.middleTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)detail.stayQty];
    cell.leftTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)detail.bookQty];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - segemnt
- (IBAction)changeSegment:(UIButton *)sender {
    for (UIButton *btn in self.segmentButtons) {
        btn.selected = NO;
    }
    sender.selected = YES;
#warning 带询问具体逻辑
    switch (sender.tag) {
        case DJProductCheckDetailTypeALL:
        {
            
        }
            break;
        case DJProductCheckDetailTypeLess:
        {
            
        }
            break;
        case DJProductCheckDetailTypeMore:
        {
            
        }
            break;
        case DJProductCheckDetailTypeNormal:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
