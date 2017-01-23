//
//  LXHNavigationBar.m
//  moxuyou_Base
//
//  Created by moxuyou on 16/10/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHNavigationBar.h"
#import <Masonry.h>

#define buttonW 60.0
#define buttonH 35.0
@interface LXHNavigationBar ()<UIGestureRecognizerDelegate>

@property(strong,nonatomic) UIButton *leftButton;
@property(strong,nonatomic) UIButton *leftSecondButton;
@property(strong,nonatomic) UIImageView *leftImageView;
@property(strong,nonatomic) UILabel *middleLabel;
@property(strong,nonatomic) UIButton *rightButton;
@property(strong,nonatomic) UIButton *rightsecondButton;
@property(strong,nonatomic) UISegmentedControl *segmentedControl;
@property(strong,nonatomic) UIImageView *imageView;

//点击左按钮事件
-(void)clickLeftButtonEvent:(id)sender;
//点击右按钮事件
-(void)clickRightButtonEvent:(id)sender;
//segment选择事件
-(void)segmentAction:(id)sender;

@end

@implementation LXHNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kUIColorFromRGB(0x1e82d2);//蓝色背景
        //[self createHorizonLine];//因为出现了间隔，删掉这段加载进度条
    }
    return self;
}

- (void)createHorizonLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.LXHHeight-1.0f, self.LXHWidth, 1.0f)];
    line.backgroundColor = RGB(238,238,238);
    [self addSubview:line];
    
}


//添加标题
- (void)addNavigationBarTitile:(NSString*)title{
    
    if (!self.middleLabel) {
        
        float originX = 100.0f;
        float width = self.bounds.size.width - originX*2;
        self.middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, 25, width, 30)];
        [self.middleLabel setFont:FontSize15];
        [self.middleLabel setText:title];
        [self.middleLabel setTextColor:[UIColor whiteColor]];
        [self.middleLabel setBackgroundColor:[UIColor clearColor]];
        self.middleLabel.textAlignment = NSTextAlignmentCenter;
        self.middleLabel.userInteractionEnabled = YES;
        
        self.middleLabel.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:self.middleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMiddleLabelEvent:)];
        [self.middleLabel addGestureRecognizer:tap];
    }else{
        [self.middleLabel setText:title];
    }
}


-(void)modifyNavigationBarTtile:(NSString*)title
{
    if(self.middleLabel)
    {
        [self.middleLabel setText:title];
    }
}

//添加左按钮
- (void)addNavigationBarLeftButton:(NSString*)btnTitle{
    
    if (!self.leftButton) {

        self.leftButton = [[UIButton alloc] init];
        [self.leftButton addTarget:self action:@selector(clickLeftButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftButton setTitle:btnTitle forState:UIControlStateNormal];
        [self.leftButton.titleLabel setFont:FontSize15];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.leftButton];
        
        [self.leftButton setImage:[UIImage imageNamed:@"back_nor"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"back_press"] forState:UIControlStateSelected];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(marginDefault - 4);
            make.centerY.equalTo(self).offset(topMarginDefault * 0.5);
            make.width.equalTo(buttonW);
            make.height.equalTo(buttonH);
        }];
    }
}

//添加左边第二个按钮
- (void)addNavigationBarLeftSecondButton:(NSString*)btnTitle
{
    if (!self.leftSecondButton) {
        
        self.leftSecondButton = [[UIButton alloc] init];
        [self.leftSecondButton addTarget:self action:@selector(clickedLeftSecondButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftSecondButton setTitle:btnTitle forState:UIControlStateNormal];
        [self.leftSecondButton.titleLabel setFont:FontSize12];
        [self.leftSecondButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [self addSubview:self.leftSecondButton];
        
        CGFloat originX = 0;
        if (self.leftButton != nil) {
            originX = buttonW + marginDefault - 4;
        }
        [self.leftSecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(originX);
            make.centerY.equalTo(self).offset(topMarginDefault * 0.5);
            make.width.equalTo(buttonW);
            make.height.equalTo(buttonH);
        }];
    }
}

//添加右按钮
- (void)addNavigationBarRightButton:(NSString *)btnTitle{
    if (!self.rightButton) {
        self.rightButton = [[UIButton alloc] init];
        [self.rightButton addTarget:self action:@selector(clickRightButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton setTitle:btnTitle forState:UIControlStateNormal];
        [self.rightButton setAccessibilityIdentifier:@"rightButton"];
        [self.rightButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [self.rightButton.titleLabel setFont:FontSize15];
        [self addSubview:self.rightButton];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(4 - marginDefault);
            make.centerY.equalTo(self).offset(topMarginDefault * 0.5);
            make.width.equalTo(buttonW);
            make.height.equalTo(buttonH);
        }];
    }
}

//添加右边第二个按钮
- (void)addNavigationBarRightSecondButton:(NSString*)btnTitle
{
    if (!self.rightsecondButton) {
        self.rightsecondButton = [[UIButton alloc] init];
        [self.rightsecondButton addTarget:self action:@selector(clickedRightSecondButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightsecondButton setTitle:btnTitle forState:UIControlStateNormal];
        [self.rightsecondButton.titleLabel setFont:FontSize12];
        [self.rightsecondButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [self addSubview:self.rightsecondButton];
        
        CGFloat originX = 0;
        if (self.rightButton != nil) {
            originX = buttonW + marginDefault - 4;
        }
        [self.rightsecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(-originX);
            make.centerY.equalTo(self).offset(topMarginDefault * 0.5);
            make.width.equalTo(buttonW);
            make.height.equalTo(buttonH);
        }];
    }
}

//添加中间segmentControl
-(void)addNavigationBarSegmentControl{
    
    //    if (!segmentedControl) {
    //        segmentedControl = [[UISegmentedControl alloc] initWithItems:
    //                            [NSArray arrayWithObjects:
    //                             nil]];
    //
    //        segmentedControl.frame = CGRectMake(100, 10, 220, 30);
    //        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    //        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    //        segmentedControl.selectedSegmentIndex = 1;
    //        [self addSubview:segmentedControl];
    //    }
}

//添加中间ImageView
- (void)addNavigationBarImageView:(UIImage*)image
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = image;
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(topMarginDefault * 0.5);
        make.width.equalTo(80);
        make.height.equalTo(buttonH);
    }];
    
}

