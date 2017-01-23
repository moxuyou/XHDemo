//
//  BaseDataModel.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 记录用户登录信息
 例：
 登录状态、用户名、用户密码、身份证、手机号、真实姓名、用户头像、session
    
 
 */


@interface BaseDataModel : NSObject

@property (nonatomic,readonly, assign) BOOL isLogin;

@property (nonatomic,assign) int64_t userId;//由userId判断登录状态

@property (nonatomic,copy) NSString *sessionId;

@property (nonatomic,strong) UIImage *avatarImage;
/// 真实姓名
@property (nonatomic,copy) NSString *realName;
/// 身份证
@property (nonatomic,copy) NSString *idCardNum;
// 推荐人手机
@property (nonatomic,strong) NSString *recommenderAccount;

@property (nonatomic,assign) BOOL hadShownTutorial;

@property (nonatomic,strong) NSString *mobile;

@property (nonatomic,strong) NSString *headerImageUrl;

@property (nonatomic,assign) BOOL hasPopView;

+ (instancetype)sharedModel;

@end
