//
//  NSDate+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSDate+LXH.h"

@implementation NSDate (LXH)

/** 时间戳转换为字符串格式yyyy-MM-dd HH:mm:ss */
+(NSString*)DateToFormatString:(NSString*)date_st
{
    
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[dateFormatter setTimeStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的时间格式
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

/** 时间戳转换为字符串格式 yyyy-MM-dd */
+(NSString*)nianDateToFormatString:(NSString*)date_st
{
    
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

/** 时间戳转换为字符串格式 HH:mm:ss*/
+(NSString*)hourDateToFormatString:(NSString*)date_st
{
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

@end
