//
//  LXHPageControl.m
//  PreciousMetal
//
//  Created by moxuyou on 2016/11/4.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "LXHPageControl.h"

@implementation LXHPageControl


- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.PointSize = 10;
        self.distanceOfPoint = 15;
        self.currentPagePointColor = [UIColor redColor];
        self.pagePointColor = [UIColor greenColor];
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.subviews.count <= 0) {
        return;
    }
    CGFloat W = self.LXHWidth / self.numberOfPages - self.distanceOfPoint;
    CGFloat H = self.LXHHeight;
    NSInteger count = 0;
    for (UIImageView *subView in self.subviews) {
        
        CGFloat X = count * (self.distanceOfPoint + W);
        CGFloat Y = 0;
        subView.frame = CGRectMake(X, Y, W, H);
        
        count++;
    }
    
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    
    _numberOfPages = numberOfPages;
    //删除全部子控件
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (numberOfPages <= 0) {
        return;
    }else if (numberOfPages == 1){
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    self.frame = CGRectMake(0, 0, numberOfPages * (self.PointSize + self.distanceOfPoint), self.PointSize);
    CGFloat W = self.LXHWidth / numberOfPages - self.distanceOfPoint;
    CGFloat H = self.LXHHeight;
    for (int i = 0; i < numberOfPages; i++) {
        
        UIImageView * pointImageView = [[UIImageView alloc] init];
//        UIViewContentMode contentMode; 
        pointImageView.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat X = i * (self.distanceOfPoint + W);
        CGFloat Y = 0;
        pointImageView.frame = CGRectMake(X, Y, W, H);
        
        [self addSubview:pointImageView];
        
    }
    
}


- (void)setCurrentPage:(NSInteger)currentPage{
    
    _currentPage = currentPage;
    
    NSInteger countOfPages = [self.subviews count];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < countOfPages; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        if (subviewIndex == currentPage) {
            
            subview.image = [UIImage imageNamed:@"find_bannerPiont_sel"];
            
        }else{
            
            subview.image = [UIImage imageNamed:@"find_bannerPiont_nor"];
            
        }
        
    }
    
}

@end
