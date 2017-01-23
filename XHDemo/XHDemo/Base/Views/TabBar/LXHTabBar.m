//
//  LXHTabBar.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/18.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHTabBar.h"

@interface LXHTabBar ()

/** 当前被选中的TabBar */
@property (nonatomic , weak)UITabBar *currentSelectTabBar;
/** 顶部的线条 */
@property (nonatomic , weak)UIView *headView;

@end
@implementation LXHTabBar

- (UIView *)headView{
    
    if (_headView == nil) {
        UIView *headView = [[UIView alloc] init];
        headView.backgroundColor = RGBA(221, 221, 221, 1.0);
        [self addSubview:headView];
        
        _headView = headView;
    }
    return _headView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
        
    CGFloat barW = 1.0 * self.bounds.size.width / self.items.count;
    CGFloat barX = 0;
    CGFloat barY = 0;
    CGFloat barH = self.bounds.size.height;
    int count = 0;
    for (UIControl *tabBar in self.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置第一个为选中
            if (count == 0 && self.currentSelectTabBar == nil) {
                self.currentSelectTabBar = (UITabBar *)tabBar;
            }

            barX = count * barW;
            tabBar.frame = CGRectMake( barX, barY, barW, barH);

            count++;
            
            //添加选中监听，用于点击刷新界面数据
            [tabBar addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    self.headView.frame = CGRectMake(0, 0, SCR_WIDTH, 1);
}

- (void)tabBarClick:(UITabBar *)tabBar
{
    if (tabBar == self.currentSelectTabBar){
        //发出通知，用于控制点击刷新界面
        [[NSNotificationCenter defaultCenter] postNotificationName:TabbarClick object:self];
    };
    
    self.currentSelectTabBar = tabBar;
}

@end
