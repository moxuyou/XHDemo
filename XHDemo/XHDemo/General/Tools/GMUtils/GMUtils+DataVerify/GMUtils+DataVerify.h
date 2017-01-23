//
//  GMUtils+DataVerify.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "GMUtils.h"

@interface GMUtils (DataVerify)

/**
 验证电话号码是否合法
 @param     mobileNum   NSString    用于判断的电话号码
 @return    BOOL
 */
+ (BOOL)validateMobileNum:(NSString *)mobileNum;

/**
 验证身份证是否合法
 @param     identityCard    NSString    身份证卡
 @return    BOOL    
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

@end
