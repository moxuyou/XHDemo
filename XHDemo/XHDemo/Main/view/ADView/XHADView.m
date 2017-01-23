//
//  XHADView.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHADView.h"
#import "UIImageView+WebCache.h"

static int const ImageViewCount = 3;
@interface XHADView ()<UIScrollViewDelegate>

@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) UIScrollView *scrollView;

/* 当前页 */
@property(nonatomic , assign)NSInteger curronIndex;

@end
@implementation XHADView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        // 滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 图片控件
        for (int i = 0; i<ImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            [scrollView addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
            [imageView addGestureRecognizer:tap];
        }
        
        // 页码视图
        LXHPageControl *pageControl = [[LXHPageControl alloc] initWithFrame:CGRectMake(187, 135, 10, 10)];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        
    }
    return self;
}

//控制布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentSize = CGSizeMake(0, ImageViewCount * self.bounds.size.height);
    } else {
        self.scrollView.contentSize = CGSizeMake(ImageViewCount * self.bounds.size.width, 0);
    }
    
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        if (self.isScrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i * self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        } else {
            imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
    }
    
    [self updateContent];
}

//设置数据
- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 设置页码
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    
    // 开始定时器
    if (images.count > 1) {
        // 设置内容
        [self updateContent];
        
        [self startTimer];
        self.scrollView.scrollEnabled = YES;
    }else if (images.count == 1){
        
        self.scrollView.scrollEnabled = NO;
    }
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
    self.curronIndex = page;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开始定时器
    if (self.images.count > 1) {
        [self startTimer];
    }else{
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}

#pragma mark - 内容更新
//更新数据
- (void)updateContent
{
    
    if (self.images.count <= 0) {
        // 设置图片
        for (int i = 0; i<self.scrollView.subviews.count; i++) {
            
            UIImageView *imageView = self.scrollView.subviews[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"http//:www.baidu,com"] placeholderImage:[UIImage imageNamed:@"default_banner"]];
        }
        
        self.scrollView.scrollEnabled = NO;
        [self stopTimer];
        
        return;
    }
    
    // 设置图片
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.curronIndex;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.images.count - 1;
        } else if (index >= self.images.count) {
            index = 0;
        }
        imageView.tag = index;
        //设置图片
        NSDictionary *dict = self.images[index];
        
        if (dict != nil) {
            [imageView sd_setImageWithURL:dict[@"pictureUrl"] placeholderImage:[UIImage imageNamed:@"default_banner"]];
        }
        
    }
    
    // 设置偏移量在中间
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    } else {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    
    self.pageControl.center = CGPointMake(self.LXHWidth * 0.5, self.LXHHeight - self.pageControl.LXHHeight);
}

#pragma mark - 定时器处理
- (void)startTimer
{
    [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    if (self.timer == nil) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

//控制下一张图片
- (void)next
{
    //    NSLog(@"%s", __func__);
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    }
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap{
    
    if (self.images.count <= 0) {
        return;
    }
    
    NSLog(@"%s", __func__);
    
}

- (void)dealloc{
    
    [self stopTimer];
    
}


@end
