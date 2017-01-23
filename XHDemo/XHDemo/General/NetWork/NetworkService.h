//
//  NetworkService.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ResponseObject.h"
#import "MUResponseSerializer.h"

typedef void(^FailureBlock)(NSError *error);

@interface NetworkService : NSObject


/*
 图像不用加密
 */
- (void)uploadimgWithurl:(NSString *)urlStr
                   image:(UIImage *)image
                fileName:(NSString *)fileName
                   param:(NSDictionary *)param
                 success:(void (^)(id responseObject))success
                    fail:(void (^)())fail;

/**
 POST请求
 param urlString   NSString        请求url
 param parameter   id              请求参数
 param aClass      Class           响应返回的数据类型
 */
- (void)POST:(NSString *)urlString
  parameters:(id)parameters
responseClass:(Class)aClass
     success:(void (^)(id object))success
     failure:(void (^)(NSError *error))failure;

/**
 
 */
- (void)POSTInBody:(NSString *)urlString
        parameters:(NSDictionary *)parameters
     responseClass:(Class)aClass
           success:(void (^)(id))success
           failure:(void (^)(NSError *))failure;

/**
 @brief 通过基本参数生成的参数字典(包括参数:"userid","session")
 @return    NSMutableDictionary*  若未登录返回nil
 */
- (NSMutableDictionary *)createParameterDictionary;

/**
 @brief 把请求参数打包成para={}格式
 @return    NSDictionary*    返回打包好的数据
 */
- (NSDictionary *)packupParameterWithDictionary:(NSDictionary *)parameter;

/**
 @brief 通过传入uri获取完整请求路径
 @param uri     相对地址(/xxxxx/xxxx)
 */
//- (NSString *)hostURLWithUri:(NSString *)uri;

/**
 @brief 获取时间戳字符串
 */
- (NSString *)getTimeStamp;


/**
 专门为去appstore检测版本信息所调用的接口；
 param urlString   NSString        请求url
 param parameter   id              请求参数
 */
- (void)GetForVersionCheck:(NSString *)urlString
                parameters:(id)parameters success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;
 

@end
