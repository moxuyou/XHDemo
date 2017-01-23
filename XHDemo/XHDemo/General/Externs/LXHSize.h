//
//  LXHSize.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//


#define SCR_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCR_HEIGHT [UIScreen mainScreen].bounds.size.height

// 导航栏高度
#define navigationBarHeigth 64
// 头部的View默认高度
#define headViewHeigth 44
// 底部tabbar的高度
#define tabBarHeigth 49
// margin间距
#define marginDefault 10.0
// 顶部的默认间距
#define topMarginDefault 20

//字体的大小
#define FontSize8 [UIFont systemFontOfSize:8.0]
#define FontSize9 [UIFont systemFontOfSize:9.0]
#define FontSize10 [UIFont systemFontOfSize:10.0]
#define FontSize11 [UIFont systemFontOfSize:11.0]
#define FontSize12 [UIFont systemFontOfSize:12.0]
#define FontSize13 [UIFont systemFontOfSize:13.0]
#define FontSize14 [UIFont systemFontOfSize:14.0]
#define FontSize15 [UIFont systemFontOfSize:15.0]
#define FontSize16 [UIFont systemFontOfSize:16.0]
#define FontSize17 [UIFont systemFontOfSize:17.0]
#define FontSize18 [UIFont systemFontOfSize:18.0]
#define FontSize19 [UIFont systemFontOfSize:19.0]
#define FontSize20 [UIFont systemFontOfSize:20.0]
#define FontSize21 [UIFont systemFontOfSize:21.0]
#define FontSize22 [UIFont systemFontOfSize:22.0]
#define FontSize23 [UIFont systemFontOfSize:23.0]
#define FontSize24 [UIFont systemFontOfSize:24.0]
#define FontSize25 [UIFont systemFontOfSize:25.0]
#define FontSize26 [UIFont systemFontOfSize:26.0]
#define FontSize27 [UIFont systemFontOfSize:27.0]
#define FontSize28 [UIFont systemFontOfSize:28.0]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



