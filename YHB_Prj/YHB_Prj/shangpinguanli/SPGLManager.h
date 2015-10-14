//
//  SPGLManager.h
//  YHB_Prj
//
//  Created by  striveliu on 15/9/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPGLCategoryMode.h"
#import "SPGLProductMode.h"

@interface SPGLManager : NSObject
- (void)getAllProductCls:(void(^)(SPGLCategoryIndexList *list))aFinishBlock;
//2、	按分类查询商品列表
- (void)getProductListByClsApp:(NSString*)aId
                   finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock;
// 关键字查询
- (void)getProductListByKeywordApp:(NSString*)aKeyword
                       finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock;
// 条形码查询
- (void)getProductListByCodeApp:(NSString*)aKeyword
                    finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock;
//盘点车进来后的搜索
-(void)getProductListForCheck:(NSString*)aKeyword
                          cid:(NSString *)aCid
                  finishBlock:(void(^)(SPGLProductList* aList))aFinishBlock;

@end
