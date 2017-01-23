//
//  LXHMainService.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHMainService.h"
#import "FYUDIDTools.h"
#import "APIParams.h"
#import "APIUser.h"

@implementation LXHMainService

// 1 获取自选主界面列表数据
- (void)getChoosedDataWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                       failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    //RequestParams
//    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"getFavoriteGoodsCate"];
//    [parameter setObject:requestParams forKey:@"RequestParams"];
//    //User
//    NSDictionary *userDict = [APIUser getUserDict];
//    //在没有登陆的时候返回的是热门数据，登陆之后返回的是用户自选数据
//    if (userDict != nil) {
//        [parameter setObject:userDict forKey:@"User"];
//    }
//    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    NSDictionary *RegistrationID = @{
                                            @"deviceId" : @"07B80C36-6F28-4915-AA5E-37C13F478A5E",
                                            @"idfa" : @"07B80C36-6F28-4915-AA5E-37C13F478A5E",
                                            @"idfv" : @"75BF3D40-48BD-4042-9D5C-7AF1E432068A",
                                            @"imei" : @"080B44A0-20AB-47A6-969C-D9BBDF57DF27",
                                            @"interfaceName" : @"getFavoriteGoodsCate",
                                            @"platform" : @2,
                                            @"version" : @"1.3"
                                            };
    NSDictionary *User = @{
                                     @"sessionId" : @"1d0163eac70baa3b2f1223c3df121275",
                                     @"userId" : @"8"
                                     };
    parameter[@"User"] = User;
    parameter[@"RegistrationID"] = RegistrationID;
    
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}

// 2 添加自选商品分类
- (void)addChoosedGoodsWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                        failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    
    //RequestParams
    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"addFavoriteGoodsCate"];
    [parameter setObject:requestParams forKey:@"RequestParams"];
    
    //User
    NSDictionary *userDict = [APIUser getUserDict];
    [parameter setObject:userDict forKey:@"User"];
    
    //FavoriteGoodsCate
    NSString *industryCode = requestData[@"industryCode"];
    NSString *oprtType = requestData[@"oprtType"];
    NSString *orderNum = requestData[@"orderNum"];
    NSDictionary *goodsDict = [APIFavoriteGoodsCate getFavoriteGoodsCateDictWithCode:industryCode AndType:oprtType AndOrderNum:orderNum];
    [parameter setObject:goodsDict forKey:@"FavoriteGoodscate"];
    
    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    
    // 发送请求
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}


// 3 修改自选商品种类顺序
- (void)changeChoosedGoodsWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                           failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    
    //RequestParams
    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"updtFavoriteGoodsCateOrder"];
    [parameter setObject:requestParams forKey:@"RequestParams"];
    
    //User
    NSDictionary *userDict = [APIUser getUserDict];
    [parameter setObject:userDict forKey:@"User"];
    
    //FavoriteGoodsCate
    NSString *industryCode = requestData[@"industryCode"];
    NSString *oprtType = requestData[@"oprtType"];
    NSString *orderNum = requestData[@"orderNum"];
    NSDictionary *goodsDict = [APIFavoriteGoodsCate getFavoriteGoodsCateDictWithCode:industryCode AndType:oprtType AndOrderNum:orderNum];
    [parameter setObject:goodsDict forKey:@"FavoriteGoodsCate"];
    
    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    
    // 发送请求
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}


// 4 删除自选商品分类
- (void)removeChoosedGoodsWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                           failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    
    //RequestParams
    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"delFavoriteGoodsCate"];
    [parameter setObject:requestParams forKey:@"RequestParams"];
    
    //User
    NSDictionary *userDict = [APIUser getUserDict];
    [parameter setObject:userDict forKey:@"User"];
    
    //FavoriteGoodsCate
    NSString *industryCode = requestData[@"industryCode"];
    NSString *oprtType = requestData[@"oprtType"];
    NSString *orderNum = requestData[@"orderNum"];
    NSDictionary *goodsDict = [APIFavoriteGoodsCate getFavoriteGoodsCateDictWithCode:industryCode AndType:oprtType AndOrderNum:orderNum];
    [parameter setObject:goodsDict forKey:@"FavoriteGoodscate"];
    
    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    
    // 发送请求
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}

// 5 (所有)商品种类列表
- (void)getAllChoosedDataWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                          failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    
    //RequestParams
    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"getGoodsCateList"];
    [parameter setObject:requestParams forKey:@"RequestParams"];
    
    //User
    NSDictionary *userDict = [APIUser getUserDict];
    //在没有登陆的时候返回的是热门数据，登陆之后返回的是用户自选数据
    if (userDict != nil) {
        [parameter setObject:userDict forKey:@"User"];
    }
    
    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    
    // 发送请求
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}

// 6 监听后台推送过来的广告信息
- (void)getChoosedADWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                     failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    
    //RequestParams
    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"getAdvertisement"];
    [parameter setObject:requestParams forKey:@"RequestParams"];
    
    //页面类型[1=首页|2=交易页|8=发现页|16开屏]
    NSDictionary *adType = @{@"pageType" : @"1"};
    [parameter setObject:adType forKey:@"Ad"];
    
    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    
    // 发送请求
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}

// 7 dummy
- (void)postChoosedDummyDataWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                             failure:(FailureBlock)failure
{
    // 请求参数parameter
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    
    //RequestParams
    NSMutableDictionary * requestParams = [APIParams GetRequestParamsWithInterfaceName:@"addDelFavoriteGoodsCate"];
    [parameter setObject:requestParams forKey:@"RequestParams"];
    
    //User
    NSDictionary *userDict = [APIUser getUserDict];
    [parameter setObject:userDict forKey:@"User"];
    
    //FavoriteGoodsCate
    NSString *industryCode = requestData[@"industryCode"];
    NSString *oprtType = requestData[@"oprtType"];
    NSString *orderNum = requestData[@"orderNum"];
    NSDictionary *goodsDict = [APIFavoriteGoodsCate getFavoriteGoodsCateDictWithCode:industryCode AndType:oprtType AndOrderNum:orderNum];
    [parameter setObject:goodsDict forKey:@"FavoriteGoodscate"];
    
    // url
    NSString *url = url_path;
    NetworkService *service = [[NetworkService alloc] init];
    
    // 发送请求
    [service POST:url
       parameters:parameter
    responseClass:[ResponseObject class]
          success:^(ResponseObject *object)
     {
         success(object);
     }
          failure:failure];
}


@end
