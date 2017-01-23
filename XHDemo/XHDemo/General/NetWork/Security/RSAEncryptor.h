//
//  RSAEncryptor.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject

#pragma mark - Instance Methods

-(SecKeyRef)getPublicKey;

-(SecKeyRef)getPrivateKey;

-(void)loadPublicKeyFromFile: (NSString*)derFilePath;
-(void)loadPublicKeyFromData: (NSData*)derData;

-(void)loadPrivateKeyFromFile: (NSString*)p12FilePath password:(NSString*)p12Password;
-(void)loadPrivateKeyFromData: (NSData*)p12Data password:(NSString*)p12Password;

-(NSString*)rsaEncryptString:(NSString*)string;
-(NSData*)rsaEncryptData:(NSData*)data ;

-(NSString*)rsaDecryptString:(NSString*)string;
-(NSData*)rsaDecryptData:(NSData*)data;

-(BOOL)rsaSHA1VerifyData:(NSData *) plainData
            withSignature:(NSData *) signature;

-(NSString *)signTheDataSHA1WithRSA:(NSString *)plainText;


@end
