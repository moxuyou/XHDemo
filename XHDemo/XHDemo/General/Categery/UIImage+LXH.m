//
//  UIImage+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "UIImage+LXH.h"

@implementation UIImage (LXH)

/**返回一个不被渲染的image，也可以在image对应的属性上面设置*/
+ (UIImage *)imageWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

/** 根据路径去加载Bundle返回的路径图片 */
+ (UIImage *)imageNamedByPath:(NSString *)imageName{
    
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@".png"];
    if ([NSString isNilString:imgPath]) {
        
        imgPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@".jpg"];
        if ([NSString isNilString:imgPath]) {
            if (scale == 2) {
                imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x", imageName] ofType:@".png"];
            }else{
                imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@3x", imageName] ofType:@".png"];
            }
            
        }
        if ([NSString isNilString:imgPath]) {
            if (scale == 2) {
                imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x", imageName] ofType:@".jpg"];
            }else{
                imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@3x", imageName] ofType:@".jpg"];
            }
            
        }
    }
    
    if ([NSString isNilString:imgPath]) {
        return nil;
    }
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
    
    return image;
}

@end
