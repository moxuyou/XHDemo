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
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

//#import <AliHotFix/AliHotFix.h>//阿里热修复
//#import<AliHotFixDebug/AliHotFixDebug.h>
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

/* 控制第一次进入程序不提示网络窗口 */
@property(nonatomic , assign)BOOL isFirstLoad;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    LXHLog(@"%s", __func__);
    [self setUpAppDelegate];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    CHWelcomADVC *welcomVC = [[CHWelcomADVC alloc] init];
    self.window.rootViewController = welcomVC;
    
    [self.window makeKeyAndVisible];
    
    [self vendorsSetUp:launchOptions];
    
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
    
    //应用进入前台就同步一次补丁
//    [AliHotFix sync];
    [JSPatch sync];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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

//收到推送通知
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 2;
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

// 接收到通知事件
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"%@", userInfo);
}

#pragma mark - 第三方初始化
- (void)vendorsSetUp:(NSDictionary *)launchOptions{
    
    // 初始化友盟
    [self setUpUMengTJ];
    
    //初始化极光推送
    [self setUpJPush:launchOptions];
}

- (void)setUpJPush:(NSDictionary *)launchOptions{
    
    // 注册通知 推送方式：消息推送
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification object:nil];
    //推送方式：通知推送
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"c12f2b771dacd2f6d9edccaa" channel:nil apsForProduction:NO advertisingIdentifier:advertisingId];

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

- (void)setUpAppDelegate{
    
    self.m_udid = [FYUDIDTools UDID];
    self.m_idfa = [FYUDIDTools IDFA];
    
//    char aesEncryptKeyBytes[] = {66,119,-60,109,-52,86,-26,37,-45,49,60,77,110,-119,-99,38};
//    NSData *aesEncryptKeyData = [NSData dataWithBytes:aesEncryptKeyBytes length:sizeof(aesEncryptKeyBytes)];
//    char rsaPublicDerBytes[]={};
//    NSData *rsaPublicDerData = [NSData dataWithBytes:rsaPublicDerBytes length:sizeof(rsaPublicDerBytes)];
//    NSString *rsaPrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCXcMWY5KhIDYpk2TJIJPVDe55EMb4S+H4FWcQGjUMC9UmG4RMi0sRORTiTtuC/36JrWAzlssP2EpBa4STcDfs0BG9SfljkgZzHN/ifdpHUH75sViG4m3IsV5wM1QGKR5V3uaLJe6u5ODa7l4UJY4iFJ4XJ2RTfNnv7VfhMgCMuVF7cm45FJHhVySl0yaRneCta7RDSLN3LYZmctIHOlog33YKhmgEXFq5GxiGSTrXx1sFra07MB6cBkE09RiwG/7bzoyv4zmuXVG82tbipxy3Yed/SLUaNLNihQGLAa8IM6HhOsUTG8gB0yMnGpgJ5uKy3ReIW/8376nX4tF7yDvi1AgMBAAECggEAWWFdvld2WtBjFhJ68smdWC7lwin5nQi8mDvazmMhYeWTd9/vg2YSJoAEXGpbS+OZ4PEe65MOxXU/bePj9VzrHlBfw7h+jp9RAOOwAa3hc+koYpiTXnmgcTtkBs7REeQd+4O86F3thGwBIcbT5i6wrKYe+Hr/Lp7hnf2nhr86BGUvCCj2nBs+CoZuU4A1mupF926FXknVIvp6pRsTnAzC9Y+5GCixWpLnmMh9C1kEEbM3IIfsJ7vqrgN1JQdwXv6fRRnaGO+Odv5D5BjEc7ZX22CouG70It6puQ78iUbKzdUbm83A1Z5EgODM9BsLmkYNHuvw4MxkTXW85BqljewzAQKBgQDHEz23gpQC9JFHxOhJT7JeQndJp/pcWvB1CKZLnrPTNN0TPC5Aj1/p/g5ay0Q2jEdX4SEfySAxobM7/xB/g4wGNAmwYxUtxU6zpp3ClRm5qUZM598H7VffhWlho6wDJ8RWit8YTc6c3pnKsaardjjV63xq/t2Ny83EzltIcDzT3QKBgQDCvpC6t6UX/t2Z0yciDEiuUmhZvnR0iowpZjfgXYYOUYE2NsM1/5x9kzbPs0Bm3TnKg8iXNr0wy4SExUz85dWngs8EinzitTASRlw05kb6Lri1iRi81qqw1mva4fSc7N8867v1R6N0Uto+APu9zVLI8aMh+gZd4QxeZYvM6Bp2uQKBgQCumFt6hNVXOjPoo/OtyG4BaX3BZceYFFHr8ugWTlwckrKJ2jAegyB10lG4o6lxxdoUYuhwPi80GENgDTXk//RgxGbzAhNjDzcVLL4UGDx1rtZvQLVE+I4nBZUFA00rf0cdN7KuWB8rSbfMI76vhoIWa++0z050vBf90ZYRlA5lKQKBgDqQzruoUNj3h7MkAifGI/FwzPr4QNNvexlUKUerOI6DymUAcRKDLY/CPwCVeq+0phWWLjPzfU/4VIENSMrhX7CBsTo/X7FaJfvI9x/dhMjmVhwZ/7uCn1CRG1x3CXZL8hLDHgJ0qd5osENnTk3VOqk9qf6kz1daP7r/tNxJjPPZAoGBALsncF7J72+VQ6+B7rLAbQ3fDkNSA0jjFsRjpKSHn4eXmhhBT0EzuRHiH9mpl5eKa+v3CvpslS61S92J3erHFDY+9PXACTsFrXsjyD0UNIgF3ycesVOHTmZSzCAYeeL32xmpe8gyqefuUCRzC5jxYv+DZe/WBZ9h5ya1NeP+lVvV";
//    NSString *appId = @"94831-2";
//    NSString *secret = @"14f317d5a2064187ab0509bca19fefb6";
//    [AliHotFix startWithAppID:appId secret:secret privateKey:rsaPrivateKey publicKey:aesEncryptKeyData encryptAESKey:rsaPublicDerData];
//    
//    // patchDirectory 为本地Patch目录全路径,注意该Patch目录结构参照'Part2生成patch补丁'中的Patch目录结构规则
//    
//    [AliHotFixDebug runPatch:@"XHDemo/patch"];
    //热更新
    [JSPatch startWithAppKey:@"dbf44725446a8a04"];
    
    [JSPatch setupRSAPublicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDNzaL6LRSwM7FSUZfMbS4R6H3IfNOUEsc/TsOHkI6h2iNU4tKyVqF0mB1rB8/WB5DbEz7f7NA8BnKQw6dLqdyC7XMJnE5ZaA0Z0PW0jA+AQPNlvOeGS7ygxCsu4D74yUiruslbgAJkhFTAw1ChqZKTnagh8aYopKNfHTc1nPY91wIDAQAB"];
    [JSPatch sync];
    
    [JSPatch updateConfigWithAppKey:@"name"];
    NSDictionary *dict = [JSPatch getConfigParams];
    NSLog(@"%@", dict[@"name"]);
    [JSPatch setupUpdatedConfigCallback:^(NSDictionary *configs, NSError *error) {
        NSLog(@"%@ %@", configs, error);
    }];
}

@end
