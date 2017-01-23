//
//  CHWelcomADVC.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXHBaseVC.h"

typedef void(^jumpButtonClickBlock)(UIView *);
@interface CHWelcomADVC : LXHBaseVC
/* 跳过按钮被点击 */
@property(nonatomic , copy)jumpButtonClickBlock jumpBlock;

@end
