//
//  NSString+DES.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSString+DES.h"
#import "Base64.h"
#import "MF_Base64Additions.h"

#import "CommonCrypto/CommonDigest.h"
#import "CommonCrypto/CommonCryptor.h"
@implementation NSString (DES)


const NSString *key = @"1234abcd";
const NSString *iv = @"12345678";

+(NSString *) encryptUseDES:(NSString *)plainText withKey:(NSString *)encryKey
{
    NSData* ivData = [iv dataUsingEncoding: NSUTF8StringEncoding];
    Byte *ivBytes = (Byte *)[ivData bytes];
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    NSUInteger padd = dataLength/1024;
    NSUInteger length = (padd +1)*1024;
    
    unsigned char buffer[length];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [encryKey UTF8String], kCCKeySizeDES,
                                          ivBytes,
                                          [textData bytes], dataLength,
                                          buffer, length,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64String];
    }
    return ciphertext;
}

+(NSString *)decryptUseDES:(NSString *)cipherText withKey:(NSString *)decryKey
{
    NSData* ivData = [iv dataUsingEncoding: NSUTF8StringEncoding];
    Byte *ivBytes = (Byte *)[ivData bytes];
    NSString *plaintext = nil;
    NSData *cipherdata = [NSData dataWithBase64String:cipherText];
    long  bufferPtrSize = ([cipherdata length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    unsigned char buffer[bufferPtrSize];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [decryKey UTF8String], kCCKeySizeDES,
                                          ivBytes,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, bufferPtrSize,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

@end
