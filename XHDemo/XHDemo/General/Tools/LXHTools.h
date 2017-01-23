//
//  LXHTools.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXHTools : NSObject

/** 设备当前的网络状态 1. WIFI   2. 234G 3. 没有网络  4. 未知网络  */
@property(nonatomic , assign)NSInteger curronNetWorkingState;
/**/
@property(nonatomic , assign)BOOL hashSocketData;
/*所有自选的数据列表 */
@property(nonatomic , strong)NSArray *allShopArray;

+ (instancetype)shareTools;
/** 根据颜色和高度生成一张纯颜色的图片*/
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
/** 根据角度和图片名称生成一张旋转角度的图片*/
//- (UIImage*) GetImageWithAngle:(CGFloat)angle andName:(NSString *)name;
/** 根据图片和大小生成一张指定大小的图片 */
+ (UIImage *)getImagewithImage:(UIImage *)image AndSize:(CGSize)size;

/** 根据需要添加的Cache路径名称，创建并且返回该Cache路径 */
+ (NSString *)createCacheFilesFolder:(NSString *)pathName;
/** 根据需要添加的Document路径名称，创建并且返回该Document路径 */
+ (NSString *)createDocumentsFilesFolder:(NSString *)pathName;
/** 获取当天的日期 */
+ (NSString *)getTodayDateString;
/** 获取今天的日期字符串yyyy-MM-dd hh:mm:ss */
+ (NSString *)getTodayDetailDateString;
/** 获取用户是否登录 */
+ (BOOL)isUserLogin;
/** 获取系统版本 */
+ (float)getCurrentSystemDevice;
/** 获取当前软件主版本 */
+ (NSString *)getCurrentBundleVersion;
/** 获取当前软件打包版本 */
+ (NSString *)getCurrentShortVersion;
/** 保存上一个版本的版本号 */
- (void)saveLastVersion;
/** 获取上一个版本的版本号 */
- (NSString *)getLastVersion;

@end
