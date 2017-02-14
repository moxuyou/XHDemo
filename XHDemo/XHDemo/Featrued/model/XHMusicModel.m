//
//  XHMusicModel.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/14.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMusicModel.h"

@implementation XHMusicModel


+ (XHMusicModel *)musicModelWithDict:(NSDictionary *)dict{
    
    XHMusicModel *model = [[XHMusicModel alloc] init];
    model.name = dict[@"name"];
    model.filename = dict[@"filename"];
    model.lrcname = dict[@"lrcname"];
    model.singer = dict[@"singer"];
    model.singerIcon = dict[@"singerIcon"];
    model.icon = dict[@"icon"];
    
    return model;
}

@end
