//
//  ClientRsaUtil.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//


//客户端：私钥签名，公钥加密
//服务器：私钥解密，公钥验签

#import <Foundation/Foundation.h>
#import "RSAEncryptor.h"
#import "define.h"
#import "Base64.h"

@interface ClientRsaUtil : NSObject

/*
 @abstract 获取公钥实例对象
 @param certPath:公钥文件路径
 */
- (RSAEncryptor*)getPublicKeyPath:(NSString*)certPath;

/*
 @abstract 获取私钥实例对象
 @param certPath:私钥文件路径
 @param pwd:密码
 */
- (RSAEncryptor*)getPrivateKeyByPath:(NSString*)certPath andPwd:(NSString*)pwd;

/*
 @abstract 获取加密后的数据
 @param data:待加密的明文数据
 @param publicRsa:公钥实例对象
 */
- (NSData*)encryptData:(NSString*)data withPublicRsa:(RSAEncryptor*)publicRsa;

/*
 @abstract 获取解密后的明文
 @param rawData:公钥加密后的数据
 @param privateRsa:私钥实例对象
 */
- (NSData*)decryptRawData:(NSData*)rawData withPrivateRsa:(RSAEncryptor*)privateRsa;

/*
 @abstract 获取签名后的数据
 @param data:需要签名的数据
 @param privateRsa:私钥实例对象
 */
- (NSString*)signData:(NSString*)data withPrivateRsa:(RSAEncryptor*)privateRsa;

/*
 @abstract 是否通过签名验证
 @param data:头信息明文
 @param publicRsa:公钥实例对象
 @param sign:头信息用私钥签名后的信息
 */
- (BOOL)verifyWithHeaderData:(NSString*)data andPublicRsa:(RSAEncryptor*)publicRsa andSign:(NSString*)sign;

@end
