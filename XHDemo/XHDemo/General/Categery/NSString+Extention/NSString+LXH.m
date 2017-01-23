//
//  NSString+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/16.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSString+LXH.h"

@implementation NSString (LXH)

/** 判断字符串是否为空 */
+ (BOOL)isNilString:(NSString *)string{
    
    BOOL result = NO;
    if ([string isEqualToString:@""] || string == nil || [string isKindOfClass:[NSNull class]]) {
        result = YES;
    }
    
    return result;
}

@end
