//
//  XHQQButton.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHQQButton.h"

static CGFloat maxLenght = 80.0;
@interface XHQQButton ()

/** 注释 */
@property (nonatomic, weak) UIView *smallCircle;

/** 注释 */
@property (nonatomic, weak) CAShapeLayer *shapL;

@end
@implementation XHQQButton


-(CAShapeLayer *)shapL {
    
    if (_shapL == nil) {
        
        CAShapeLayer *shapL = [CAShapeLayer layer];
        [self.superview.layer insertSublayer:shapL atIndex:0];
        shapL.fillColor = [UIColor redColor].CGColor;
        _shapL = shapL;
    }
    return _shapL;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setUp];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                view.hidden = YES;
            }
        }
        
        UITableViewCell *cell = (UITableViewCell *)self.superview.superview;
        UIView *view = self.superview.superview.superview;
        self.pandingBlock(view,cell);
    }
    //拖动
    CGPoint transP = [pan translationInView:self];
    
    //transform,transform并没有修改center.它修改的是frame
    
    //self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    
    
    //LXHLog(@"%@",NSStringFromCGPoint(self.center));
    
    //复位
    [pan setTranslation:CGPointZero inView:self];
    
    CGFloat distance = [self distanceWithSmallCircle:self.smallCircle BigCirCle:self];
    
    //让小圆半径根据距离的增大,半径在减小
    CGFloat smallR = self.bounds.size.width * 0.5;
    smallR -= distance / 10.0;
    self.smallCircle.bounds = CGRectMake(0, 0, smallR * 2, smallR * 2);
    self.smallCircle.layer.cornerRadius = smallR;
    
    LXHLog(@"当前距离--%f",distance);
    
    UIBezierPath *path = [self pathWithSmallCircle:self.smallCircle BigCirCle:self];
    
    // 形状图层
    if (self.smallCircle.hidden == NO) {
        self.shapL.path = path.CGPath;
    }
    
    if (distance > maxLenght) {
        //让小圆隐藏,让路径隐藏
        self.smallCircle.hidden = YES;
        [self.shapL removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        //判断距离是否大于临界值.
        //大于临界值让按钮消失
//        if(distance < maxLenght && self.smallCircle.hidden == NO) {//如果放开代表只要超过临界值就算再回到非临界值也不能恢复
        if(distance < maxLenght) {
            //小于临界值,复位
            self.smallCircle.hidden = NO;
            [self.shapL removeFromSuperlayer];
            [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:1.0 options:kNilOptions animations:^{
                
                self.center = self.smallCircle.center;
            } completion:^(BOOL finished) {
                
            }];
            
        }else {
            
            //播放一个动画消失
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            imageV.backgroundColor = [UIColor clearColor];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            for (int i = 0 ; i < 8; i++) {
                UIImage *image =  [UIImage imageNamed:[NSString stringWithFormat:@"%d",i +1]];
                [imageArray addObject:image];
            }
            
            imageV.animationImages = imageArray;
            imageV.animationDuration = 1;
            [imageV startAnimating];
            
            [self addSubview:imageV];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self removeFromSuperview];
            });
            
        }
    }
    
}

//给定两个圆,描述一个不规则的路径
- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle BigCirCle:(UIView  *)bigCircle {
    
    
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle BigCirCle:bigCircle];
    
    if (d <= 0) {
        return nil;
    }
    
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    
    return path;
    
    
}


//求两个圆之间距离
- (CGFloat)distanceWithSmallCircle:(UIView *)smallCircle BigCirCle:(UIView  *)bigCircle {
    
    //x轴方法向的偏移量
    CGFloat offsetX = bigCircle.center.x - smallCircle.center.x;
    //y轴方法向的偏移量
    CGFloat offsetY = bigCircle.center.y - smallCircle.center.y;
    
    return  sqrt(offsetX * offsetX + offsetY * offsetY);
}





- (void)setUp {
    
    //圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    
    //设置背景颜色
    [self setBackgroundColor:[UIColor redColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    //添加小圆
    UIView *smallCircle = [[UIView alloc] initWithFrame:self.frame];
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    smallCircle.backgroundColor = self.backgroundColor;
    
    [self.superview addSubview:smallCircle];
    self.smallCircle = smallCircle;
    
    //把一个UIView添加到指定的位置
    [self.superview insertSubview:smallCircle belowSubview:self];
    
    self.pandingBlock = ^(UIView *wrapperView , UITableViewCell *cell) {
        
        [wrapperView bringSubviewToFront:cell];
    };
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.smallCircle.center = self.center;
}


//取消高亮状态
-(void)setHighlighted:(BOOL)highlighted {
    
}


@end
