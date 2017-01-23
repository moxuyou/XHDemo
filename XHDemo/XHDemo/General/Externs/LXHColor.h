//
//  LXHColor.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define COLOR(c) [UIColor colorFromInteger:c]

#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kUIColorFromRGBAlpha(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

// 常用颜色设置
#define WHITE_COLOR                 [UIColor whiteColor]
#define BLACK_COLOR                 [UIColor blackColor]
#define CLEAR_COLOR                 [UIColor clearColor]
#define ORANGE_COLOR                [UIColor orangeColor]
#define GREEN_COLOR                 [UIColor greenColor]
#define BLUE_COLOR                  [UIColor blueColor]

#define BG_COLOR                    RGB(234,234,234)


