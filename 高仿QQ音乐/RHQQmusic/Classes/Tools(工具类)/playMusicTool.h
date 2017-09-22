//
//  playMusicTool.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/3.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>
@class rhMusic;

@interface playMusicTool : NSObject

+(rhMusic *)playingMusic;
+(rhMusic *)playAboveMusic;
+(rhMusic *)playNextMusic;
+ (void)setPlayingMusic:(rhMusic *)playingMusic;
@end
