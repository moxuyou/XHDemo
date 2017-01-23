//
//  XHEdictHeadView.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/23.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHEdictHeadView.h"

@implementation XHEdictHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.backgroundColor = [UIColor orangeColor];
    [self addSubview:label];
    self.headLabel = label;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.headLabel.frame = self.bounds;
}

@end
