//
//  NSString+DES.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (DES)
+(NSString *)encryptUseDES:(NSString *)plainText withKey:(NSString *)encryKey;
+(NSString *)decryptUseDES:(NSString *)cipherText withKey:(NSString *)decryKey;


@end
