//
//  LXHNavigationBar+LXHDefault.m
//  moxuyou_Base
//
//  Created by Moxuyou on 2016/10/24.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHNavigationBar+LXHDefault.h"

@implementation LXHNavigationBar (LXHDefault)

- (void)setBackBtn
{
    UIImage *backImage = [UIImage imageNamed:@"cm_back"];
    [self addNavigationBarLeftButton:nil];
    [self setLeftButtonBgImage:backImage andHlImage:backImage];
}

- (void)setBackMeBtn
{
    UIImage *backImage = [UIImage imageNamed:@"cm_back"];
    [self addNavigationBarLeftButton:nil];
    [self setLeftButtonBgImage:backImage andHlImage:backImage];
    
}

- (void)setBackHomePageBtn
{
    UIImage *backImage = [UIImage imageNamed:@"cm_back"];
    [self addNavigationBarLeftButton:nil];
    [self setLeftButtonBgImage:backImage andHlImage:backImage];
}

- (void)setMoreBtn
{
    UIImage *moreImage = [UIImage imageNamed:@"cm_more"];
    [self addNavigationBarRightButton:nil];
    [self setRightButtonBgImage:moreImage andHlImage:moreImage];
    
}

- (void)setBackBtnWithTitle:(NSString*)title
{
    [self setBackBtn];
    [self addNavigationBarTitile:title];
}

- (void)setBackMeBtnWithTitle:(NSString*)title
{
    [self setBackMeBtn];
    [self addNavigationBarTitile:title];
}

- (void)setBackHomePageBtnWithTitle:(NSString*)title
{
    [self setBackHomePageBtn];
    [self addNavigationBarTitile:title];
    
}

- (void)setInfoWithText:(NSString*)tx andType:(NSString*)typeName andPhoto:(UIImageView*)photoImage
{
    [self setNavigationBarLeftButtonHidden:YES];
    [self addNavigationBarLeftImageView:photoImage];
}

-(NSString*)vagueString:(NSString*)str andType:(NSString*)typeName { //模糊化
    NSString *text = @"";
    if ([typeName isEqualToString:@"mobile"]) { //电话号码
        NSString *prefix = [str substringToIndex:3];
        NSString *suffix = [str substringFromIndex:str.length-4];
        if (prefix.length > 0 && suffix.length > 0) {
            text = [[NSString alloc] initWithFormat:@"%@****%@",prefix,suffix];
        }
        return text;
    }else if ([typeName isEqualToString:@"realName"]) { //真名
        
        NSString *suffix = [str substringFromIndex:str.length-1];
        if (suffix.length > 0) {
            text = [[NSString alloc] initWithFormat:@"*%@",suffix];
        }
        return text;
    }else{ //昵称不用模糊化
        return str;
    }
    
}

- (void)setLoginInfo
{
    UIImage *leftBgImage = [UIImage imageNamed:@"icon_login"];
    UIImageView *leftBGImageView = [[UIImageView alloc]initWithImage:leftBgImage];
    [self setNavigationBarLeftButtonHidden:YES];
    [self addNavigationBarLeftImageView:leftBGImageView];
}

- (void)setBackBtnAndCloseBtn
{
    [self setBackBtn];
    NSString *title = @"关闭";
    [self addNavigationBarLeftSecondButton:title];
    
}

@end
