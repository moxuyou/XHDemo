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
@property (nonatomic, weak)XHTansformView *redView;

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

- (XHTansformView *)redView{
    
    if (_redView == nil) {
        
        XHTansformView *view = [[XHTansformView alloc] initWithFrame:self.bgView.bounds];
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
                //[view addSubview:lable];
            }
        }
        
        //UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        //pan.delegate = self;
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        pinch.delegate = self;
        [view addGestureRecognizer:pinch];
        //[view addGestureRecognizer:pan];
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
   // CGPoint point = [panGes translationInView:panGes.view];
    //self.redView.frame = CGRectMake(self.redView.LXHX + point.x, self.redView.LXHY + point.y, self.redView.LXHWidth, self.redView.LXHHeight);
    
}

- (void)pinch:(UIPinchGestureRecognizer *)pinchGes{
    
//    NSLog(@"%s", __func__);
    self.redView.transform = CGAffineTransformScale(self.redView.transform, pinchGes.scale, pinchGes.scale);
    //self.redView.transform = CGAffineTransformIdentity;
    //self.redView.transform = CGAffineTransformScale(self.redView.transform, 1, 1);
    //pinchGes.scale=1.0;
    [pinchGes setScale:1.0];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}

@end
