//
//  XHMainCell.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMainCell.h"
#import "XHQQButton.h"

@interface XHMainCell ()

@property (weak, nonatomic) IBOutlet XHQQButton *qqButton;

@end
@implementation XHMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.clipsToBounds = NO;
    [_qqButton addTarget:self action:@selector(qqButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)qqButtonClick:(XHQQButton *)btn{
    
    LXHLog(@"%s", __func__);
    
}

@end
