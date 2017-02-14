//
//  XHMusicPlayVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/14.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMusicPlayVC.h"
#import "XHMusicPlayTitleView.h"
#import "XHMusicPlayMiddleView.h"

@interface XHMusicPlayVC ()

/** 毛玻璃背景图片 */
@property (weak, nonatomic)UIImageView *bgImageView;
/** 标题View */
@property (weak, nonatomic)XHMusicPlayTitleView *titleView;
/** 中间视图 */
@property (weak, nonatomic)XHMusicPlayMiddleView *middleView;

@end

@implementation XHMusicPlayVC

#pragma mark - 懒加载
- (UIImageView *)bgImageView{
    
    if (_bgImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        //添加毛玻璃效果
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = imageView.bounds;
        [imageView addSubview:effectView];
        [self.view addSubview:imageView];
        
        _bgImageView = imageView;
    }
    
    return _bgImageView;
}

- (XHMusicPlayTitleView *)titleView{
    
    if (_titleView == nil) {
        
        XHMusicPlayTitleView *view = [[XHMusicPlayTitleView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 80)];
        
        [self.view addSubview:view];
        
        _titleView = view;
    }
    return _titleView;
}

- (XHMusicPlayMiddleView *)middleView{
    
    if (_middleView == nil) {
        
        XHMusicPlayMiddleView *view = [XHMusicPlayMiddleView musicPlayMiddleView];
        
        [self.view addSubview:view];
        _middleView = view;
    }
    return _middleView;
}

#pragma mark - 系统方法
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self suUpSubView];
}

#pragma mark - 初始化
- (void)suUpSubView{
    
    
}

#pragma mark - 数据源

#pragma mark - 代理

#pragma mark - 通知

#pragma mark - Action
- (void)setModel:(XHMusicModel *)model{
    
    _model = model;
    self.bgImageView.image = [UIImage imageNamed:model.icon];
    self.titleView.titleLabel.text = model.name;
    self.titleView.titleDetailLabel.text = model.singer;
}

#pragma mark - 网络请求

@end
