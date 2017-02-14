//
//  XHImageLocationVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/12.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHImageLocationVC.h"
#import "XHTansformView.h"
@interface XHImageLocationVC ()<UIGestureRecognizerDelegate>

/**  */
@property (nonatomic, weak)UIView *bgView;
@property (nonatomic, weak)UIView *redView;

@end

@implementation XHImageLocationVC

- (UIView *)bgView{
    
    if (_bgView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        view.backgroundColor = [UIColor blueColor];
        view.center = self.view.center;
        [self.view addSubview:view];
        _bgView = view;
    }
    return _bgView;
}

- (UIView *)redView{
    
    if (_redView == nil) {
        
        UIView *view = [[UIView alloc] initWithFrame:self.bgView.bounds];
        view.backgroundColor = [UIColor redColor];
        
        CGFloat space = 3.0;
        CGFloat w = self.bgView.LXHWidth / 20 - space;
        CGFloat h = self.bgView.LXHHeight / 20 - space;
        
        for (int i = 0; i < 20; i++) {
            for (int j = 0; j < 20; j ++) {
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake((w + space) * j, (h + space) * i, w, h)];
                lable.text = [NSString stringWithFormat:@"%i--%i", i, j];
                lable.textColor = [UIColor whiteColor];
                lable.font = [UIFont systemFontOfSize:10.0];
                lable.backgroundColor = [UIColor whiteColor];
                [view addSubview:lable];
            }
        }
        
        UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        pinch.delegate = self;
        [view addGestureRecognizer:pinch];
        [view addGestureRecognizer:pan];
        [self.bgView addSubview:view];
        _redView = view;
    }
    return _redView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpXHImageLocationVC];
    
    [self redView];
}

- (void)setUpXHImageLocationVC{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)pan:(UIPanGestureRecognizer *)panGes{
    
//    NSLog(@"%s", __func__);
    
    CGPoint point2 = [panGes velocityInView:panGes.view];
    CGPoint point = [panGes translationInView:panGes.view];
//    point = CGPointMake(point.x - point2.x, point.y - point2.y);
    
    NSLog(@"%@", self.redView);
//    CGRect rect = CGRectMake(self.redView.frame.origin.x + point.x, self.redView.frame.origin.y + point.y, self.redView.LXHWidth, self.redView.LXHHeight);
//    self.redView.frame = rect;
    if (panGes.view.frame.origin.y >= self.bgView.LXHHeight * 0.5 && point.y >= 0) {
        
        point = CGPointMake(point.x, 0);
    }
    if (panGes.view.frame.origin.y <= -(self.bgView.LXHHeight * 0.5) && point.y <= 0) {
        
        point = CGPointMake(point.x, 0);
    }
    if (panGes.view.frame.origin.x <= -self.bgView.LXHWidth * 0.5 && point.x <= 0) {
        
        point = CGPointMake(0, point.y);
    }
    if (panGes.view.frame.origin.x >= self.bgView.LXHWidth * 0.5 && point.x >= 0) {
        
        point = CGPointMake(0, point.y);
    }
    
    panGes.view.center = CGPointMake(panGes.view.center.x + point.x , panGes.view.center.y + point.y);
    //每次移动完，将移动量置为0，否则下次移动会加上这次移动量
    [panGes setTranslation:CGPointMake(0, 0) inView:self.view];
//    self.redView.transform = CGAffineTransformTranslate(self.redView.transform, point.x, point.y);
//    self.redView.transform = CGAffineTransformIdentity;

    if (panGes.state == UIGestureRecognizerStateEnded) {
        if (panGes.view.frame.origin.y >= self.bgView.LXHHeight * 0.5) {
            
            panGes.view.frame = CGRectMake(panGes.view.LXHX, panGes.view.LXHHeight * 0.5, panGes.view.LXHWidth, panGes.view.LXHHeight);
        }
        if (panGes.view.frame.origin.y <= -(panGes.view.LXHHeight * 0.5)) {
            
            panGes.view.frame = CGRectMake(panGes.view.LXHX, -panGes.view.LXHHeight * 0.5, panGes.view.LXHWidth, panGes.view.LXHHeight);
        }
        if (panGes.view.frame.origin.x <= -self.bgView.LXHWidth * 0.5) {
            
            panGes.view.frame = CGRectMake(-self.bgView.LXHWidth * 0.5, panGes.view.LXHY, panGes.view.LXHWidth, panGes.view.LXHHeight);
        }
        if (panGes.view.frame.origin.x >= self.bgView.LXHWidth * 0.5) {
            
            panGes.view.frame = CGRectMake(self.bgView.LXHWidth * 0.5, panGes.view.LXHY, panGes.view.LXHWidth, panGes.view.LXHHeight);
        }
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)pinchGes{
    
//    NSLog(@"%s", __func__);
//    NSLog(@"%@", NSStringFromCGAffineTransform(self.redView.transform));
    if (pinchGes.state == UIGestureRecognizerStateEnded) {
        
        if (self.redView.transform.a < 1.0) {
            
            self.redView.transform = CGAffineTransformIdentity;
            return;
        }
    }
    
    NSLog(@"%@", self.redView);
    self.redView.transform = CGAffineTransformScale(self.redView.transform, pinchGes.scale, pinchGes.scale);
    //self.redView.transform = CGAffineTransformIdentity;
    //self.redView.transform = CGAffineTransformScale(self.redView.transform, 1, 1);
    //pinchGes.scale=1.0;
    [pinchGes setScale:1.0];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
