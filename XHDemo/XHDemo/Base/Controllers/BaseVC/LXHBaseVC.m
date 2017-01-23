//
//  LXHBaseVC.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//
#import "LXHBaseVC.h"
#import "LXHNavigationBar+LXHDefault.h"
#import "UMMobClick/MobClick.h"

@interface LXHBaseVC ()

@end

@implementation LXHBaseVC

#pragma mark -系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = BG_COLOR;
    [self createCustomNavigationBar];
    //    [self registerForKVO];
    
    //右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    
    //禁止系统默认布局
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //友盟统计
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //友盟统计
    [MobClick endLogPageView:NSStringFromClass([self class])];

}

#pragma mark -初始化
// 创建自定义导航栏
- (void)createCustomNavigationBar
{
    if (self.navigationBar == nil) {
        float width = [UIScreen mainScreen].bounds.size.width;
        CGRect rect = CGRectMake(0.0f, 0.0f,width, navigationBarHeigth);
        LXHNavigationBar *navigationBar = [[LXHNavigationBar alloc] initWithFrame:rect];
        self.navigationBar = navigationBar;
        self.navigationBar.delegate = self;
        [self.view addSubview:self.navigationBar];
        
    }
}


// 设置默认导航条为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

//设置中间的标题
- (void)setTitle:(NSString *)title
{
    [self.navigationBar setBackBtnWithTitle:title];
}

#pragma mark -Action
// 导航栏左边按钮被点击
- (void)clickCustomNavigationBarLeftButtonEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
