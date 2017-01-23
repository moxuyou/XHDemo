//
//  NSString+StrToTime.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StrToTime)
#pragma mark 格式化时间 time = 20101213 转2013-12-13
+(NSString*)DateFormat:(NSString*)tit;

#pragma mark 格式化时间 time = 144533 转14:45:33
+(NSString*)TimeFormat:(NSString*)tit;
@end
