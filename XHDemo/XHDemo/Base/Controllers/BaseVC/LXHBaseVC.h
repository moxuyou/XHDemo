//
//  LXHBaseVC.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXHNavigationBar.h"

@interface LXHBaseVC : UIViewController<CustomNavigationBarDelegate>

@property(nonatomic,weak) LXHNavigationBar *navigationBar;  //自定义导航栏

@end
