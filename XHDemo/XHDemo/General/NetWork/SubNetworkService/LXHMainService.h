//
//  LXHMainService.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkService.h"
#import "APIFavoriteGoodsCate.h"

@interface LXHMainService : NSObject

/** 1、获取自选界面列表数据 */
- (void)getChoosedDataWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                       failure:(FailureBlock)failure;

/** 2 添加自选商品分类 */
- (void)addChoosedGoodsWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                        failure:(FailureBlock)failure;

/** 3 修改自选商品种类顺序 */
- (void)changeChoosedGoodsWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                           failure:(FailureBlock)failure;

/** 4 删除自选商品分类 */
- (void)removeChoosedGoodsWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                           failure:(FailureBlock)failure;
// 5 (所有)商品种类列表
- (void)getAllChoosedDataWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                          failure:(FailureBlock)failure;
/** 6 监听后台推送过来的广告信息 */
- (void)getChoosedADWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                     failure:(FailureBlock)failure;
/** 7 dummy */
- (void)postChoosedDummyDataWithData:(NSDictionary *)requestData Success:(ResponseObjectResult)success
                             failure:(FailureBlock)failure;

@end
