//
//  PreciousMetalCustomHeader.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "PreciousMetalCustomHeader.h"
#import <ImageIO/ImageIO.h>
#import "UIImage+GIF.h"
@implementation PreciousMetalCustomHeader

#pragma mark 基本设置
- (void)prepare
{
    [super prepare];

    NSArray *refreshingImages = [self getImageArrayWithGIFName:@"lodaing_big"];
    
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateIdle];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:refreshingImages forState:MJRefreshStateWillRefresh];
    [self setImages:refreshingImages forState:MJRefreshStateNoMoreData];
    self.labelLeftInset = 5.0;

}

//拆分动态图
- (NSArray<UIImage *> *)getImageArrayWithGIFName:(NSString *)imageName {
   
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    if (!data) {
        NSLog(@"图片不存在!");
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    if (count <= 1) {
        [imageArray addObject:[[UIImage alloc] initWithData:data]];
    }else {
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            [imageArray addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
    }
    
    CFRelease(source);
    
    return imageArray;
}

@end
