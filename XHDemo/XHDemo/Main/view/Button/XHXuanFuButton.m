//
//  XHXuanFuButton.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHXuanFuButton.h"

@implementation XHXuanFuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"share_qq"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"share_weibo"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateHighlighted];
        
        self.dragEnable = YES;
        self.adsorbEnable = YES;
        
        [self addTarget:self action:@selector(xuanFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)xuanFuButtonClick{
    
    LXHLog(@"%s", __func__);
}

@end
