//
//  LXHNavigationBar.h
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomNavigationBarDelegate;

@interface LXHNavigationBar : UIView

@property(weak,nonatomic) id<CustomNavigationBarDelegate> delegate;


//添加标题
-(void)addNavigationBarTitile:(NSString*)title;
//修改标题
-(void)modifyNavigationBarTtile:(NSString*)title;
//添加左按钮
-(void)addNavigationBarLeftButton:(NSString*)btnTitle;
//添加左边第二个按钮
- (void)addNavigationBarLeftSecondButton:(NSString*)btnTitle;
//添加右按钮
-(void)addNavigationBarRightButton:(NSString *)btnTitle;
//添加右边第二个按钮
- (void)addNavigationBarRightSecondButton:(NSString*)btnTitle;
//添加中间segmentControl
-(void)addNavigationBarSegmentControl;
//添加中间ImageView
- (void)addNavigationBarImageView:(UIImage*)image;
//添加左边图片
- (void)addNavigationBarLeftImageView:(UIImageView*)headerImageView;

- (void)setTitle:(NSString*)title;
- (void)setLeftButtonTitle:(NSString*)btnTitle;
- (void)setRightButtonTitle:(NSString*)bntTitle;
- (void)setLeftButtonBgImage:(UIImage*)image andHlImage:(UIImage*)hlImage;
- (void)setRightButtonBgImage:(UIImage*)image andHlImage:(UIImage*)hlImage;

//设置左按钮隐藏属性
-(void)setNavigationBarLeftButtonHidden:(BOOL)isHidden;

-(void)setNavigationBarSecondBtnHidden:(BOOL)isHidden;

@end

@protocol CustomNavigationBarDelegate <NSObject>

@optional

//点击标题栏事件
- (void)tapMiddleLabelEvent:(id)sender;
//点击左按钮事件
-(void)clickCustomNavigationBarLeftButtonEvent:(id)sender;
//点击左边第二个按钮事件
-(void)clickCustomNavigationBarLeftSecondButtonEvent:(id)sender;
//点击右边第二个按钮事件
-(void)clickCustomNavigationBarRightSecondButtonEvent:(id)sender;
//点击右按钮事件
-(void)clickCustomNavigationBarRightButtonEvent:(id)sender;
//segment选择事件
-(void)customNavigationBarSegmentAction:(id)sender;

@end
