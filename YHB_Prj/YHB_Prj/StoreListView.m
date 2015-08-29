//
//  StoreListView.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "StoreListView.h"
#import "LoginMode.h"
#import "LoginManager.h"

@interface StoreListView()
@property (nonatomic, strong) NSMutableArray *storelist;
@property (nonatomic, copy) void(^storeListDidSelectBlock)(StoreMode *aMode);
@end
@implementation StoreListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)didSelectStoreMode:(void(^)(StoreMode *aMode))aBlock
{
    self.storeListDidSelectBlock = aBlock;
}

- (void)setStoreList:(NSArray *)aStoreList
{
    if(aStoreList)
    {
        UITableView *tableview = [[UITableView alloc] initWithFrame:self.bounds];
        tableview.dataSource = self;
        tableview.delegate = self;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.storelist = [NSMutableArray arrayWithArray:aStoreList];
        [self addSubview:tableview];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storelist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storeListCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    StoreMode *sm = [self.storelist objectAtIndex:indexPath.row];
    cell.textLabel.text = sm.strStoreName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreMode *sm = [self.storelist objectAtIndex:indexPath.row];
    [[LoginManager shareLoginManager] setCurrentSelectStore:sm];
    [[LoginManager shareLoginManager] setNetWorkStoreId:sm.strId];
    if(self.storeListDidSelectBlock)
    {
        self.storeListDidSelectBlock(sm);
    }
}

@end
