//
//  UIImageView+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "UIImageView+LXH.h"
#import <AFNetworking.h>

@implementation UIImageView (LXH)


/*
 sd_setImageWithURL:placeholderImage:方法的执行步骤
 1.取消当前imageView之前关联的请求
 2.设置占位图片到当前imageView上面
 3.如果缓存中有对应的图片，那么就显示到当前imageView上面
 4.如果缓存中没有对应的图片，发送请求给服务器下载图片
 */

- (void)lxh_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage
{
    [self lxh_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:placeholderImage completed:nil];
}

- (void)lxh_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock
{
    // 从内存\沙盒缓存中获得原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageURL];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] completed:completedBlock];
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
            //     用户的配置项假设利用NSUserDefaults存储到了沙盒中
            //从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            if (alwaysDownloadOriginalImage) { // 下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
            } else { // 下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
            }
        } else { // 没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 内存\沙盒缓存中有小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] completed:completedBlock];
            } else {
                [self sd_setImageWithURL:nil placeholderImage:placeholderImage completed:completedBlock];
            }
        }
    }
}

- (void)lxh_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL
{
    [self lxh_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:nil completed:nil];
}

- (void)lxh_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock
{
    [self lxh_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:nil completed:completedBlock];
}

@end
