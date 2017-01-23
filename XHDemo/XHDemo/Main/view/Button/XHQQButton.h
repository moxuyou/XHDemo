//
//  XHQQButton.h
//  XHDemo
//
//  Created by moxuyou on 2017/1/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cellQQButtonPandingBlock)(UIView *,UITableViewCell *);
@interface XHQQButton : UIButton

/** 粒子被拖动 */
@property (copy, nonatomic) cellQQButtonPandingBlock pandingBlock;

@end
