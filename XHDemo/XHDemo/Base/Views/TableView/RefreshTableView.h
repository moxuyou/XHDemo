//
//  RefreshTableView.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshTableViewDelegate;

@interface RefreshTableView : UITableView

@property(nonatomic,weak) id<RefreshTableViewDelegate> refreshDelegate;

/** 单纯头部刷新 */
- (void)setupRefreshHeader;
/** 头部尾部都可以刷新 */
- (void)setupRefresh;
/** 更新tableView数据 */
- (void)reloadTableViewData;
/** 停止刷新刷新 */
- (void)stopRefresh;

@end

@protocol RefreshTableViewDelegate <NSObject>

@optional

- (void)tableView:(RefreshTableView*)tableView didListViewRefreshOrLoadMoreData:(BOOL)isRefresh;

@end