//添加左边图片
- (void)addNavigationBarLeftImageView:(UIImageView*)headerImageView
{
    [self.leftImageView removeFromSuperview];
    self.leftImageView = headerImageView;
    if (self.leftImageView) {
        //        leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 24.0f, 30.0f, 30.0f)];
        self.leftImageView.frame = CGRectMake(10.0f, 24.0f, 30.0f, 30.0f);
        self.leftImageView.layer.cornerRadius = 15.0f;
        self.leftImageView.layer.masksToBounds = YES;
        [self addSubview:self.leftImageView];
        self.leftImageView.userInteractionEnabled = YES;
        [self addSingleTagToView:self.leftImageView];
    }
    
}

- (void)setTitle:(NSString*)title
{
    if (self.middleLabel != nil) {
        self.middleLabel.text = title;
    }else{
        [self addNavigationBarTitile:title];
    }
}

- (void)setLeftButtonTitle:(NSString*)btnTitle
{
    if (self.leftButton != nil) {
        [self.leftButton setTitle:btnTitle forState:UIControlStateNormal];
    }
    
}

- (void)setRightButtonTitle:(NSString*)btnTitle
{
    if (self.rightButton != nil) {
        [self.rightButton setTitle:btnTitle forState:UIControlStateNormal];
    }
}

- (void)setLeftButtonBgImage:(UIImage*)image andHlImage:(UIImage*)hlImage
{
    if (self.leftButton == nil) {
        [self addNavigationBarLeftButton:nil];
    }
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton setImage:hlImage forState:UIControlStateHighlighted];
    [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 30.0f)];
    
}


- (void)setRightButtonBgImage:(UIImage*)image andHlImage:(UIImage*)hlImage
{
    
    if (self.rightButton != nil) {
        //        float width = image.size.width;
        //        float height = image.size.height;
        //        if (height > 26) {
        //            float ration = 26 / height;
        //            width = width * ration;
        //            height = 26.0f;
        //        }
        //        float originY = 20.0f + (self.frame.size.height - 20.0f - height)/2 - 2.0f;
        //        CGRect rect = CGRectMake(278, originY, width, height);
        //        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:rect];
        //        rightImageView.image = image;
        [self.rightButton setImage:image forState:UIControlStateNormal];
        [self.rightButton setImage:hlImage forState:UIControlStateHighlighted];
        [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 30.0f, 0.0f, 0.0f)];
    }
}

//设置左按钮隐藏属性
-(void)setNavigationBarLeftButtonHidden:(BOOL)isHidden{
    
    if (self.leftButton != nil) {
        [self.leftButton setHidden:isHidden];
    }
}

-(void)setNavigationBarSecondBtnHidden:(BOOL)isHidden{
    if (self.leftSecondButton) {
        [self.leftSecondButton setHidden:isHidden];
    }
    if (self.rightsecondButton) {
        [self.rightsecondButton setHidden:isHidden];
    }
}

//点击左边标示文字事件
- (void)tapLeftLabelEvent:(id)sender
{
    [self clickLeftButtonEvent:sender];
}

//点击标题栏事件
- (void)tapMiddleLabelEvent:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapMiddleLabelEvent:)]) {
        [self.delegate tapMiddleLabelEvent:sender];
    }
}

//点击左按钮事件
-(void)clickLeftButtonEvent:(id)sender{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickCustomNavigationBarLeftButtonEvent:)]) {
        [self.delegate clickCustomNavigationBarLeftButtonEvent:sender];
    }
    
}

//点击左边第二个按钮事件
- (void)clickedLeftSecondButtonEvent:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickCustomNavigationBarLeftSecondButtonEvent:)]) {
        [self.delegate clickCustomNavigationBarLeftSecondButtonEvent:sender];
    }
}

//点击右按钮事件
-(void)clickRightButtonEvent:(id)sender{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickCustomNavigationBarRightButtonEvent:)]) {
        [self.delegate clickCustomNavigationBarRightButtonEvent:sender];
    }
}

//点击右边第二个按钮事件
- (void)clickedRightSecondButtonEvent:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickCustomNavigationBarRightSecondButtonEvent:)]) {
        [self.delegate clickCustomNavigationBarRightSecondButtonEvent:sender];
    }
}

//segment选择事件
- (void)segmentAction:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(customNavigationBarSegmentAction:)]) {
        [self.delegate customNavigationBarSegmentAction:sender];
    }
}

#pragma mark -

- (void)addSingleTagToView:(UIView*)view
{
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.delegate = self;
    [view addGestureRecognizer:singleRecognizer];
    
    
}

#pragma mark -

-(void)singleTap:(UITapGestureRecognizer*)recognizer
{
    [self clickLeftButtonEvent:recognizer.view];
}

@end
