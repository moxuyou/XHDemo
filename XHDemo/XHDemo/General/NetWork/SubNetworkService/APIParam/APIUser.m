//
//  APIUser.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "APIUser.h"

@implementation APIUser

+ (NSMutableDictionary*)getUserDict
{
#warning 暂时不处理，日后用来处理登录信息
    NSDictionary * usr_psp = nil;
    
//    if (usr_psp == nil) {
//        // 没有登录
//        return nil;
//    }
    
    NSMutableDictionary * User_dic = [[NSMutableDictionary alloc]init];
    [User_dic setValue:usr_psp[@"sessionId"] forKey:@"sessionId"];
    [User_dic setValue:usr_psp[@"userId"] forKey:@"userId"];
    
    return User_dic;
}

+ (BOOL)getUserLoginStatus
{
#warning 暂时不处理，日后用来处理登录信息
    NSDictionary * usr_psp = nil;
    
    return usr_psp?YES:NO;
}


@end
