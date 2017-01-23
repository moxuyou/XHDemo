//
//  GMUtils+HUD.m
//  Gemo.com
//
//  Created by Horace.Yuan on 15/9/22.
//  Copyright (c) 2015年 gemo. All rights reserved.
//

#import "GMUtils+HUD.h"
#import "MBProgressHUD.h"

@implementation GMUtils (HUD)

+ (void)showQuickTipWithText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setLabelText:text];
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showQuickTipWithTitle:(NSString *)title withText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setLabelText:title];
    [hud setDetailsLabelText:text];
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showWaitingHUDInKeyWindow
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow
                         animated:YES];
}

+ (void)hideAllWaitingHUDInKeyWindow;
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow
                             animated:YES];
}

+ (MBProgressHUD *)showWaitingHUDInView:(UIView *)view;
{
    return ([MBProgressHUD showHUDAddedTo:view animated:YES]);
}

+ (void)hideAllWaitingHudInView:(UIView *)view;
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
              usingView:(UIView *)view
{
    [[self class] showTipsWithHUD:labelText showTime:time usingView:view yOffset:0.0f];
}

+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
              usingView:(UIView *)view
                yOffset:(CGFloat)yOffset
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    hud.yOffset = yOffset;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [view addSubview:hud];
    
    [hud hide:YES afterDelay:time];
    
}

+ (void)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
           withFontSize:(CGFloat)fontSize
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:fontSize];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hide:YES afterDelay:time];
}

+ (MBProgressHUD *)showTipsWithHUD:(NSString *)labelText
               showTime:(CGFloat)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hide:YES afterDelay:time];
    return hud;
}

+(MBProgressHUD *)showCustomHUDViewTo:(UIView*)view TipMsg:(NSString*)msg animated:(BOOL)animated{ //自定义提示框（登录、注册、修改密码成功时提示）
    UIView* customViews = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //customViews.backgroundColor = [UIColor redColor];
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake((customViews.bounds.size.width - 40)/2.0,-10,40, 40)];
    imageV.image = [UIImage imageNamed:@"icon_TipImage"];
    [customViews addSubview:imageV];
    UILabel* tipLab = [[UILabel alloc]initWithFrame:CGRectMake(-20, CGRectGetMaxY(imageV.frame)+2, customViews.bounds.size.width*2, 21)];
    tipLab.text = msg;
    tipLab.backgroundColor = [UIColor clearColor];
    tipLab.textColor = [UIColor whiteColor];
    tipLab.font = [UIFont systemFontOfSize:12];
    tipLab.textAlignment = NSTextAlignmentCenter;
    [customViews addSubview:tipLab];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = customViews;
    return hud;
}

@end
