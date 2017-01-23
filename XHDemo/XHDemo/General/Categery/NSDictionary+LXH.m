//
//  NSDictionary+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/19.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSDictionary+LXH.h"

@implementation NSDictionary (LXH)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSString *string;
    
    @try {
        
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
    } @catch (NSException *exception) {
        
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        string = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
        
    } @finally {
        
    }
    
    return string;
}

@end
