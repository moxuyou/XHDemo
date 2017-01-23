//
//  FYUDIDTools.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYUDIDTools : NSObject
/*
 * @brief obtain Unique Device Identity
 */
+ (NSString*)UDID;
+ (NSString*)IDFA;
+ (NSString *)getMacAddress;

@end
