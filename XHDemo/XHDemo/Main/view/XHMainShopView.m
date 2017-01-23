//
//  XHMainShopView.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMainShopView.h"
#import "XHMainShopViewCell.h"
#import "XHADView.h"
#import "RefreshTableView.h"

static NSString *cellId = @"XHMainShopViewCell";
static CGFloat headViewHeight = 150.0;
@interface XHMainShopView ()<UITableViewDelegate,UITableViewDataSource,RefreshTableViewDelegate>

/** tableView */
@property (weak, nonatomic)RefreshTableView *tableView;
/** 广告View */
@property (weak, nonatomic)XHADView *adView;
/** 广告数据 */
@property (strong, nonatomic) NSArray *adDataArray;
/** tableView设计及源 */
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation XHMainShopView

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSArray *)adDataArray{
    
    if (_adDataArray == nil) {
        
        NSDictionary *dict1 = @{
                                @"jumpUrl" : @"http://www.baidu.com",
                                @"mobileTitle" : @"测试标题1",
                                @"pictureUrl" : @"http://upload.jianshu.io/admin_banners/web_images/2295/dcc46ceef44b1df38b934c68043e43b1dd7d6f4d.jpg",
                                @"title" : @"测试标题1",
                                };
        NSDictionary *dict2 = @{
                                @"jumpUrl" : @"http://www.baidu.com",
                                @"mobileTitle" : @"测试标题2",
                                @"pictureUrl" : @"http://upload.jianshu.io/admin_banners/web_images/2722/5c66048b39090e1ca0fdf6e000c33e6e4eecc554.png",
                                @"title" : @"测试标题2",
                                };
        NSDictionary *dict3 = @{
                                @"jumpUrl" : @"http://www.baidu.com",
                                @"mobileTitle" : @"测试标题3",
                                @"pictureUrl" : @"http://upload.jianshu.io/admin_banners/web_images/2724/d4e7cc87771ce13cc7be8b5b4b9278455e8d5a2f.jpg",
                                @"title" : @"测试标题3",
                                };
        
        _adDataArray = @[dict1, dict2, dict3];
    }
    return _adDataArray;
}

- (XHADView *)adView{
    
    if (_adView == nil) {
        
        XHADView *adView = [[XHADView alloc] initWithFrame:CGRectMake(0, 0, self.LXHWidth, headViewHeight)];
        adView.images = self.adDataArray;
        
        _adView = adView;
    }
    return _adView;
}

- (RefreshTableView *)tableView{
    
    if (_tableView == nil) {
        
        RefreshTableView *tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - tabBarHeigth) style:UITableViewStylePlain];
        //修改tableView的contentInset
        tableView.contentInset = UIEdgeInsetsMake(navigationBarHeigth, 0, 0, 0);
        //修改tableView进度条的contentInset
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(navigationBarHeigth, 0, 0, 0);
        tableView.dataSource = self;
        tableView.delegate = self;
        //添加刷新
        [tableView setupRefresh];
        tableView.refreshDelegate = self;
        //将底部的控件移除
        tableView.tableFooterView = [[UIView alloc] init];
        
        [tableView registerNib:[UINib nibWithNibName:@"XHMainShopViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        [self addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - 初始化
- (void)setUp{
    
    self.tableView.tableHeaderView = self.adView;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHMainShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [NSString stringWithFormat:@"Moxuyou--%@", self.dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark - 代理
- (void)tableView:(RefreshTableView*)tableView didListViewRefreshOrLoadMoreData:(BOOL)isRefresh{
    
    NSInteger count = self.dataArray.count;
    for (NSInteger i = count; i < count + 5; i++) {
        
        [self.dataArray addObject:[NSString stringWithFormat:@"%lu", i]];
        
    }
    [self.tableView reloadData];
    [self.tableView stopRefresh];
}
// 默认状态只有是delete的时候可以左划出现删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
