//
//  APIFavoriteGoodsCate.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIFavoriteGoodsCate : NSObject

/** 操作类型[1=增加|2=删除] */
+ (NSDictionary *)getFavoriteGoodsCateDictWithCode:(NSString *)industryCode AndType:(NSString *)oprtType AndOrderNum:(NSString *)orderNum;

@end
