//
//  XHMusicPlayTitleView.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/14.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMusicPlayTitleView.h"

@interface XHMusicPlayTitleView ()

/** 更多按钮 */
@property (weak, nonatomic)UIButton *moreButton;

@end
@implementation XHMusicPlayTitleView

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.LXHWidth, 30)];
        label.center = CGPointMake(self.center.x, self.LXHHeight - 35);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        [self addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)titleDetailLabel{
    
    if (_titleDetailLabel == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.LXHWidth, 20)];
        label.center = CGPointMake(self.center.x, self.LXHHeight - 10);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        _titleDetailLabel = label;
    }
    return _titleDetailLabel;
}

- (UIButton *)moreButton{
    
    if (_moreButton == nil) {
        
        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        moreBtn.center = CGPointMake(self.LXHWidth - 25, self.LXHHeight - 20);
        [moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn setImage:[UIImage imageNamed:@"main_tab_more"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"main_tab_more_h"] forState:UIControlStateNormal];
        [self addSubview:moreBtn];
        
        _moreButton = moreBtn;
    }
    return _moreButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self titleDetailLabel];
        [self titleLabel];
        [self moreButton];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.moreButton.center = CGPointMake(self.LXHWidth - 25, self.LXHHeight - 20);
    self.titleDetailLabel.center = CGPointMake(self.center.x, self.LXHHeight - 10);
    self.titleLabel.center = CGPointMake(self.center.x, self.LXHHeight - 35);
    
}

- (void)moreButtonClick{
    
    NSLog(@"%s", __func__);
}
@end
