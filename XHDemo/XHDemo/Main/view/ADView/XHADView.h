//
//  XHADView.h
//  XHDemo
//
//  Created by moxuyou on 2017/1/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXHPageControl.h"

@interface XHADView : UIView

/** 图片数据数组 */
@property (strong, nonatomic) NSArray *images;
/** 轮播页码 */
@property (weak, nonatomic) LXHPageControl *pageControl;
/** 控制横竖屏 */
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;

@end
