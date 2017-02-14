//
//  LXHTabBarController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHTabBarController.h"
#import "XHMainVC.h"
#import "XHFeatruedVC.h"
#import "XHMineVC.h"
#import "XHSearchVC.h"
#import "UIImage+LXH.h"
#import "LXHTabBar.h"
#import "LXHNavigationController.h"

@interface LXHTabBarController ()

@end

@implementation LXHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控制器
    [self setUpChildViewController];
    
    //设置tabBarItem属性
    [self setUpTabBarItem];
    
    //设置tabbar
    LXHTabBar *tabBar = [[LXHTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
}

#pragma mark - 设置子控制器
- (void)setUpChildViewController
{
    //首页
    XHMainVC *mainVc = [[XHMainVC alloc] init];
    LXHNavigationController *mainNav = [[LXHNavigationController alloc] initWithRootViewController:mainVc];
    [self addChildViewController:mainNav];
    
    //搜索
    XHSearchVC *searchVc = [[XHSearchVC alloc] init];
    LXHNavigationController *searchNav = [[LXHNavigationController alloc] initWithRootViewController:searchVc];
    [self addChildViewController:searchNav];
    
    //零碎
    XHFeatruedVC *featruedVc = [[XHFeatruedVC alloc] init];
    LXHNavigationController *featruedNav = [[LXHNavigationController alloc] initWithRootViewController:featruedVc];
    [self addChildViewController:featruedNav];
    
    //我
    XHMineVC *mineVc = [[XHMineVC alloc] init];
    LXHNavigationController *mineNav = [[LXHNavigationController alloc] initWithRootViewController:mineVc];
    [self addChildViewController:mineNav];
    
}

#pragma mark -设置tabBarItem属性
- (void)setUpTabBarItem
{
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    //首页
    LXHNavigationController *mainNav = self.childViewControllers[0];
    mainNav.tabBarItem.title = @"首页";
    mainNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_essence_icon"];
    mainNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_essence_click_icon"];
    
    //搜索
    LXHNavigationController *discoverNav = self.childViewControllers[1];
    discoverNav.tabBarItem.title = @"编辑";
    discoverNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_new_icon"];
    discoverNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_new_click_icon"];
    
    //零碎
    LXHNavigationController *choosedNav = self.childViewControllers[2];
    choosedNav.tabBarItem.title = @"零碎";
    choosedNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_me_icon"];
    choosedNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_me_click_icon"];
    
    //我
    LXHNavigationController *mineNav = self.childViewControllers[3];
    mineNav.tabBarItem.title = @"我";
    mineNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_friendTrends_icon"];
    mineNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_friendTrends_click_icon"];
    
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    LXHLog(@"%@----%@", tabBar, item);
}

@end
