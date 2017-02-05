//
//  AppDelegate.m
//  XHDemo
//
//  Created by moxuyou on 16/10/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "AppDelegate.h"
#import "CHWelcomADVC.h"
#import "FYUDIDTools.h"
#import "UMMobClick/MobClick.h"
#import <AFNetworking/AFNetworking.h>

@interface AppDelegate ()

/* 控制第一次进入程序不提示网络窗口 */
@property(nonatomic , assign)BOOL isFirstLoad;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    LXHLog(@"%s", __func__);
    
    self.m_udid = [FYUDIDTools UDID];
    self.m_idfa = [FYUDIDTools IDFA];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    CHWelcomADVC *welcomVC = [[CHWelcomADVC alloc] init];
    self.window.rootViewController = welcomVC;
    
    [self.window makeKeyAndVisible];
    
    [self vendorsSetUp];
    
    //网络状态监听
    [self addObserverNetWorkingStae];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    LXHLog(@"%s", __func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    LXHLog(@"%s", __func__);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    LXHLog(@"%s", __func__);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    LXHLog(@"%s", __func__);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    LXHLog(@"%s", __func__);
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2. 清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark - 第三方初始化
- (void)vendorsSetUp{
    
    // 初始化友盟
    [self setUpUMengTJ];
    
}

- (void)setUpUMengTJ{
    
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"5885a3c3ae1bf8056f002924";
    //    UMConfigInstance.secret = @"secretstringaldfkals";
    [MobClick startWithConfigure:UMConfigInstance];
}

#pragma mark - Action
//网络状态监听
- (void)addObserverNetWorkingStae{
    //1.通过网络监测管理者监听状态的改变
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        /*
         AFNetworkReachabilityStatusUnknown          = -1,  未知
         AFNetworkReachabilityStatusNotReachable     = 0,   没有网络
         AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G|4G
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   WIFI
         */
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                LXHLog(@"WIFI");
                if (self.isFirstLoad == YES) {
                    [GMUtils showTipsWithHUD:@"您已切换到WIFI网络" showTime:1];
                    
                }
                self.isFirstLoad = YES;
                [LXHTools shareTools].curronNetWorkingState = 1;
                [[NSNotificationCenter defaultCenter] postNotificationName:NetworkStatus object:self userInfo:@{@"NetworkStatus" : @"AFNetworkReachabilityStatusReachableViaWiFi"}];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                LXHLog(@"3G&4G");
                if (self.isFirstLoad == YES) {
                    [GMUtils showTipsWithHUD:@"您已切换到手机网络" showTime:1];
                }
                self.isFirstLoad = YES;
                [LXHTools shareTools].curronNetWorkingState = 2;
                [[NSNotificationCenter defaultCenter] postNotificationName:NetworkStatus object:self userInfo:@{@"NetworkStatus" : @"AFNetworkReachabilityStatusReachableViaWWAN"}];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                LXHLog(@"没有网络");
                if (self.isFirstLoad == YES) {
                    [GMUtils showTipsWithHUD:@"您的网络链接已断开" showTime:1];
                }
                self.isFirstLoad = YES;
                [LXHTools shareTools].curronNetWorkingState = 3;
                [[NSNotificationCenter defaultCenter] postNotificationName:NetworkStatus object:self userInfo:@{@"NetworkStatus" : @"AFNetworkReachabilityStatusNotReachable"}];
                break;
            case AFNetworkReachabilityStatusUnknown:
                LXHLog(@"未知");
                if (self.isFirstLoad == YES) {
                    [GMUtils showTipsWithHUD:@"您已切换到未知网络" showTime:1];
                }
                self.isFirstLoad = YES;
                [LXHTools shareTools].curronNetWorkingState = 4;
                [[NSNotificationCenter defaultCenter] postNotificationName:NetworkStatus object:self userInfo:@{@"NetworkStatus" : @"AFNetworkReachabilityStatusUnknown"}];
                break;
            default:
                break;
        }
        
    }];
    
    //2.开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


@end
