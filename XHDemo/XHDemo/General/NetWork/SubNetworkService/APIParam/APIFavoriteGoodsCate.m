//
//  APIFavoriteGoodsCate.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "APIFavoriteGoodsCate.h"

@implementation APIFavoriteGoodsCate

+ (NSDictionary *)getFavoriteGoodsCateDictWithCode:(NSString *)industryCode AndType:(NSString *)oprtType AndOrderNum:(NSString *)orderNum{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //商品分类行业代码
    if (industryCode != nil) {
        [dict setObject:industryCode forKey:@"industryCode"];
    }
    
    //操作类型[1=增加|2=删除]
    if (oprtType != nil) {
        NSInteger index = [oprtType integerValue];
        NSNumber *num = [NSNumber numberWithInteger:index];
        [dict setObject:num forKey:@"oprtType"];
    }
    
    //置顶时，待设置的目标序号(从上往下由0--n)
    if (orderNum != nil) {
        NSInteger index = [orderNum integerValue];
        NSNumber *num = [NSNumber numberWithInteger:index];
        [dict setObject:num forKey:@"orderNum"];
    }
    
    return dict;
}

@end
