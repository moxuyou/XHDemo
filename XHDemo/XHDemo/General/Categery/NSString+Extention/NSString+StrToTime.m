//
//  NSString+StrToTime.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSString+StrToTime.h"

@implementation NSString (StrToTime)



#pragma mark 格式化时间 time = 20101213 转2013-12-13
+(NSString*)DateFormat:(NSString*)tit
{
    if (tit.length < 8) {
        // 为了健状性 小于8就是不对了，直接返回tit
        return tit;
    }
    NSString * hh = [tit substringWithRange:NSMakeRange(0,4)];
    NSString * ss = [tit substringWithRange:NSMakeRange(4,2)];
    NSString * mm = [tit substringWithRange:NSMakeRange(6,2)];
    NSString * res_str = [NSString stringWithFormat:@"%@-%@-%@ ",hh,ss,mm];
    return res_str;
}





#pragma mark 格式化时间 time = 144533 转14:45:33
+(NSString*)TimeFormat:(NSString*)tit
{
    if (tit.length < 6) {
        // 为了健状性 小于6就是不对了，直接返回tit
        return tit;
    }
    NSString * hh = [tit substringWithRange:NSMakeRange(0,2)];
    NSString * ss = [tit substringWithRange:NSMakeRange(2,2)];
    NSString * mm = [tit substringWithRange:NSMakeRange(4,2)];
    NSString * res_str = [NSString stringWithFormat:@"%@:%@:%@",hh,ss,mm];
    return res_str;
}


@end
