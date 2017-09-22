//
//  CALayer+RhCaLayerAnimate.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/2.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "CALayer+RhCaLayerAnimate.h"

@implementation CALayer (RhCaLayerAnimate)
#pragma mark - 停止图片的旋转

-(void)rhStopAnimate{
    CFTimeInterval stop = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    //speed默认为0
    self.speed = 0;
    self.timeOffset = stop;
}

#pragma mark - 开始动画

-(void)rhStartAnimate{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}
#pragma mark - 恢复动画

- (void)resumeAnimate
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}
@end
