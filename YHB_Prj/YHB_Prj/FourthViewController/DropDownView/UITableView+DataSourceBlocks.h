//
//  UITableViewDataSourceBlocks.h
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NSInteger (^UITableViewNumberOfSectionsInTableViewBlock)(UITableView* tableView);
typedef NSArray* (^UITableViewSectionIndexTitlesForTableViewBlock)(UITableView* tableView);
typedef BOOL (^UITableViewCanEditRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef BOOL (^UITableViewCanMoveRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef UITableViewCell* (^UITableViewCellForRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^UITableViewCommitEditingStyleBlock)(UITableView* tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath* indexPath);
typedef void (^UITableViewMoveRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* fromIndexPath, NSIndexPath* toIndexPath);
typedef NSInteger (^UITableViewNumberOfRowsInSectionBlock)(UITableView* tableView, NSInteger section);
typedef NSInteger (^UITableViewSectionForSectionIndexTitleBlock)(UITableView* tableView, NSString* title, NSInteger index);
typedef NSString* (^UITableViewTitleForFooterInSectionBlock)(UITableView* tableView, NSInteger section);
typedef NSString* (^UITableViewTitleForHeaderInSectionBlock)(UITableView* tableView, NSInteger section);

@interface UITableView (DataSourceBlocks)

-(id)useBlocksForDataSource;
-(void)onNumberOfSectionsInTableView:(UITableViewNumberOfSectionsInTableViewBlock)block;
-(void)onSectionIndexTitlesForTableView:(UITableViewSectionIndexTitlesForTableViewBlock)block;
-(void)onCanEditRowAtIndexPath:(UITableViewCanEditRowAtIndexPathBlock)block;
-(void)onCanMoveRowAtIndexPath:(UITableViewCanMoveRowAtIndexPathBlock)block;
-(void)onCellForRowAtIndexPath:(UITableViewCellForRowAtIndexPathBlock)block;
-(void)onCommitEditingStyle:(UITableViewCommitEditingStyleBlock)block;
-(void)onMoveRowAtIndexPath:(UITableViewMoveRowAtIndexPathBlock)block;
-(void)onNumberOfRowsInSection:(UITableViewNumberOfRowsInSectionBlock)block;
-(void)onSectionForSectionIndexTitle:(UITableViewSectionForSectionIndexTitleBlock)block;
-(void)onTitleForFooterInSection:(UITableViewTitleForFooterInSectionBlock)block;
-(void)onTitleForHeaderInSection:(UITableViewTitleForHeaderInSectionBlock)block;

@end

@interface UITableViewDataSourceBlocks : NSObject <UITableViewDataSource> {
    UITableViewNumberOfSectionsInTableViewBlock _numberOfSectionsInTableViewBlock;
    UITableViewSectionIndexTitlesForTableViewBlock _sectionIndexTitlesForTableViewBlock;
    UITableViewCanEditRowAtIndexPathBlock _canEditRowAtIndexPathBlock;
    UITableViewCanMoveRowAtIndexPathBlock _canMoveRowAtIndexPathBlock;
    UITableViewCellForRowAtIndexPathBlock _cellForRowAtIndexPathBlock;
    UITableViewCommitEditingStyleBlock _commitEditingStyleBlock;
    UITableViewMoveRowAtIndexPathBlock _moveRowAtIndexPathBlock;
    UITableViewNumberOfRowsInSectionBlock _numberOfRowsInSectionBlock;
    UITableViewSectionForSectionIndexTitleBlock _sectionForSectionIndexTitleBlock;
    UITableViewTitleForFooterInSectionBlock _titleForFooterInSectionBlock;
    UITableViewTitleForHeaderInSectionBlock _titleForHeaderInSectionBlock;
}

@property(nonatomic, copy) UITableViewNumberOfSectionsInTableViewBlock numberOfSectionsInTableViewBlock;
@property(nonatomic, copy) UITableViewSectionIndexTitlesForTableViewBlock sectionIndexTitlesForTableViewBlock;
@property(nonatomic, copy) UITableViewCanEditRowAtIndexPathBlock canEditRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewCanMoveRowAtIndexPathBlock canMoveRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewCellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewCommitEditingStyleBlock commitEditingStyleBlock;
@property(nonatomic, copy) UITableViewMoveRowAtIndexPathBlock moveRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewNumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property(nonatomic, copy) UITableViewSectionForSectionIndexTitleBlock sectionForSectionIndexTitleBlock;
@property(nonatomic, copy) UITableViewTitleForFooterInSectionBlock titleForFooterInSectionBlock;
@property(nonatomic, copy) UITableViewTitleForHeaderInSectionBlock titleForHeaderInSectionBlock;

@end

