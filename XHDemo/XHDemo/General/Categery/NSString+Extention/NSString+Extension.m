//
//  NSString+Extension.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
