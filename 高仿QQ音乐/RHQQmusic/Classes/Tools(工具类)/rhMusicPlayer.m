//
//  rhMusicPlayer.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/3.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "rhMusicPlayer.h"
@implementation rhMusicPlayer
static NSMutableDictionary *_playList;
//初始化类的方法
+(void)initialize{
    if (_playList == nil) {
        _playList = [NSMutableDictionary dictionary];
    }
}
#pragma mark - 根据歌曲名称停止播放歌曲
+(void)stopMusicWithName:(NSString *)musicName{
    assert(musicName);

    AVAudioPlayer *player = _playList[musicName];
    if (player) {
        [player stop];
        [_playList removeObjectForKey:musicName];
        player = nil;
    }

}

#pragma mark - 根据歌曲名字暂停歌曲
+(void)pauseMusicWithName:(NSString *)musicName{
    AVAudioPlayer *player = _playList[musicName];
    if (player) {
        [player pause];
    }
}

#pragma mark - 根据歌曲的名字播放歌曲
+(AVAudioPlayer *)playMusicWithName:(NSString *)musicName{
    //初始化播放器
    AVAudioPlayer *player = nil;
    
    player = _playList[musicName];
    
    if (player == nil) {
        //获取文件路径
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:filePath error:nil];
        
        [_playList setObject:player forKey:musicName];
        
        [player prepareToPlay];
    }
    [player play];
    return  player;
}
@end
