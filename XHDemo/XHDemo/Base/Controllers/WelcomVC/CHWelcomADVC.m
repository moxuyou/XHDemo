//
//  CHWelcomADVC.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "CHWelcomADVC.h"
#import <UIImageView+WebCache.h>
#import "AppDelegate.h"
#import "LXHTabBarController.h"

@interface CHWelcomADVC ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;

/** 当前序号 */
@property(nonatomic , assign)NSInteger index;
/** 点击跳转的URL */
@property(nonatomic , strong)NSString *jumpUrlString;
/** 程序主视图的tabBarController */
@property(nonatomic , strong)LXHTabBarController *tabBarController;

/** 定时器，用来控制按钮的值 */
@property(nonatomic , strong)NSTimer *timer;
/** 广告接口请求到的数据 */
@property(nonatomic , strong)NSDictionary *adDataDict;
/** 需要传递到自选界面的字典数据 */
@property(nonatomic , strong)NSDictionary *notificationAdDataDict;
@end

@implementation CHWelcomADVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    [self setUpSubview];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.adDataDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"RCWelcomeADVCData"];
    NSString *imageUrlStr = self.adDataDict[@"pictureUrl"];
    [self.placeholderImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    self.jumpUrlString = self.adDataDict[@"jumpUrl"];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSTimer *time = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    self.timer = time;
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)setUpSubview{
    
    self.imageView.image = [UIImage imageNamedByPath:@"LaunchImage"];
    self.bgImageView.image = [UIImage imageNamedByPath:@"Default"];
    if (IS_IPHONE_5) {
        self.bgImageView.image = [UIImage imageNamedByPath:@"Default_568h"];
    }else if (IS_IPHONE_6){
        self.bgImageView.image = [UIImage imageNamedByPath:@"Default_667h"];
    }else if (IS_IPHONE_6P){
        self.bgImageView.image = [UIImage imageNamedByPath:@"Default_736h"];
    }
    
    self.jumpButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    self.jumpButton.layer.cornerRadius = 5.0;
    self.jumpButton.layer.masksToBounds = YES;
    self.jumpButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.jumpButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    //获取网络数据
    [self getImageDataFromWeb];
    
    self.index = 3;
    
    self.jumpUrlString = @"";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageClick)];
    [self.bgView addGestureRecognizer:tap];
}

- (IBAction)jumpButtonClick {
    
    LXHLog(@"dasd  %@,%@", self, NSStringFromCGRect(self.view.frame));
    //    self.jumpBlock(self.view);
    
    [self.timer invalidate];
    self.timer = nil;
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    LXHTabBarController *tabBarController = [[LXHTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;

    // 设置颜色
    
    tabBarController.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    dict[NSShadowAttributeName] = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    dict[NSStrokeWidthAttributeName] = [UIFont fontWithName:@"" size:17.0];
    [tabBarController.navigationController.navigationBar setTitleTextAttributes:dict];
    
    //启动动画
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 添加启动页的图片
    UIImageView *welcomeImage = [[UIImageView alloc]initWithFrame:window.bounds];
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    welcomeImage.image = image;
    UIGraphicsEndImageContext();
    
    [window addSubview:welcomeImage];
    // 把背景图放在最上层
    [window bringSubviewToFront:welcomeImage];
    welcomeImage.alpha = 0.99;
    
    [UIView animateKeyframesWithDuration:2.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        welcomeImage.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        welcomeImage.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [welcomeImage removeFromSuperview];
    }];
    
    
    //[NoticeView sharedManager];
    
    
    
}

- (void)timeChange{
    
    if (--self.index <= 0) {
        //        self.jumpBlock(self);
        [self jumpButtonClick];
    }else{
        [self.jumpButton setTitle:[NSString stringWithFormat:@"%iS跳过", (int)self.index] forState:UIControlStateNormal];
    }
    
}

//广告被点击
- (void)adImageClick{
    
    if (![self.jumpUrlString isEqualToString:@""]) {
        
        LXHLog(@"开始跳转广告页");
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark -网络数据请求
- (void)getImageDataFromWeb{
    
//    WelcomeService *service = [[WelcomeService alloc] init];
//    [service getDiscoverMainDataWithData:nil Success:^(ResponseObject *object) {
//        //        NSLog(@"++++++++++++++%@", object);
//        //解析返回数据
//        NSDictionary *resultData = (NSDictionary *)object;
//        //        resultData = nil;
//        NSString *resultCodeStr = resultData[@"Result"][@"resultCode"];
//        NSInteger resultCode = [resultCodeStr integerValue];
//        if (resultCode == 0) {
//            NSLog(@"获取启动页接口数据成功");
//            //广告数据
//            NSDictionary *adDataDict = resultData[@"Ad"];
//            self.adDataDict = adDataDict;
//            self.notificationAdDataDict = resultData[@"Notification"];
//            self.jumpUrlString = adDataDict[@"jumpUrl"];
//            
//            if (adDataDict != nil) {
//                NSString *urlStr = adDataDict[@"pictureUrl"][0];
//                if (urlStr != nil || ![urlStr isEqualToString:@""]) {
//                    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
//                }
//            }
//            
//        }else{
//            NSLog(@"获取启动页接口数据失败");
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"获取启动页接口数据失败");
//        LXHLog(@"++++++++++++++%@", error);
//    }];
    
}

@end
