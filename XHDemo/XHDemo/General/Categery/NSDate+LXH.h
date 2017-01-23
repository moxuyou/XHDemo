//
//  NSDate+LXH.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LXH)

/** 时间戳转换为字符串格式yyyy-MM-dd HH:mm:ss */
+(NSString*)DateToFormatString:(NSString*)date_st;
/** 时间戳转换为字符串格式 HH:mm:ss*/
+(NSString*)hourDateToFormatString:(NSString*)date_st;
/** 时间戳转换为字符串格式 yyyy-MM-dd */
+(NSString*)nianDateToFormatString:(NSString*)date_st;

@end
