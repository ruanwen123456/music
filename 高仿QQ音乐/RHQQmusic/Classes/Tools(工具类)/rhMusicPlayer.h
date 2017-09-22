//
//  rhMusicPlayer.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/3.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface rhMusicPlayer : NSObject
+(AVAudioPlayer *)playMusicWithName:(NSString *)musicName;
+(void)stopMusicWithName:(NSString *)musicName;
+(void)pauseMusicWithName:(NSString *)musicName;
@end
