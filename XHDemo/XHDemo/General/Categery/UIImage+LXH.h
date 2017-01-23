//
//  UIImage+LXH.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LXH)

/**返回一个不被渲染的image，也可以在image对应的属性上面设置*/
+ (UIImage *)imageWithOriginal:(NSString *)imageName;
/** 根据路径去加载Bundle返回的路径图片 */
+ (UIImage *)imageNamedByPath:(NSString *)imageName;

@end
