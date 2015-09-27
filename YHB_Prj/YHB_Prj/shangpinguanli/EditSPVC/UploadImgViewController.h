//
//  UploadImgViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/9/12.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@interface UploadImgViewController : BaseViewController

- (instancetype)initWithUploadImgCount:(int)aCount andId:(NSString *)aId andChangeBlock:(void(^)(NSArray *))aBlock;

@end
