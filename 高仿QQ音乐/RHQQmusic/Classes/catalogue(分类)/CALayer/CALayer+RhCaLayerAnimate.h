//
//  CALayer+RhCaLayerAnimate.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/2.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (RhCaLayerAnimate)
//停止动画
-(void)rhStopAnimate;
//开始动画
-(void)rhStartAnimate;
//恢复动画
- (void)resumeAnimate;
@end
