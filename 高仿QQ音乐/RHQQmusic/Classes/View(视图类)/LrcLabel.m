//
//  LrcLabel.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/8.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "LrcLabel.h"

@implementation LrcLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 1.获取需要画的区域
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    // 2.设置颜色
    [[UIColor cyanColor] set];
    
    // 3.添加区域
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

@end
