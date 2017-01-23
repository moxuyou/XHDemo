//
//  JsonDealUtil.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonDealUtil : NSObject

/**
 *  字典转化为json字符串；
 *
 *  param diction 字典
 *
 *  return 返回json 字符串；
 */
+ (NSString *)toJsonWithObj:(id)jsonObj;

+ (id)jsonObject:(NSString *)js;



+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

@end
