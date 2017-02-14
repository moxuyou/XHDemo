//
//  XHMusicModel.h
//  XHDemo
//
//  Created by moxuyou on 2017/2/14.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHMusicModel : NSObject

/** 歌曲名称 */
@property (copy, nonatomic) NSString *name;
/** 文件名称 */
@property (copy, nonatomic) NSString *filename;
/** 歌词 */
@property (copy, nonatomic) NSString *lrcname;
/** 歌手 */
@property (copy, nonatomic) NSString *singer;
/** 歌手头像 */
@property (copy, nonatomic) NSString *singerIcon;
/** 大图标 */
@property (copy, nonatomic) NSString *icon;

+ (XHMusicModel *)musicModelWithDict:(NSDictionary *)dict;

@end
