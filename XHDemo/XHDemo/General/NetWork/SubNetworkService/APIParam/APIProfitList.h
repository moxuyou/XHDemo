//
//  APIProfitList.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIProfitList : NSObject

/** todate=今日日期(格式:"YYYY-MM-DD") Limit=获取数量限制 */
+ (NSDictionary *)getFavoriteGoodsCateDictWithCode:(NSString *)todate AndLimit:(NSString *)oprtType;

@end
