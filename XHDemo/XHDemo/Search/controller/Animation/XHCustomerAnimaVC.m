//
//  XHCustomerAnimaVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/24.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHCustomerAnimaVC.h"
#import "XHAnimationPushVC.h"
#import "CustomAnimateTransitionPush.h"

@interface XHCustomerAnimaVC ()<CAAnimationDelegate,UINavigationControllerDelegate>

/** 按钮1 */
@property (weak, nonatomic)UIButton *btn1;
/** 按钮2 */
@property (weak, nonatomic)UIButton *btn2;
/** 按钮3 */
@property (weak, nonatomic)UIButton *btn3;
/** 按钮4 */
@property (weak, nonatomic)UIButton *btn4;

@end

@implementation XHCustomerAnimaVC


#pragma mark - 懒加载
- (UIButton *)btn1{
    
    if (_btn1 == nil) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 40.0;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _btn1 = btn;
    }
    return _btn1;
}

- (UIButton *)btn2{
    
    if (_btn2 == nil) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250, 100, 80, 80)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor yellowColor];
        btn.layer.cornerRadius = 40.0;
        [self.view addSubview:btn];
        _btn2 = btn;
    }
    return _btn2;
}

- (UIButton *)btn3{
    
    if (_btn3 == nil) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 80, 80)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor blueColor];
        btn.layer.cornerRadius = 40.0;
        [self.view addSubview:btn];
        _btn3 = btn;
    }
    return _btn3;
}

- (UIButton *)btn4{
    
    if (_btn4 == nil) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250, 250, 80, 80)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor orangeColor];
        btn.layer.cornerRadius = 40.0;
        [self.view addSubview:btn];
        _btn4 = btn;
    }
    return _btn4;
}

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏蔽父类的自定义导航栏，采用系统的
    self.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    
    //初始化控件
    [self setUpSubView];
    
    //添加按钮悬浮动画
    [self addButtonFloatAnima];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 必须在viewDidAppear或者viewWillAppear中写，因为每次都需要将delegate设为当前界面
    self.navigationController.delegate = self;
    
    // 给按钮添加悬浮动画
    [self addButtonFloatAnima];
    
}

#pragma mark - 初始化
- (void)setUpSubView{
    
    [self btn1];
    [self btn2];
    [self btn3];
    [self btn4];
    
    UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 200, 30)];
    detailL.text = @"关键帧动画";
    detailL.font = [UIFont systemFontOfSize:20.0];
    detailL.textColor = [UIColor orangeColor];
    [self.view addSubview:detailL];
}

