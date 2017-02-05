//
//  XHViewAnimaA.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/4.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHViewAnimaA.h"

@interface XHViewAnimaA ()

/**  */
@property (weak, nonatomic)UIView *redView;

@end

@implementation XHViewAnimaA


- (UIView *)redView{
    
    if (_redView == nil) {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
        redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:redView];
        
        redView.layer.shadowRadius = 5.0;
        redView.layer.shadowOpacity = 0.5;
        redView.layer.shadowColor = [UIColor blackColor].CGColor;
        redView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        
        //        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        //        blueView.backgroundColor = [UIColor blueColor];
        //        [self.view addSubview:blueView];
        //        redView.layer.anchorPoint = CGPointMake(0, 0);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redViewBetouch:)];
        [redView addGestureRecognizer:tap];
        
        _redView = redView;
    }
    return _redView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self redView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *tuch = touches.anyObject;
    CGPoint point = [tuch locationInView:self.view];
    
    [UIView beginAnimations:@"testAnimation" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    //设置动画将开始时代理对象执行的SEL
    [UIView setAnimationWillStartSelector:@selector(animationDoing)];
    
    //设置动画延迟执行的时间
    [UIView setAnimationDelay:0];
    
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //设置动画是否继续执行相反的动画
    [UIView setAnimationRepeatAutoreverses:YES];
    self.redView.center = point;
    self.redView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.redView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView commitAnimations];
}

- (void)redViewBetouch:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%s", __func__);
    
    CGPoint point = [tap locationInView:tap.view];
    point = [tap.view convertPoint:point toView:[UIApplication sharedApplication].keyWindow];
    
    NSLog(@"%@", NSStringFromCGPoint(point));
    
}

- (void)animationDoing{
    
    NSLog(@"%s", __func__);
    
}

- (void)startAnimation{
    
    NSLog(@"%s", __func__);
    
}


- (void)stopAnimation{
    
    NSLog(@"%s", __func__);
    
}

@end
