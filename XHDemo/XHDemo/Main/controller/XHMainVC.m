//
//  XHMainVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMainVC.h"
#import "XHMainCell.h"
#import "XHXuanFuButton.h"
#import "XHMainShopView.h"
//#import <AliHotFixDebug/AliHotFixDebug.h>

static NSString *cellId = @"XHMainVCCell";
@interface XHMainVC ()<UITableViewDelegate,UITableViewDataSource>

/** navigationBar中间的View */
@property (weak, nonatomic)UISegmentedControl *segment;
/** 列表tableView */
@property (weak, nonatomic)UITableView *tableView;
/** 商品视图 */
@property (weak, nonatomic)XHMainShopView *shopView;
/** 导航栏背景的透明View */
@property (weak, nonatomic)UIView *navigationBgView;
/** 悬浮按钮 */
@property (weak, nonatomic)XHXuanFuButton *xuanFuButton;

@end

@implementation XHMainVC

#pragma mark - 懒加载

//悬浮按钮
- (XHXuanFuButton *)xuanFuButton{
    
    if (_xuanFuButton == nil) {
        
        XHXuanFuButton *xuanFuButton = [[XHXuanFuButton alloc] initWithFrame:CGRectMake(0, 100, 60, 60)];
        [[UIApplication sharedApplication].keyWindow addSubview:xuanFuButton];
        [xuanFuButton addTarget:self action:@selector(xuanFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _xuanFuButton = xuanFuButton;
    }
    return _xuanFuButton;
}

//导航栏动态变化颜色的视图
- (UIView *)navigationBgView{
    
    if (_navigationBgView == nil) {
        UIView *navigationBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCR_WIDTH, navigationBarHeigth)];
        
        navigationBgView.backgroundColor = [UIColor colorWithRed:253.0 / 255.0 green:128.0 / 255.0 blue:35.0 / 255.0 alpha:1.0];
        [self.navigationController.navigationBar insertSubview:navigationBgView atIndex:0];
        navigationBgView.alpha = 0;
        
        _navigationBgView = navigationBgView;
    }
    
    return _navigationBgView;
}

//商品视图
- (XHMainShopView *)shopView{
    
    if (_shopView == nil) {
        XHMainShopView *shopView = [[XHMainShopView alloc] initWithFrame:self.tableView.frame];
        
        shopView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:shopView];
        _shopView = shopView;
    }
    return _shopView;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - tabBarHeigth) style:UITableViewStylePlain];
        //修改tableView的contentInset
        tableView.contentInset = UIEdgeInsetsMake(navigationBarHeigth, 0, 0, 0);
        //修改tableView进度条的contentInset
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(navigationBarHeigth, 0, 0, 0);
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerNib:[UINib nibWithNibName:@"XHMainCell" bundle:nil] forCellReuseIdentifier:cellId];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化导航栏
    [self setUpNavigationBar];
    
    //创建tableView
    [self tableView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.xuanFuButton.hidden = NO;
    
    if (self.segment.selectedSegmentIndex == 0) {//主页
        
        [self scrollViewDidScroll:self.tableView];
    }else if (self.segment.selectedSegmentIndex == 1){//商品
        
        self.navigationBgView.alpha = 1.0;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.xuanFuButton.hidden = YES;
}

#pragma mark - 初始化

- (void)setUpNavigationBar{
    
    //屏蔽父类的自定义导航栏，采用系统的
    self.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    
    //添加中间的segment
    UISegmentedControl *midSegment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 130, 25)];
    [midSegment addTarget:self action:@selector(midSegmentChange) forControlEvents:UIControlEventValueChanged];
    [midSegment insertSegmentWithTitle:@"主页" atIndex:0 animated:NO];
    [midSegment insertSegmentWithTitle:@"广告商品" atIndex:1 animated:NO];
    midSegment.tintColor = [UIColor purpleColor];
//    [UIColor colorWithRed:253.0 / 255.0 green:128.0 / 255.0 blue:35.0 / 255.0 alpha:1.0];
    [midSegment setSelectedSegmentIndex:0];
    self.segment = midSegment;
    self.navigationItem.titleView = midSegment;
    
    //设置导航栏的背景颜色
    [self navigationBgView];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:1.0 alpha:0.5];
    UINavigationBar *naviBar = self.navigationController.navigationBar;
    UIView *bgView = [naviBar valueForKey:@"_barBackgroundView"];
    bgView.alpha = 0;

    [self.navigationController setAutomaticallyAdjustsScrollViewInsets:NO];
    
}
#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [NSString stringWithFormat:@"Moxuyou--%@", [NSString stringWithFormat:@"%i", (int)indexPath.row]];
    
    return cell;
}

#pragma mark - 代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

// 给cell添加核心动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //定义标示是为了不重复添加
    [cell.layer removeAnimationForKey:@"cellAnima"];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    anim.values = @[@-2,@-1,@0,@1,@2];
    anim.duration = 0.5;
    
    [cell.layer addAnimation:anim forKey:@"cellAnima"];
}

// 监听滚动修改导航栏的颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 0) {
        self.navigationBgView.alpha = 1.0;
    }else{
        self.navigationBgView.alpha = (navigationBarHeigth - fabs(scrollView.contentOffset.y)) / navigationBarHeigth;
    }
    
}

//开始滚动的时候给tabbar添加下移动画
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, tabBarHeigth);
    }];
}

/*
 UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
 UIViewAnimationOptionRepeat                    //无限重复执行动画
 UIViewAnimationOptionAutoreverse               //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
 UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
 UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
 UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置
 
 UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
 UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
 UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
 UIViewAnimationOptionCurveLinear               //时间曲线，匀速
 
 UIViewAnimationOptionTransitionNone            //转场，不使用动画
 UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
 UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
 UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
 UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
 UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
 UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
 UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页
 */
//tabbar恢复原来的状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
    } completion:nil];
}

#pragma mark - 通知

#pragma mark - Action

//segment值改变
- (void)midSegmentChange{
    
    LXHLog(@"%s", __func__);
    if (self.segment.selectedSegmentIndex == 0) {//主页
        
        [self scrollViewDidScroll:self.tableView];
        [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
        [self.view bringSubviewToFront:self.tableView];
    }else if (self.segment.selectedSegmentIndex == 1){//商品
        
        self.navigationBgView.alpha = 1.0;
        [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
        [self.view bringSubviewToFront:self.shopView];
    }
}

//segment转场动画
- (void) animationWithView:(UIView *)view WithAnimationTransition:(UIViewAnimationTransition) transition{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
        
    }];
}

- (void)xuanFuButtonClick{
    
    NSLog(@"%s", __func__);
//   [AliHotFixDebug showDebug:self];
    NSString* string = @"2017-04-29 01:12:30";
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    inputFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [inputFormatter setTimeStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的时间格式
    [inputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSDate *newdate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];// HH:mm:ss
    NSString *strDate = [dateFormatter stringFromDate:newdate];
    NSLog(@"%@", strDate);
}

#pragma mark - 网络请求


@end
