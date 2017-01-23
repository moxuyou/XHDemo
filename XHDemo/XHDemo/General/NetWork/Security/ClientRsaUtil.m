//
//  ClientRsaUtil.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "ClientRsaUtil.h"

@implementation ClientRsaUtil

- (RSAEncryptor*)getPublicKeyPath:(NSString*)certPath
{
    RSAEncryptor *publicRsa = [[RSAEncryptor alloc] init];
    [publicRsa loadPublicKeyFromFile:certPath];
    return publicRsa;
}

- (RSAEncryptor*)getPrivateKeyByPath:(NSString*)certPath andPwd:(NSString*)pwd{
    
    RSAEncryptor *privateRsa = [[RSAEncryptor alloc] init];
    [privateRsa loadPrivateKeyFromFile:certPath password:pwd];
    return privateRsa;
}

- (NSData*)encryptData:(NSString*)data withPublicRsa:(RSAEncryptor*)publicRsa
{
    NSData *tempData = [data dataUsingEncoding:NSUTF8StringEncoding];
   return [publicRsa rsaEncryptData:tempData];

}

- (NSData*)decryptRawData:(NSData*)rawData withPrivateRsa:(RSAEncryptor*)privateRsa
{
    return [privateRsa rsaDecryptData:rawData];
    
}

- (NSString*)signData:(NSString*)data withPrivateRsa:(RSAEncryptor*)privateRsa
{
    return [privateRsa signTheDataSHA1WithRSA:data];
}

- (BOOL)verifyWithHeaderData:(NSString*)data andPublicRsa:(RSAEncryptor*)publicRsa andSign:(NSString*)sign
{
    NSData *signatureData = [sign base64DecodedData];
    NSData *headerData = [data dataUsingEncoding:NSUTF8StringEncoding];
    return  [publicRsa rsaSHA1VerifyData:headerData withSignature:signatureData];
}

@end
