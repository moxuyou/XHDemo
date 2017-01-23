//
//  NSString+Util.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "Base64.h"

static NSString *kSalt = @"abc!@cd";
static NSString *kKey = @"abcdefghijklmnopqrstuvwx";
static NSString *kIV = @"12345678";
static NSString *kSP = @"###";

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (Util)

//double型转变为NSString,把double型小数点后面多余的0去掉
+(NSString *)changeDouble:(double)doubleNumber
{
    NSString *stringFloat = [NSString stringWithFormat:@"%f",doubleNumber];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

//CGFloat型转变为NSString,把CGFloat型小数点后面多余的0去掉
+(NSString *)changeFloat:(CGFloat)floatNumber
{
    NSString *stringFloat = [NSString stringWithFormat:@"%f",floatNumber];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

//检查字符串是否为空
+ (BOOL)checkIsEmptyOrNull:(NSString *) string
{
    if (string && ![string isEqual:[NSNull null]] && ![string isEqual:@"(null)"] && ![string isEqualToString:@"<null>"] && [string length] > 0)
    {
        return NO;
    }
    return YES;
}

//得到中英文混合字符串长度  !!!中英文字符串
- (NSUInteger)getMixCharacterLength

{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return [da length];
}

-(BOOL)isWebURL
{
    return YES;
    //return [self isMatchedByRegex:(NSString *)webUrlRegex];
}

#pragma mark - 安全类
- (NSString *)encryptBody
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *originStr = [self copy]; // 明文JSON + ### + 当前时间(yyyyMMddHHmmss) + ###
    
    originStr = [originStr stringByAppendingString:kSP];     // ###
    originStr = [originStr stringByAppendingString:dateStr];    // yyyyMMddHHmmss
    originStr = [originStr stringByAppendingString:kSP];     // ###
    
    
    // 2. jsonStr = 明文JSON + ### + 当前时间(yyyyMMddHHmmss) + ### + 盐
    NSString *jsonStr = [originStr stringByAppendingString:kSalt];       // 加盐
    
    // 3. jsonStr = 明文JSON + ### + 当前时间(yyyyMMddHHmmss) + ### + MD5(jsonStr)
    jsonStr = [originStr stringByAppendingString:[jsonStr md5]];        // 拼接MD5
    
    // 4. jsonStr = Base64(3Des(jsonStr))
    jsonStr = [jsonStr encryptUse3DESWithkey:kKey iv:kIV];
    
    return jsonStr;
}

- (NSString *)decryptBody
{
    NSString *dencryptStr = [self decryptUse3DESWithkey:kKey iv:kIV];
    NSRange range = [dencryptStr rangeOfString:kSP];
    if (range.location == NSNotFound)
    {
        return dencryptStr;
    }
    
    NSString *bodyStr = [dencryptStr substringToIndex:range.location];
    
    // 提取 body 中的 MD5
    NSRange md5Range = [dencryptStr rangeOfString:kSP options:NSBackwardsSearch];
    NSString *md5Str = [dencryptStr substringFromIndex:md5Range.location + kSP.length];
    md5Str = md5Str.lowercaseString;
    
    // 计算出 body 的 MD5. jsonStr = 明文JSON + ### + 当前时间(yyyyMMddHHmmss) + ### + 盐
    NSString *originStr = [dencryptStr substringToIndex:md5Range.location + kSP.length];
    NSString *jsonStr = [originStr stringByAppendingString:kSalt];       // 加盐
    NSString *md5Caluate = [jsonStr md5].lowercaseString;
    
    // 比较两个 MD5 是否一致
    if (md5Caluate && md5Str && [md5Str isEqualToString:md5Caluate])
    {
        return bodyStr;
    }
    else
    {
        return nil;
    }
}

-(NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSString *)base64
{
    return @"base64";
    //    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

-(NSString *)decryptUse3DESWithkey:(NSString *)key iv:(NSString *)iv
{
    NSString *plaintext = self;
    
    // Base64 decode
    NSData *cipherdata = [plaintext dataWithBase64EncodedString];
    
    // 将key进行base64编码
    const void *vkey = (const void *) [key UTF8String];
    
    // iv
    const void *vinitVec = (const void *) [iv UTF8String];
    
    // test
    size_t bufferPtrSize = ([cipherdata length] + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t * buffer = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)buffer, 0x0, bufferPtrSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding,
                                          vkey,
                                          kCCKeySize3DES,
                                          vinitVec,
                                          [cipherdata bytes],
                                          [cipherdata length],
                                          buffer,
                                          bufferPtrSize,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess)
    {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

-(NSString *)encryptUse3DESWithkey:(NSString *)key iv:(NSString *)iv
{
    // NSString -> NSData
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void * vplainText = (const void *)[data bytes];
    
    // 将key进行base64编码
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [iv UTF8String];
    
    size_t numBytesEncrypted = 0;
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t * buffer = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)buffer, 0x0, bufferPtrSize);
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding,
                                          vkey,
                                          kCCKeySize3DES,
                                          vinitVec,
                                          vplainText,
                                          plainTextBufferSize,
                                          (void *)buffer,
                                          bufferPtrSize,
                                          &numBytesEncrypted);
    
    NSString *result = @"";
    if (cryptStatus == kCCSuccess)
    {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        result = [data base64EncodedString];
    }
    if (buffer) {
        free(buffer);
    }
    return result;
}


