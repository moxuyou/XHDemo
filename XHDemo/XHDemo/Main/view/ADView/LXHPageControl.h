//
//  LXHPageControl.h
//  PreciousMetal
//
//  Created by moxuyou on 2016/11/4.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXHPageControl : UIView

@property (nonatomic,assign) NSInteger numberOfPages;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) CGFloat PointSize;

@property (nonatomic,assign) CGFloat distanceOfPoint;

@property (nonatomic,assign) UIColor * currentPagePointColor;

@property (nonatomic,assign) UIColor * pagePointColor;

@end
