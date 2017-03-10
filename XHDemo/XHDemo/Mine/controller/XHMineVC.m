//
//  XHMineVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMineVC.h"
#import "XHImageLocationVC.h"

@interface XHMineVC ()
/**点击按钮跳转 */
@property(weak, nonatomic) UIButton *turnBtn;
@end

@implementation XHMineVC

- (UIButton *)turnBtn{
    if (_turnBtn == nil) {
        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
        [imageBtn setTitle:@"点击跳转图片浏览器" forState:UIControlStateNormal];
        [imageBtn sizeToFit];
        [imageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:imageBtn];
        _turnBtn = imageBtn;
    }
    return _turnBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    LXHLog(@"%s", __func__);
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self turnBtn];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)imageBtnClick{

    
//    [self.turnBtn setTitle:[self isOuShu:20] forState:UIControlStateNormal];
    XHImageLocationVC *vc = [[XHImageLocationVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
