//
//  Security.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "Security.h"
#import "ClientRsaUtil.h"

@implementation Security

+ (void)test{
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSString *pwd = @"123456";
    
    ClientRsaUtil *util = [[ClientRsaUtil alloc] init];
    RSAEncryptor *publicRsa = [util getPublicKeyPath:publicKeyPath];
    RSAEncryptor *privateRsa = [util getPrivateKeyByPath:privateKeyPath andPwd:pwd];
    
    /////////////////////////////加密过程/////////////////////////////////////
    //1.私钥签名头信息,返回base64的字符串
    NSString *keyHeader = KEY_HEADER;
    NSString *strData = [privateRsa signTheDataSHA1WithRSA:keyHeader];
    
    //2.用第二部得到的结果和需要传送的数据， 公钥加密,并做base64
    NSString *strJson = nil;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:@"sample" forKey:@"account"];
    [data setValue:@"samplePwd" forKey:@"password"];
    // isValidJSONObject判断对象是否可以构建成json对象
    if ([NSJSONSerialization isValidJSONObject:data]){
        NSError *error;
        // 创造一个json从Data, NSJSONWritingPrettyPrinted指定的JSON数据产的空白，使输出更具可读性。
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",strJson);
        
    }else{
        return;
    }
    
    NSString *keyConnect = KEY_CONNECT;
    NSString *strConnected = [[NSString alloc] initWithFormat:@"%@%@%@",strJson,keyConnect,strData];
    
    NSData *encryptedData = [util encryptData:strConnected withPublicRsa:publicRsa];
    NSString *base64Data = [encryptedData base64EncodedString];
    
   // NSLog(@"base64Data:%@",base64Data);
    
    /////////////////////////////解密过程/////////////////////////////////////
    //1.解base64，得到加密后的数据
    NSData *decodedData = [base64Data base64DecodedData];
    NSData *decrypedData = [util decryptRawData:decodedData withPrivateRsa:privateRsa];
    NSString *strDecrypedData = [[NSString alloc] initWithData:decrypedData encoding:NSUTF8StringEncoding];
    
    //x509 -in ifangchou.cer -inform PEM -out ifangchou.pem -outform DER
    //2.解base64，得到签名后的数据,并验签
    NSArray *dataArray = [strDecrypedData componentsSeparatedByString:keyConnect];
    if ([dataArray count] == 2) {
        
        NSString *strJson = [dataArray objectAtIndex:0];
        NSString *headerBase64 = [dataArray objectAtIndex:1]; // NSString *headerEncrypt = [headerBase64 base64DecodedString];
        
        NSString *keyHeader = KEY_HEADER;
        BOOL isPassVerify = [util verifyWithHeaderData:keyHeader andPublicRsa:publicRsa andSign:headerBase64];
        
        NSLog(@"json:%@",strJson);
        NSLog(@"headerBase64:%@",headerBase64);
        NSLog(@"isPassVerify:%d",isPassVerify);
        
    }
}

+ (NSString *)encryptedDataWithParameterDictionary:(NSDictionary *)dataDict
                                     withHeaderKey:(NSString *)headerKey
{
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key"
                                                              ofType:@"der"];
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key"
                                                               ofType:@"p12"];
    NSString *pwd = @"123456";
    
    ClientRsaUtil *util = [[ClientRsaUtil alloc] init];
    RSAEncryptor *publicRsa = [util getPublicKeyPath:publicKeyPath];
    RSAEncryptor *privateRsa = [util getPrivateKeyByPath:privateKeyPath
                                                  andPwd:pwd];
    
    // 1.私钥签名头信息,返回base64的字符串
    NSString *keyHeader = KEY_HEADER;
    NSString *strData = [privateRsa signTheDataSHA1WithRSA:keyHeader];
    
    // 2.处理需加密参数成Json字符串
    NSString *strJson = nil;
    if ([NSJSONSerialization isValidJSONObject:dataDict])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDict
                                                           options:0
                                                             error:&error];
        strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",strJson);
        
    }
    else
    {
        return nil;
    }
    
    // 3.公钥加密,并做base64
    NSString *keyConnect = KEY_CONNECT;
    NSString *strConnected = [[NSString alloc] initWithFormat:@"%@%@%@",strJson,keyConnect,strData];
    
    NSData *encryptedData = [util encryptData:strConnected withPublicRsa:publicRsa];
    NSString *base64DataStr = [encryptedData base64EncodedString];
    
    return base64DataStr;
}

+ (id)decryptedDataWithDataString:(NSString *)dataStr
                    withHeaderKey:(NSString *)headerKey
{
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key"
                                                              ofType:@"der"];
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key"
                                                               ofType:@"p12"];
    NSString *pwd = @"123456";
    
    ClientRsaUtil *util = [[ClientRsaUtil alloc] init];
    RSAEncryptor *publicRsa = [util getPublicKeyPath:publicKeyPath];
    RSAEncryptor *privateRsa = [util getPrivateKeyByPath:privateKeyPath
                                                  andPwd:pwd];
    
    // 1.解base64，得到加密后的数据，还原成Json字符串
    NSData *decodedData = [dataStr base64DecodedData];
    NSData *decrypedData = [util decryptRawData:decodedData withPrivateRsa:privateRsa];
    NSString *strDecrypedData = [[NSString alloc] initWithData:decrypedData encoding:NSUTF8StringEncoding];
    
    // x509 -in ifangchou.cer -inform PEM -out ifangchou.pem -outform DER
    // 2.根据中间连接字符，得到签名后的数据，并验签
    NSString *keyConnect = KEY_CONNECT;
    BOOL isPassVerify = NO;
    NSString *strJson = nil;
    
    NSArray *dataArray = [strDecrypedData componentsSeparatedByString:keyConnect];
    
    if ([dataArray count] == 2)
    {
        strJson = [dataArray objectAtIndex:0];
        NSString *headerBase64 = [dataArray objectAtIndex:1]; // NSString *headerEncrypt = [headerBase64 base64DecodedString];
        
        NSString *keyHeader = KEY_HEADER;
        isPassVerify = [util verifyWithHeaderData:keyHeader
                                     andPublicRsa:publicRsa
                                          andSign:headerBase64];
    }
    if (isPassVerify)
    {
        NSData *jsonData = [strJson dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id dataObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
        return dataObject;
    }
    else
    {
        return nil;
    }
}


@end
