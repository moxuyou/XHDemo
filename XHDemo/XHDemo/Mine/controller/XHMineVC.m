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
    if (!_turnBtn) {
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
    
//    UIApplication *app = [UIApplication sharedApplication];
//    app.statusBarStyle = UIStatusBarStyleLightContent;
//    app.statusBarHidden = NO;
    [self turnBtn];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)imageBtnClick{
    
    NSLog(@"%s", __func__);
    XHImageLocationVC *vc = [[XHImageLocationVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//我手机上,按钮点击没有反应,所以我只能通过该方法来跳转界面
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    XHImageLocationVC *vc = [[XHImageLocationVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
