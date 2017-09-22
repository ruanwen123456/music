//
//  ViewController.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/6/29.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIImageView+RHImageViewcatalogue.h"
#import "CALayer+RhCaLayerAnimate.h"
#import <AVFoundation/AVFoundation.h>
#import "playMusicTool.h"
#import "rhMusic.h"
#import "rhMusicPlayer.h"
#import "NSString+timeString.h"
#import "LrcView.h"
#import "LrcLabel.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()<UIScrollViewDelegate>
//暂停开始按钮
@property (weak, nonatomic) IBOutlet UIButton *begainEndBtn;

//歌曲名
@property (weak, nonatomic) IBOutlet UILabel *musicName;
//歌手名
@property (weak, nonatomic) IBOutlet UILabel *singerName;
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
//旋转图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//歌词控件
@property (weak, nonatomic) IBOutlet LrcLabel *lrcLabel;
//滑块
@property (weak, nonatomic) IBOutlet UISlider *sliderPro;
//开始时间
@property (weak, nonatomic) IBOutlet UILabel *begainLabel;
//结束时间
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
//歌词界面
@property (weak, nonatomic) IBOutlet LrcView *lcrView;

/** 当前的播放器 */
@property (nonatomic, strong) AVAudioPlayer *currentPlayer;

/** 定时器 */
@property (nonatomic, strong) NSTimer  *processTimer;

@property(nonatomic ,assign) BOOL isPlaying;

/** 歌词定时器 */
@property (nonatomic, strong) CADisplayLink *lrclink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //调用毛玻璃效果

    [self.backgroundImage setBlurView];

    //设置滑块的样式
    [self setSliderStyle];
    
    [self startMusicPlayer];
    
    //设置scollerView的尺寸
    self.lcrView.contentSize = CGSizeMake(self.view.bounds.size.width* 2, 0);
    
    self.lcrView.lcrlable = self.lrcLabel;
    
    //设置分页显示
    self.lcrView.pagingEnabled = YES;
}
#pragma mark - 设置锁屏界面
-(void)setupLockInfo{
    //获取锁屏界面的中心
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    // MPMediaItemPropertyAlbumTitle
    // MPMediaItemPropertyAlbumTrackCount
    // MPMediaItemPropertyAlbumTrackNumber
    // MPMediaItemPropertyArtist
    // MPMediaItemPropertyArtwork
    // MPMediaItemPropertyComposer
    // MPMediaItemPropertyDiscCount
    // MPMediaItemPropertyDiscNumber
    // MPMediaItemPropertyGenre
    // MPMediaItemPropertyPersistentID
    // MPMediaItemPropertyPlaybackDuration
    // MPMediaItemPropertyTitle
    //获取歌曲
    rhMusic *model = [playMusicTool playingMusic];
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    [dicInfo setObject:model.name forKey:MPMediaItemPropertyAlbumTitle];
    
    [dicInfo setObject:model.singer forKey:MPMediaItemPropertyArtist];
    
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:model.icon]];
    [dicInfo setObject:artwork forKey:MPMediaItemPropertyArtwork];
    
    [dicInfo setObject:@(self.currentPlayer.duration) forKey:MPMediaItemPropertyPlaybackDuration];
    //设置界面显示信息
    infoCenter.nowPlayingInfo = dicInfo;
    //可以接收远程的事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

}

#pragma mark - 设置滑块的样式
-(void)setSliderStyle{
    
    //设置滑块中心点的图片
    UIImage *image = [UIImage imageNamed:@"player_slider_playback_thumb"];
    [self.sliderPro setThumbImage:image forState:UIControlStateNormal];
    
    //设置滑条的颜色 播放之后的颜色
    [self.sliderPro setTintColor:[UIColor redColor]];

    //滑条控件的背景颜色
//    [self.sliderPro setBackgroundColor:[UIColor grayColor]];
}

#pragma mark - 播放歌曲
-(void)startMusicPlayer{
    //取出播放歌曲
    rhMusic *model = [playMusicTool playingMusic];
    
    //获得歌曲信息
    self.singerName.text = model.singer;
    self.iconImage.image = [UIImage imageNamed:model.icon];
    self.musicName.text = model.name;
    self.backgroundImage.image = [UIImage imageNamed:model.icon];
    
    //开始播放歌曲
    AVAudioPlayer *player = [rhMusicPlayer playMusicWithName:model.filename];
    self.begainLabel.text = [NSString stringWithTime:player.currentTime];
    self.endLabel.text = [NSString stringWithTime:player.duration];
    self.currentPlayer = player;
    self.begainEndBtn.selected = self.currentPlayer.isPlaying;
    
    //设置歌词
    self.lcrView.lrcName = model.lrcname;
    
    //加入动画
       [self.iconImage setImageViewAnimation];

    //先将定时器移除
    [self removeProgressTimer];
    
    //添加定时器更新用户界面
    [self addProgressTimer];
    
    [self removeLrclink];
    [self addLrclink];
    
    //设置锁屏界面的信息
    [self setupLockInfo];
    
}
#pragma mark - 播放下一首歌曲
- (IBAction)playerNextMusicBtn:(UIButton *)sender {
    //取出下一首歌曲
    rhMusic *nextMusic = [playMusicTool playNextMusic];
    
    [self playMusicWithMusic:nextMusic];
}

