//
//  LXHNavigationController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/18.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHNavigationController.h"


@interface LXHNavigationController ()<UIGestureRecognizerDelegate>

/** 全屏返回手势 */
@property (strong, nonatomic) UIPanGestureRecognizer *panHandleNavigationTransition;

@end

@implementation LXHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏navigationbarBackgroundWhite
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar *item = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [item setTitleTextAttributes:dict];
    
    self.isUsingHandleNavigationTransition = YES;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    //添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    #pragma clang diagnostic pop
    
    pan.delegate=self;
    [self.view addGestureRecognizer:pan];
    
    UIImageView *moxuyou = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    moxuyou.image = [UIImage imageNamed:@"moxuyou"];
    self.navigationItem.titleView = moxuyou;
    
    self.navigationBar.hidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断是否是根控制器
    if (self.childViewControllers.count > 0) {
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        [btn sizeToFit];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [viewController.navigationItem.leftBarButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
       return self.childViewControllers.count > 1 && self.isUsingHandleNavigationTransition;
}

@end
