//
//  URLconfig.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//


#import "AppDelegate.h"
#ifndef URLconfig_h
#define URLconfig_h

#define M_BASE_URL      [UrlConfigUtil shareInstance].mBaseUrl
#define Host            [UrlConfigUtil shareInstance].host
#define SHARE_BASE_URL  [UrlConfigUtil shareInstance].shareBaseUrl

#define APP_BASE_URL    [M_BASE_URL stringByAppendingString:@"/app?"]

#endif /* URLconfig_h */
