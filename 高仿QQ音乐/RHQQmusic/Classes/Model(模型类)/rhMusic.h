//
//  rhMusic.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/2.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rhMusic : NSObject
/** 歌曲名称 */
@property (nonatomic, copy) NSString *name;

/** 歌手名称 */
@property (nonatomic, copy) NSString *singer;

/** 歌手写真 */
@property (nonatomic, copy) NSString *singerIcon;

/** 歌曲代号 */
@property (nonatomic, copy) NSString *filename;

/** 歌词 */
@property (nonatomic, copy) NSString *lrcname;

/** 歌手大图 */
@property (nonatomic, copy) NSString *icon;
@end
