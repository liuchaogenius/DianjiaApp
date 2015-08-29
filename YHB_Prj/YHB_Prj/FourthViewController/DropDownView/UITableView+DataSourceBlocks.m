//
//  UITableViewDataSourceBlocks.m
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//
#import "UITableView+DataSourceBlocks.h"
#import <objc/runtime.h>

static NSString* UITableViewDataSourceBlocksKey = @"UITableViewDataSourceBlocksKey";

@implementation UITableView (DataSourceBlocks)

-(id)useBlocksForDataSource {
    UITableViewDataSourceBlocks* dataSource = [[UITableViewDataSourceBlocks alloc] init]; //autorelease];
    objc_setAssociatedObject (self, &UITableViewDataSourceBlocksKey, dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.dataSource = dataSource;
    return self;
}

-(void)onNumberOfSectionsInTableView:(UITableViewNumberOfSectionsInTableViewBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setNumberOfSectionsInTableViewBlock:block];
}

-(void)onSectionIndexTitlesForTableView:(UITableViewSectionIndexTitlesForTableViewBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setSectionIndexTitlesForTableViewBlock:block];
}

-(void)onCanEditRowAtIndexPath:(UITableViewCanEditRowAtIndexPathBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setCanEditRowAtIndexPathBlock:block];
}

-(void)onCanMoveRowAtIndexPath:(UITableViewCanMoveRowAtIndexPathBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setCanMoveRowAtIndexPathBlock:block];
}

-(void)onCellForRowAtIndexPath:(UITableViewCellForRowAtIndexPathBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setCellForRowAtIndexPathBlock:block];
}

-(void)onCommitEditingStyle:(UITableViewCommitEditingStyleBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setCommitEditingStyleBlock:block];
}

-(void)onMoveRowAtIndexPath:(UITableViewMoveRowAtIndexPathBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setMoveRowAtIndexPathBlock:block];
}

-(void)onNumberOfRowsInSection:(UITableViewNumberOfRowsInSectionBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setNumberOfRowsInSectionBlock:block];
}

-(void)onSectionForSectionIndexTitle:(UITableViewSectionForSectionIndexTitleBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setSectionForSectionIndexTitleBlock:block];
}

-(void)onTitleForFooterInSection:(UITableViewTitleForFooterInSectionBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setTitleForFooterInSectionBlock:block];
}

-(void)onTitleForHeaderInSection:(UITableViewTitleForHeaderInSectionBlock)block {
    [((UITableViewDataSourceBlocks*)self.dataSource) setTitleForHeaderInSectionBlock:block];
}

@end

@implementation UITableViewDataSourceBlocks

@synthesize numberOfSectionsInTableViewBlock = _numberOfSectionsInTableViewBlock;
@synthesize sectionIndexTitlesForTableViewBlock = _sectionIndexTitlesForTableViewBlock;
@synthesize canEditRowAtIndexPathBlock = _canEditRowAtIndexPathBlock;
@synthesize canMoveRowAtIndexPathBlock = _canMoveRowAtIndexPathBlock;
@synthesize cellForRowAtIndexPathBlock = _cellForRowAtIndexPathBlock;
@synthesize commitEditingStyleBlock = _commitEditingStyleBlock;
@synthesize moveRowAtIndexPathBlock = _moveRowAtIndexPathBlock;
@synthesize numberOfRowsInSectionBlock = _numberOfRowsInSectionBlock;
@synthesize sectionForSectionIndexTitleBlock = _sectionForSectionIndexTitleBlock;
@synthesize titleForFooterInSectionBlock = _titleForFooterInSectionBlock;
@synthesize titleForHeaderInSectionBlock = _titleForHeaderInSectionBlock;

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView  {
    UITableViewNumberOfSectionsInTableViewBlock block = [self.numberOfSectionsInTableViewBlock copy];
    NSInteger result = block(tableView);
//    [block release];
    return result;
}

-(NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView  {
    UITableViewSectionIndexTitlesForTableViewBlock block = [self.sectionIndexTitlesForTableViewBlock copy];
    NSArray* result = block(tableView);
//    [block release];
    return result;
}

-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath  {
    UITableViewCanEditRowAtIndexPathBlock block = [self.canEditRowAtIndexPathBlock copy];
    BOOL result = block(tableView, indexPath);
//    [block release];
    return result;
}

-(BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath  {
    UITableViewCanMoveRowAtIndexPathBlock block = [self.canMoveRowAtIndexPathBlock copy];
    BOOL result = block(tableView, indexPath);
//    [block release];
    return result;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath  {
    UITableViewCellForRowAtIndexPathBlock block = [self.cellForRowAtIndexPathBlock copy];
    UITableViewCell* result = block(tableView, indexPath);
//    [block release];
    return result;
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath  {
    UITableViewCommitEditingStyleBlock block = [self.commitEditingStyleBlock copy];
    block(tableView, editingStyle, indexPath);
//    [block release];
}

-(void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath  {
    UITableViewMoveRowAtIndexPathBlock block = [self.moveRowAtIndexPathBlock copy];
    block(tableView, fromIndexPath, toIndexPath);
//    [block release];
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section  {
    UITableViewNumberOfRowsInSectionBlock block = [self.numberOfRowsInSectionBlock copy];
    NSInteger result = block(tableView, section);
//    [block release];
    return result;
}

-(NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index  {
    UITableViewSectionForSectionIndexTitleBlock block = [self.sectionForSectionIndexTitleBlock copy];
    NSInteger result = block(tableView, title, index);
//    [block release];
    return result;
}

-(NSString*)tableView:(UITableView*)tableView titleForFooterInSection:(NSInteger)section  {
    UITableViewTitleForFooterInSectionBlock block = [self.titleForFooterInSectionBlock copy];
    NSString* result = block(tableView, section);
//    [block release];
    return result;
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section  {
    UITableViewTitleForHeaderInSectionBlock block = [self.titleForHeaderInSectionBlock copy];
    NSString* result = block(tableView, section);
//    [block release];
    return result;
}

@end

