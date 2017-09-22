//
//  playMusicTool.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/3.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "playMusicTool.h"
#import "MJExtension.h"
#import "rhMusic.h"

@implementation playMusicTool

static rhMusic *_playingMusic;

static NSArray *_musicList;



#pragma mark - 初始化数据
+(void)initialize{
    
    if (_musicList == nil) {
        _musicList = [rhMusic objectArrayWithFilename:@"Musics.plist"];
    }
    if (_playingMusic == nil) {
        _playingMusic = _musicList[0];
    }
}
#pragma mark - 获取播放音乐的模型

+(rhMusic *)playingMusic{
    return _playingMusic;
}

+ (void)setPlayingMusic:(rhMusic *)playingMusic
{
    _playingMusic = playingMusic;
}

#pragma mark - 播放上一首歌曲
+(rhMusic *)playAboveMusic{
    
    rhMusic *playingMusic = nil;
    
    //获取当前播放歌曲的下标
    NSInteger currentIndex = [_musicList indexOfObject:_playingMusic];
    
    //取出上首歌曲的下标
    NSInteger aboveIndex = currentIndex - 1;
    
    //判断如果为第一首歌曲跳到最后一首
    if (aboveIndex < 0) {
        aboveIndex = _musicList.count - 1;
    }
    //将上一首的模型赋值给正在播放
    playingMusic = _musicList[aboveIndex];
    
    return playingMusic;
}
#pragma mark - 播放下一首歌曲
+(rhMusic *)playNextMusic{
    
    rhMusic *playingMusic = nil;

    //获取当前播放的下标
    NSInteger currentIndex = [_musicList indexOfObject:_playingMusic];
    
    //取出下一首歌曲的下标
    NSInteger nextIndex = currentIndex + 1;
    //如果当前播放的为最后一首切换成第一首歌曲
    if (nextIndex > _musicList.count - 1) {
        nextIndex = 0;
    }
    //将下一首歌曲的模型赋值给正在播放的模型
    playingMusic = _musicList[nextIndex];
    
    return playingMusic;
}
@end
