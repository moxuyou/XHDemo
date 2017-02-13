//
//  XHTansformView.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/13.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHTansformView.h"

@implementation XHTansformView

//让控件能够随便移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint previousP = [touch previousLocationInView:self];
    CGPoint currentP = [touch locationInView:self];
    CGFloat offsetX = currentP.x - previousP.x;
    CGFloat offsetY = currentP.y - previousP.y;
    //控件的形变,是以CGAFFineTransform开头的方法,而layer的形变的以CATransform开头的
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    NSLog(@"%s", __func__);
    
}

@end
