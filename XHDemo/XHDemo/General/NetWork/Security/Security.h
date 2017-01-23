//
//  Security.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Security : NSObject

+ (void)test;

/**
 加密方法，传入para = {}字典进行加密
 @return 加密后的字符串
 */
+ (NSString *)encryptedDataWithParameterDictionary:(NSDictionary *)dataDict
                                     withHeaderKey:(NSString *)headerKey;

/**
 解密方法，传入密文和
 @return 解密后的数据，类型可能为[NSDictionary]或[NSString]
 */
+ (id)decryptedDataWithDataString:(NSString *)dataStr
                    withHeaderKey:(NSString *)headerKey;

@end
