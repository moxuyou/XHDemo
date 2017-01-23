//
//  NSString+Util.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

//double型转变为NSString,把double型小数点后面多余的0去掉
+(NSString *)changeDouble:(double)doubleNumber;

//把CGFloat型小数点后面多余的0去掉
+(NSString *)changeFloat:(CGFloat)floatNumber;

//检查字符串是否为空
+ (BOOL)checkIsEmptyOrNull:(NSString *) string;

//得到中英文混合字符串长度  !!!中英文字符串
- (NSUInteger)getMixCharacterLength;

// 判定是否为URL
- (BOOL)isWebURL;

//xss攻击过滤script，image，SQL Injection，Eval，Simple，Exec
-(BOOL)avoidXSSAtackWithURL:(NSString*)url;

#pragma mark -
/**
 * HTTP post body 的加密算法
 */
- (NSString *)encryptBody;

/**
 * HTTP response body 解密算法
 */
- (NSString *)decryptBody;

// MD5加密
-(NSString *)md5;

// Base64
-(NSString *)base64;

// Base64 String -> NSData
- (NSData *)dataWithBase64EncodedString;

// 3Des + Base64 加密
-(NSString *)encryptUse3DESWithkey:(NSString *)key iv:(NSString *)iv;

// 3Des + Base64 解密
-(NSString *)decryptUse3DESWithkey:(NSString *)key iv:(NSString *)iv;

@end
