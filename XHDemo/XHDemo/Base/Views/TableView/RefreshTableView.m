//
//  RefreshTableView.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "RefreshTableView.h"
#import "MJRefresh.h"
#import "PreciousMetalCustomHeader.h"
#import "MJRefreshBackStateFooter.h"

@interface RefreshTableView()

@property(nonatomic,assign) BOOL isRefresh;
@property(nonatomic,assign) BOOL isLoadMore;

@end

@implementation RefreshTableView

#pragma mark - Public

- (void)setupRefreshHeader
{
    __weak __typeof(self) weakSelf = self;
    self.mj_header = [PreciousMetalCustomHeader headerWithRefreshingBlock:^{
        [weakSelf headerRereshing];
    }];

    // 马上进入刷新状态
    [self.mj_header beginRefreshing];
}

- (void)setupRefresh
{
    __weak __typeof(self) weakSelf = self;
    self.mj_header = [PreciousMetalCustomHeader headerWithRefreshingBlock:^{
        [weakSelf headerRereshing];
    }];
    
    // 马上进入刷新状态
    [self.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [weakSelf footerRereshing];
    }];
}


- (void)reloadTableViewData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
           [self reloadData];
           [self.mj_header endRefreshing];
           [self.mj_footer endRefreshing];

        });
        
    });
}

- (void)stopRefresh
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mj_header endRefreshing];
            [self.mj_footer endRefreshing];
        });
        
    });
}

#pragma mark -

- (void)headerRereshing
{
    self.isRefresh = YES;
    self.isLoadMore = NO;
    
    if (self.refreshDelegate != nil && [self.refreshDelegate respondsToSelector:@selector(tableView:didListViewRefreshOrLoadMoreData:)]) {
        [self.refreshDelegate tableView:self didListViewRefreshOrLoadMoreData:self.isRefresh];
    }
}

- (void)footerRereshing
{
    self.isRefresh = NO;
    self.isLoadMore = YES;
    
    if (self.refreshDelegate != nil && [self.refreshDelegate respondsToSelector:@selector(tableView:didListViewRefreshOrLoadMoreData:)]) {
        [self.refreshDelegate tableView:self didListViewRefreshOrLoadMoreData:self.isRefresh];
    }
}


@end