- (NSData *)dataWithBase64EncodedString
{
    if (self == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([self length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [self cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([self length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}


#pragma mark - XSS
-(BOOL)avoidXSSAtackWithURL:(NSString*)url
{
    if([self p_avoidXSSAtackWithSriptRex:url])
    {
        return NO;
    }
    if([self p_avoidXSSAtackWithEval:url])
    {
        return NO;
    }
    if([self p_avoidXSSAtackWithExec:url])
    {
        return NO;
    }
    if([self p_avoidXSSAtackWithimage:url])
    {
        return NO;
    }
    if([self p_avoidXSSAtackWithSimple:url])
    {
        return NO;
    }
    if([self p_avoidXSSAtackWithSQLInjection:url])
    {
        return NO;
    }
    return YES;
    
}

//检测sript
-(BOOL)p_avoidXSSAtackWithSriptRex:(NSString*)url
{
    NSString* scriptRegex = @"( \\s|\\S)*((%73)|s)(\\s)*((%63)|c)(\\s)*((%72)|r)(\\s)*((%69)|i)(\\s)*((%70)|p)(\\s)*((%74)|t)(\\s|\\S)*";
    
    NSPredicate *scriptTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",scriptRegex];
    return [scriptTest evaluateWithObject:url];
    
}

-(BOOL)p_avoidXSSAtackWithimage:(NSString *)url
{
    NSString* imageRegex = @"( \\s|\\S)*((%3C)|<)((%69)|i|I|(%49))((%6D)|m|M|(%4D))((%67)|g|G|(%47))[^\\n]+((%3E)|>)(\\s|\\S)*";
    
    NSPredicate *imageTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",imageRegex];
    return [imageTest evaluateWithObject:url];
    
}

-(BOOL)p_avoidXSSAtackWithSQLInjection:(NSString *)url
{
    NSString* SQLInjectionRegex = @"( \\s|\\S)*((%27)|(')|(%3D)|(=)|(/)|(%2F)|(\")|((%22)|(-|%2D){2})|(%23)|(%3B)|(;))+(\\s|\\S)*";
    
    NSPredicate *SQLInjectionTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",SQLInjectionRegex];
    return [SQLInjectionTest evaluateWithObject:url];
    
}

//xss攻击过滤---Eval
-(BOOL)p_avoidXSSAtackWithEval:(NSString *)url;
{
    NSString* evalRegex = @"( \\s|\\S)*((%65)|e)(\\s)*((%76)|v)(\\s)*((%61)|a)(\\s)*((%6C)|l)(\\s|\\S)*";
    
    NSPredicate *evalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",evalRegex];
    return [evalTest evaluateWithObject:url];
    
}

//xss攻击过滤---Simple
-(BOOL)p_avoidXSSAtackWithSimple:(NSString *)url
{
    NSString* simpleRegex = @"( \\s|\\S)*((%3C)|<)((%2F)|/)*[a-z0-9%]+((%3E)|>)(\\s|\\S)*";
    
    NSPredicate *simpleTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",simpleRegex];
    return [simpleTest evaluateWithObject:url];
    
}

//xss攻击过滤---Exec
-(BOOL)p_avoidXSSAtackWithExec:(NSString *)url
{
    NSString* execRegex = @"( \\s|\\S)*(exec(\\s|\\+)+(s|x)p\\w+)(\\s|\\S)*";
    
    NSPredicate *execTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",execRegex];
    return [execTest evaluateWithObject:url];
    
}

// 安卓SDK正则表达式，匹配网络连接。
const static NSString *webUrlRegex =
@"((?:(http|https|Http|Https|rtsp|Rtsp):\\/\\/(?:(?:[a-zA-Z0-9\\$\\-\\_\\.\\+\\!\\*\\'\\(\\)"
@"\\,\\;\\?\\&\\=]|(?:\\%[a-fA-F0-9]{2})){1,64}(?:\\:(?:[a-zA-Z0-9\\$\\-\\_"
@"\\.\\+\\!\\*\\'\\(\\)\\,\\;\\?\\&\\=]|(?:\\%[a-fA-F0-9]{2})){1,25})?\\@)?)?"
@"((?:(?:["
@"a-zA-Z0-9\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF"
@"]["
@"a-zA-Z0-9\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF"
@"\\-]{0,64}\\.)+"
@"(?:"
@"(?:aero|arpa|asia|a[cdefgilmnoqrstuwxz])"
@"|(?:biz|b[abdefghijmnorstvwyz])"
@"|(?:cat|com|coop|c[acdfghiklmnoruvxyz])"
@"|d[ejkmoz]"
@"|(?:edu|e[cegrstu])"
@"|f[ijkmor]"
@"|(?:gov|g[abdefghilmnpqrstuwy])"
@"|h[kmnrtu]"
@"|(?:info|int|i[delmnoqrst])"
@"|(?:jobs|j[emop])"
@"|k[eghimnprwyz]"
@"|l[abcikrstuvy]"
@"|(?:mil|mobi|museum|m[acdeghklmnopqrstuvwxyz])"
@"|(?:name|net|n[acefgilopruz])"
@"|(?:org|om)"
@"|(?:pro|p[aefghklmnrstwy])"
@"|qa"
@"|r[eosuw]"
@"|s[abcdeghijklmnortuvyz]"
@"|(?:tel|travel|t[cdfghjklmnoprtvwz])"
@"|u[agksyz]"
@"|v[aceginu]"
@"|w[fs]"
@"|(?:\u03b4\u03bf\u03ba\u03b9\u03bc\u03ae|\u0438\u0441\u043f\u044b\u0442\u0430\u043d\u0438\u0435|\u0440\u0444|\u0441\u0440\u0431|\u05d8\u05e2\u05e1\u05d8|\u0622\u0632\u0645\u0627\u06cc\u0634\u06cc|\u0625\u062e\u062a\u0628\u0627\u0631|\u0627\u0644\u0627\u0631\u062f\u0646|\u0627\u0644\u062c\u0632\u0627\u0626\u0631|\u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629|\u0627\u0644\u0645\u063a\u0631\u0628|\u0627\u0645\u0627\u0631\u0627\u062a|\u0628\u06be\u0627\u0631\u062a|\u062a\u0648\u0646\u0633|\u0633\u0648\u0631\u064a\u0629|\u0641\u0644\u0633\u0637\u064a\u0646|\u0642\u0637\u0631|\u0645\u0635\u0631|\u092a\u0930\u0940\u0915\u094d\u0937\u093e|\u092d\u093e\u0930\u0924|\u09ad\u09be\u09b0\u09a4|\u0a2d\u0a3e\u0a30\u0a24|\u0aad\u0abe\u0ab0\u0aa4|\u0b87\u0ba8\u0bcd\u0ba4\u0bbf\u0baf\u0bbe|\u0b87\u0bb2\u0b99\u0bcd\u0b95\u0bc8|\u0b9a\u0bbf\u0b99\u0bcd\u0b95\u0baa\u0bcd\u0baa\u0bc2\u0bb0\u0bcd|\u0baa\u0bb0\u0bbf\u0b9f\u0bcd\u0b9a\u0bc8|\u0c2d\u0c3e\u0c30\u0c24\u0c4d|\u0dbd\u0d82\u0d9a\u0dcf|\u0e44\u0e17\u0e22|\u30c6\u30b9\u30c8|\u4e2d\u56fd|\u4e2d\u570b|\u53f0\u6e7e|\u53f0\u7063|\u65b0\u52a0\u5761|\u6d4b\u8bd5|\u6e2c\u8a66|\u9999\u6e2f|\ud14c\uc2a4\ud2b8|\ud55c\uad6d|xn\\-\\-0zwm56d|xn\\-\\-11b5bs3a9aj6g|xn\\-\\-3e0b707e|xn\\-\\-45brj9c|xn\\-\\-80akhbyknj4f|xn\\-\\-90a3ac|xn\\-\\-9t4b11yi5a|xn\\-\\-clchc0ea0b2g2a9gcd|xn\\-\\-deba0ad|xn\\-\\-fiqs8s|xn\\-\\-fiqz9s|xn\\-\\-fpcrj9c3d|xn\\-\\-fzc2c9e2c|xn\\-\\-g6w251d|xn\\-\\-gecrj9c|xn\\-\\-h2brj9c|xn\\-\\-hgbk6aj7f53bba|xn\\-\\-hlcj6aya9esc7a|xn\\-\\-j6w193g|xn\\-\\-jxalpdlp|xn\\-\\-kgbechtv|xn\\-\\-kprw13d|xn\\-\\-kpry57d|xn\\-\\-lgbbat1ad8j|xn\\-\\-mgbaam7a8h|xn\\-\\-mgbayh7gpa|xn\\-\\-mgbbh1a71e|xn\\-\\-mgbc0a9azcg|xn\\-\\-mgberp4a5d4ar|xn\\-\\-o3cw4h|xn\\-\\-ogbpf8fl|xn\\-\\-p1ai|xn\\-\\-pgbs0dh|xn\\-\\-s9brj9c|xn\\-\\-wgbh1c|xn\\-\\-wgbl6a|xn\\-\\-xkc2al3hye2a|xn\\-\\-xkc2dl3a5ee0h|xn\\-\\-yfro4i67o|xn\\-\\-ygbi2ammx|xn\\-\\-zckzah|xxx)"
@"|y[et]"
@"|z[amw]))"
@"|(?:(?:25[0-5]|2[0-4]"
@"[0-9]|[0-1][0-9]{2}|[1-9][0-9]|[1-9])\\.(?:25[0-5]|2[0-4][0-9]"
@"|[0-1][0-9]{2}|[1-9][0-9]|[1-9]|0)\\.(?:25[0-5]|2[0-4][0-9]|[0-1]"
@"[0-9]{2}|[1-9][0-9]|[1-9]|0)\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}"
@"|[1-9][0-9]|[0-9])))"
@"(?:\\:\\d{1,5})?)"
@"(\\/(?:(?:["
@"a-zA-Z0-9\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF"
@"\\;\\/\\?\\:\\@\\&\\=\\#\\~"
@"\\-\\.\\+\\!\\*\\'\\(\\)\\,\\_])|(?:\\%[a-fA-F0-9]{2}))*)?"
@"(?:\\b|$)";

@end

