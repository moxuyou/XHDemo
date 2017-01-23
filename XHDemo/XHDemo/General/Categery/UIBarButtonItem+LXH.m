//
//  UIBarButtonItem+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "UIBarButtonItem+LXH.h"

@implementation UIBarButtonItem (LXH)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)higthImage targer:(id)targer action:(SEL)seletor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:higthImage forState:UIControlStateHighlighted];
    [btn addTarget:targer action:seletor forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)barButtonItemWithImage:(UIImage *)image seletImage:(UIImage *)seletImage targer:(id)targer action:(SEL)seletor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:seletImage forState:UIControlStateSelected];
    [btn addTarget:targer action:seletor forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
