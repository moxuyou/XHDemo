//
//  APIUser.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIUser : NSObject

+ (NSMutableDictionary*)getUserDict;

+ (BOOL)getUserLoginStatus;

@end