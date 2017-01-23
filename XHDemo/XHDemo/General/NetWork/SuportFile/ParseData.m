//
//  ParseData.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "ParseData.h"
#import "NSString+json.h"
#import "CRSA.h"
#import "NSString+DES.h"
#import "JSONKit.h"

@implementation ParseData

+ (id)parseDataWithData:(NSString *)data
{
    NSString* strResponse = data;
    id response = [strResponse jsonValue];
    NSString *rKey_keyStr = [response objectForKey:@"rKey"];
    NSString * desKeyString = [[CRSA shareInstance] decryptByRsa:rKey_keyStr withKeyType:KeyTypePublic];
    //用得到的key  DES 解密得到数据
    NSString *rData_valueStr = [response objectForKey:@"rData"];
    NSString * desValueString = [NSString decryptUseDES:rData_valueStr withKey:desKeyString];
    NSData *desValueData = [desValueString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * desValueDic = [desValueData objectFromJSONData];
    
    return desValueDic;

}


@end