-(void)playMusicWithMusic:(rhMusic *)music{
    
    //停止播放当前歌曲
    rhMusic *playingMusic = [playMusicTool playingMusic];
    [rhMusicPlayer stopMusicWithName:playingMusic.filename];
    
    //播放当前的歌曲
    [rhMusicPlayer playMusicWithName:music.filename];
    
    //重新设置播放歌曲的信息
    [playMusicTool setPlayingMusic:music];
    
    //刷新视图
    [self startMusicPlayer];
    
}
#pragma mark - 滑块的方法实现
- (IBAction)begainSlider {
     //刚开始移除定时器
    [self removeProgressTimer];
}
- (IBAction)sliderValueChange {
    self.begainLabel.text = [NSString stringWithTime:self.currentPlayer.duration * self.sliderPro.value];
}
- (IBAction)endSlider {
    //修改时间
    self.currentPlayer.currentTime = self.currentPlayer.duration * self.sliderPro.value;
    //重新添加定时器
    [self addProgressTimer];
}
//滑块点击事件处理

- (IBAction)sliderTap:(UITapGestureRecognizer *)sender {
      //获取点击的位置
    CGPoint point = [sender locationInView:sender.view];
    //获取在滑块上的点击位置比例
    CGFloat pointX = point.x / self.sliderPro.bounds.size.width;
    //修改播放的时间
    self.currentPlayer.currentTime = pointX * self.currentPlayer.duration;
    //更新播放进度
    [self updateView];
}

#pragma mark - 播放上一首歌曲
- (IBAction)playerAboveMusicBtn:(UIButton *)sender {
    rhMusic *aboveMusic = [playMusicTool playAboveMusic];
    [self playMusicWithMusic:aboveMusic];
}


#pragma mark - 开始暂停按钮实现

- (IBAction)begainAndEnd:(UIButton *)sender {

        self.begainEndBtn.selected = !self.begainEndBtn.selected;
    if (self.currentPlayer.playing) {
         [self.currentPlayer pause];
        [self.begainEndBtn setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        //停止动画
        [self.iconImage.layer rhStopAnimate];
    }
    else{
            [self.currentPlayer play];
          [self.begainEndBtn setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
//        [self.iconImage.layer rhStartAnimate];
        // 恢复iconView的动画
        [self.iconImage.layer resumeAnimate];

    }
}

#pragma mark - 设置专辑图片为圆角
-(void)viewWillLayoutSubviews{
    //设置圆角半径
    [self.iconImage setImageViewCornerRadius];
}

#pragma mark - 设置定时器

/**
 添加定时器 定时器有添加就要有移除
 */
-(void)addProgressTimer{
    
    //设置定时器定时更新界面
    self.processTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    //将定时器添加到运行循环之中 将循环设置为普通循环
    [[NSRunLoop mainRunLoop] addTimer:self.processTimer forMode:NSRunLoopCommonModes];
}

/**
 移除定时器
 */
-(void)removeProgressTimer{
    [self.processTimer invalidate];
    self.processTimer = nil;
}

-(void)addLrclink{
    self.lrclink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    [self.lrclink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    [[NSRunLoop mainRunLoop] addTimer:self.lrclink forMode:NSRunLoopCommonModes];
}


-(void)removeLrclink{
    [self.lrclink invalidate];
    self.lrclink = nil;
}

#pragma mark - 歌词更新的实现
-(void)updateLrc{
    
    self.lcrView.currentTime = self.currentPlayer.currentTime;
}

#pragma mark - 更新界面
-(void)updateView{
    //更新滑块的值
    self.sliderPro.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
    //更新播放时间
    self.begainLabel.text = [NSString stringWithTime:self.currentPlayer.currentTime];
}

#pragma mark - 监听ScrollerView的滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        //获取偏移量
    CGPoint point = scrollView.contentOffset;
    //获取偏移的比例
    CGFloat pointX =1 - point.x /scrollView.bounds.size.width;
    self.iconImage.alpha = pointX;
    self.lrcLabel.alpha = pointX;
    
}
@end
