//
//  LXHTools.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHTools.h"

@interface LXHTools ()


@end
@implementation LXHTools

static LXHTools *tools;

+ (instancetype)shareTools{
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[LXHTools alloc] init];
        });
        return tools;
    }else{
        return tools;
    }
}

/** 根据颜色和高度生成一张纯颜色的图片 */
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
/** 根据角度和图片名称生成一张旋转角度的图片*/
//- (UIImage*) GetImageWithAngle:(CGFloat)angle andName:(NSString *)name{
//    UIImage *image = [UIImage imageNamed:@""];
//    UIGraphicsBeginImageContext(image.size);
//    
//    return image;
//}

/** 返回一张指定大小的图片 */
+ (UIImage *)getImagewithImage:(UIImage *)image AndSize:(CGSize)size{

    //创建时上下文的大小,决定着生成图片的大小.
//    size = CGSizeMake(size.width * [UIScreen mainScreen].scale, size.height * [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContext(size);
    
    //把图片绘制到上下文当中
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image drawAtPoint:CGPointZero];
    
    //把上下文当中所有绘制的合成到一起, 生成一张新的图片.
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**  */
- (void)setCurronNetWorkingState:(NSInteger)curronNetWorkingState{
    if (_curronNetWorkingState == 3 && curronNetWorkingState != 3) {
        _curronNetWorkingState = curronNetWorkingState;
//        [[NSNotificationCenter defaultCenter] postNotificationName:ConnectNetWorkAgain object:self];
    }
    
    _curronNetWorkingState = curronNetWorkingState;
//    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu", curronNetWorkingState] forKey:@"curronNetWorkingState"];
}

/**  根据需要添加的Cache路径名称，创建并且返回该Cache路径 */
+ (NSString *)createCacheFilesFolder:(NSString *)pathName{
    NSString *cacheFilesFolderPath = [NSString stringWithFormat:@"%@/%@", lxhCachesDirectory, pathName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:cacheFilesFolderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir)) {
        [fileManager createDirectoryAtPath:cacheFilesFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cacheFilesFolderPath;
}

/**  根据需要添加的Document路径名称，创建并且返回该Document路径 */
+ (NSString *)createDocumentsFilesFolder:(NSString *)pathName{
    NSString *documentsFilesFolderPath = [NSString stringWithFormat:@"%@/%@", lxhDocumentsDirectory, pathName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:documentsFilesFolderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir)) {
        [fileManager createDirectoryAtPath:documentsFilesFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsFilesFolderPath;
}

/** 获取今天的日期字符串yyyy-MM-dd */
+ (NSString *)getTodayDateString{
    
    // 再算出本差的分钟
    NSDate *date=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr=[format stringFromDate:date];
    
    return dateStr;
}

/** 获取今天的日期字符串yyyy-MM-dd hh:mm:ss */
+ (NSString *)getTodayDetailDateString{
    
    // 再算出本差的分钟
    NSDate *date=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr=[format stringFromDate:date];
    
    return dateStr;
}

/** 获取用户是否登录 */
+ (BOOL)isUserLogin{
    
    //判断用户是否登录
//    NSDictionary *userDict = [APIUser getUserDict];
//    //在没有登陆的时候返回的是热门数据，登陆之后返回的是用户自选数据
//    if (userDict[@"sessionId"] == nil) {
//        return NO;
//    }
    return YES;
}

/** 获取系统版本 */
+ (float)getCurrentSystemDevice{
    
    return [[UIDevice currentDevice].systemVersion floatValue];
}

/**  获取当前软件主版本 */
+ (NSString *)getCurrentShortVersion{
    
    NSString *bundleShortVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    return bundleShortVersionStr;
}

/**  获取当前软件打包版本 */
+ (NSString *)getCurrentBundleVersion{
    
    NSString *bundleVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    return bundleVersionStr;
}

/** 保存上一个版本的版本号 */
- (void)saveLastVersion{
    
    NSString *shortVersion = [LXHTools getCurrentShortVersion];
    NSString *bundleVersion = [LXHTools getCurrentBundleVersion];
    NSString *version = [NSString stringWithFormat:@"%@%@", shortVersion,bundleVersion];
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:lastVersion];
    
}

/** 获取上一个版本的版本号 */
- (NSString *)getLastVersion{
    NSString *version = [[NSUserDefaults standardUserDefaults] valueForKey:lastVersion];
    return version;
}

@end
