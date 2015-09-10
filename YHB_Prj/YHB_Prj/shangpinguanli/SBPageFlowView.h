//
//  SBPageFlowView.h
//  SBFlowView
//
//  Created by JK.Peng on 13-1-30.
//  Copyright (c) 2013年 njut. All rights reserved.
//

/***********************************************************************************
*
* Created by JK.Peng on 13-1-30.
*
* Any comment or suggestion welcome. Referencing this project in your AboutBox/Credits is appreciated.
*
***********************************************************************************/

/*
 *It provides a novel　picture browse. 
 *While this page is shown,  the parts of content in the adjacent Pages also can be seen 。
 *
 *Feature: Cycle　Scroll　View
 *
 *I refereed the web：https://github.com/kejinlu/PagedFlowView
 *Here，I want to say thanks to the original author
 */

#import <UIKit/UIKit.h>

typedef enum{
    FlowViewOrientationHorizontal = 0,
    FlowViewOrientationVertical
}FlowViewOrientation;

typedef enum {
	PageDirectionPrevious = 0,
	PageDirectionDown
} PageDirectionE;

@protocol SBPageFlowViewDataSource;
@protocol SBPageFlowViewDelegate;

@interface SBPageFlowView : UIView<UIScrollViewDelegate>{
    FlowViewOrientation  _orientation;      
    UIScrollView        *_scrollView;
    UIImageView         *_defaultImageView;   //default，when no data，display default image
    
    BOOL                _needsReload;
    
    CGSize              _pageSize;             //size of page
    NSInteger           _pageCount;            //total page count 
    NSInteger           _currentPageIndex;
    
    NSRange              _visibleRange;
    
    NSMutableArray      *_reusableCells;     //UnseedCell
    NSMutableArray      *_inUseCells;        //using Cell
    
    CGFloat _minimumPageAlpha;          //default is 1.0
    CGFloat _minimumPageScale;          //default is 1.0
    
    __weak id <SBPageFlowViewDataSource>   _dataSource;
    __weak id <SBPageFlowViewDelegate>     _delegate;

}

@property (nonatomic, weak) id <SBPageFlowViewDataSource> dataSource;
@property (nonatomic, weak) id <SBPageFlowViewDelegate>   delegate;
@property (nonatomic, retain) UIImageView         *defaultImageView;
@property (nonatomic, assign) FlowViewOrientation orientation;
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;
@property (nonatomic, assign) CGFloat minimumPageAlpha;
@property (nonatomic, assign) CGFloat minimumPageScale;

- (void)reloadData;
- (UIView *)dequeueReusableCell;
- (UIView *)cellForItemAtCurrentIndex:(NSInteger)currentIndex;

- (void)scrollToNextPage;

@end

@protocol  SBPageFlowViewDelegate<NSObject>
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index;

@optional
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(SBPageFlowView *)flowView;
- (void)didSelectItemAtIndex:(NSInteger)index inFlowView:(SBPageFlowView *)flowView;

@end


@protocol SBPageFlowViewDataSource <NSObject>

// Return the number of views.
- (NSInteger)numberOfPagesInFlowView:(SBPageFlowView *)flowView;
- (CGSize)sizeForPageInFlowView:(SBPageFlowView *)flowView;

// Reusable cells
- (UIView *)flowView:(SBPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index;

@end

