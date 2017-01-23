//
//  LXHNavigationBar+LXHDefault.h
//  moxuyou_Base
//
//  Created by Moxuyou on 2016/10/24.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHNavigationBar.h"

@interface LXHNavigationBar (LXHDefault)

- (void)setBackBtn;  //返回按钮
- (void)setBackMeBtn; //返回我＋按钮
- (void)setBackHomePageBtn; //返回首页按钮
- (void)setMoreBtn;
- (void)setBackBtnWithTitle:(NSString*)title;
- (void)setBackMeBtnWithTitle:(NSString*)title;
- (void)setBackHomePageBtnWithTitle:(NSString*)title;
- (void)setInfoWithText:(NSString*)tx andType:(NSString*)typeName andPhoto:(UIImageView*)photoImage;
- (void)setLoginInfo;
- (void)setBackBtnAndCloseBtn;

@end
