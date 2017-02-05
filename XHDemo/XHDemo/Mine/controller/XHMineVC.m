//
//  XHMineVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMineVC.h"

@interface XHMineVC ()

@end

@implementation XHMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LXHLog(@"%s", __func__);
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
//    UIApplication *app = [UIApplication sharedApplication];
//    app.statusBarStyle = UIStatusBarStyleLightContent;
//    app.statusBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

@end
