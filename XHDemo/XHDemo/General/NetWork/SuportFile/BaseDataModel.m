//
//  BaseDataModel.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "BaseDataModel.h"

@implementation BaseDataModel

+ (instancetype)sharedModel
{
    static BaseDataModel* sharedModel = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}





@end
