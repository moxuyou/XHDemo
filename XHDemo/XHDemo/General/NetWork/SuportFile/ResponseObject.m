//
//  ResponseObject.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//
#import "ResponseObject.h"
#import "Security.h"

@implementation ResponseObject

@synthesize data;

//@override
- (void)decryptData
{
#ifdef FCNetWorkingSecurityEnable
    if (identifyingCode.length > 0)
    {
        id responseData = [Security decryptedDataWithDataString:(NSString *)self.data
                                                  withHeaderKey:identifyingCode];
        data = responseData;
    }
#endif
}

@end
