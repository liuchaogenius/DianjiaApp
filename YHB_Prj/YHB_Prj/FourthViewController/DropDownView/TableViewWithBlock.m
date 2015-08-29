//
//  TableViewWithBlock.m
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import "TableViewWithBlock.h"
#import "UITableView+DataSourceBlocks.h"
#import "UITableView+DelegateBlocks.h"

@implementation TableViewWithBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock{
   
    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.numberOfRowsInSectionBlock=numOfRowsBlock;
    self.cellForRowAtIndexPath=cellForIndexPathBlock;
    self.didDeselectRowAtIndexPathBlock=didSelectRowBlock;
    self.dataSource=self;
    self.delegate=self;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellForRowAtIndexPath(tableView,indexPath);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRowsInSectionBlock(tableView,section);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.didDeselectRowAtIndexPathBlock(tableView,indexPath);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
//        NSLog(@"%@", NSStringFromCGRect(cell.frame));
        return cell.frame.size.height;
    }
    return 0;
}
@end