- (void)addButtonFloatAnima{
    
    for (UIButton *btn in self.view.subviews) {
        
        if (![btn isKindOfClass:[UIButton class]]) {
            continue;
        }
        /*
         - keyPath可以使用的key
         
         - #define angle2Radian(angle) ((angle)/180.0*M_PI)
         
         - transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)
         
         transform.rotation.y 围绕y轴翻转 参数：同上
         
         transform.rotation.z 围绕z轴翻转 参数：同上
         
         transform.rotation 默认围绕z轴
         
         transform.scale.x x方向缩放 参数：缩放比例 1.5
         
         transform.scale.y y方向缩放 参数：同上
         
         transform.scale.z z方向缩放 参数：同上
         
         transform.scale 所有方向缩放 参数：同上
         
         transform.translation.x x方向移动 参数：x轴上的坐标 100
         
         transform.translation.y x方向移动 参数：y轴上的坐标
         
         transform.translation.z x方向移动 参数：z轴上的坐标
         
         transform.translation 移动 参数：移动到的点 （100，100）
         
         opacity 透明度 参数：透明度 0.5
         
         backgroundColor 背景颜色 参数：颜色 (id)[[UIColor redColor] CGColor]
         
         cornerRadius 圆角 参数：圆角半径 5
         
         borderWidth 边框宽度 参数：边框宽度 5
         
         bounds 大小 参数：CGRect
         
         contents 内容 参数：CGImage
         
         contentsRect 可视内容 参数：CGRect 值是0～1之间的小数
         
         hidden 是否隐藏
         
         position
         
         shadowColor
         
         shadowOffset
         
         shadowOpacity
         
         shadowRadius
         */
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        /*
         calculationMode: 该属性决定了物体在每个子路径下是跳着走还是匀速走。
         （1） const kCAAnimationLinear//线性，默认
         （2） const kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
         （3） const kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
         （4） const kCAAnimationCubic//平均，同上
         （5） const kCAAnimationCubicPaced//平均，同上
         */
        anim.calculationMode = kCAAnimationPaced;
        //决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后保留什么状态
        anim.fillMode = kCAFillModeForwards;
        //重复次数，无限循环可以设置HUGE_VALF或者MAXFLOAT
        anim.repeatCount = MAXFLOAT;
        //动画执行时间
        if(btn == self.btn1)
        {
            anim.duration=6;
            
        }else if(btn == self.btn2)
        {
            anim.duration=7;
            
        }else if(btn == self.btn3)
        {
            anim.duration=5;
            
        }else if(btn == self.btn4)
        {
            anim.duration=4;
        }
        //代理
        anim.delegate = self;
        //重复时间
        anim.repeatDuration = 0.0;
        
        anim.autoreverses = YES;
        //默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
        anim.removedOnCompletion = NO;
        //速度控制函数，控制动画运行的节奏
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, btn.LXHWidth * 0.5 - 5, btn.LXHWidth * 0.5 - 5)];
        anim.path = path.CGPath;
        
        [btn.layer addAnimation:anim forKey:@"btnFloatAnim"];
        
        
        CAKeyframeAnimation *scaleXAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
        scaleXAnim.values = @[@1.0,@1.1,@1.0];
        scaleXAnim.keyTimes = @[@0.0,@0.5,@1.0];
        scaleXAnim.repeatCount = MAXFLOAT;
        scaleXAnim.autoreverses = YES;
        //动画执行时间
        if(btn == self.btn1)
        {
            scaleXAnim.duration=5;
            
        }else if(btn == self.btn2)
        {
            scaleXAnim.duration=6;
            
        }else if(btn == self.btn3)
        {
            scaleXAnim.duration=4;
            
        }else if(btn == self.btn4)
        {
            scaleXAnim.duration=7;
        }
        [btn.layer addAnimation:scaleXAnim forKey:@"floatButtonScaleX"];
        
        /// scaleY
        CAKeyframeAnimation *scaleYAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
        
        scaleYAnim.values   = @[@1.0, @1.1, @1.0];
        scaleYAnim.keyTimes = @[@0.0, @0.5,@1.0];
        scaleYAnim.repeatCount = MAXFLOAT;
        scaleYAnim.autoreverses = YES;
        if(btn == self.btn1)
        {
            scaleYAnim.duration=6;
            
        }else if(btn == self.btn2)
        {
            scaleYAnim.duration=6;
            
        }else if(btn == self.btn3)
        {
            scaleYAnim.duration=4;
            
        }else if(btn == self.btn4)
        {
            scaleYAnim.duration=5;
        }
        [btn.layer addAnimation:scaleYAnim forKey:@"scaleY"];
    }
    
}

#pragma mark - 数据源

#pragma mark - 代理
//CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    
    LXHLog(@"动画开始---%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    LXHLog(@"动画结束---%s", __func__);
}

#pragma mark - Action
- (void)btnClick:(UIButton *)btn{
    
    LXHLog(@"%s", __func__);
    
    self.curronButton = btn;
    XHAnimationPushVC *pushVC = [[XHAnimationPushVC alloc] init];
    
    UIImage *image = nil;
    if(btn == self.btn1)
    {
        image = [UIImage imageNamed:@"hzw1"];
        
    }else if(btn == self.btn2)
    {
        image =[UIImage imageNamed:@"hzw2"];
        
    }else if(btn == self.btn3)
    {
        image =[UIImage imageNamed:@"hzw3"];
        
    }else if(btn == self.btn4)
    {
        image =[UIImage imageNamed:@"hzw4"];
    }
    pushVC.myImage = image;
    
    [self.navigationController pushViewController:pushVC animated:YES];
}

//- (void)customAnimation{
//    CustomTransitionViewController *vc = [[CustomTransitionViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

//用来自定义转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if(operation==UINavigationControllerOperationPush)
    {
        CustomAnimateTransitionPush *animateTransitionPush=[CustomAnimateTransitionPush new];
        return animateTransitionPush;
    }
    else
    {
        return nil;
    }
    
}


@end
