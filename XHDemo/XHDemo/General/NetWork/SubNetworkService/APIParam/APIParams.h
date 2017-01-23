//
//  APIParams.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIParams : NSObject

+(NSMutableDictionary*)GetRequestParams;

+(NSMutableDictionary*)GetRequestParamsWithInterfaceName:(NSString*)interfaceName;

@end
