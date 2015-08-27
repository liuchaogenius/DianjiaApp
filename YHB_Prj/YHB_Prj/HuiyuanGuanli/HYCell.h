//
//  HYCell.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VipInfoMode;
@interface HYCell : UITableViewCell
{
    
    __weak id okButtonTarget;
    SEL okButtonItemAction;
}
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *vipNum;
@property (strong, nonatomic) IBOutlet UILabel *vipName;
@property (strong, nonatomic) IBOutlet UILabel *vipPhone;
@property (strong, nonatomic) IBOutlet UILabel *vipScore;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (assign, nonatomic) int cellIndex;
@property (assign, nonatomic) BOOL isSelect;
- (void)setCellData:(VipInfoMode *)aMode isSelect:(BOOL)aIsSelect indexpath:(int)aIndex;
- (void)addSelectButtonItemCallBack:(id)aTarget
                             action:(SEL)aSelector;
@end
