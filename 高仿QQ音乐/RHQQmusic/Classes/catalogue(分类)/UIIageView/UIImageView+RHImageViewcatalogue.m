//
//  UIImageView+RHImageViewcatalogue.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/1.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "UIImageView+RHImageViewcatalogue.h"

@implementation UIImageView (RHImageViewcatalogue)

#pragma mark - 图片旋转
-(UIImageView *)setImageViewAnimation{
    //1.初始化 设置根据Z轴旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 2.设置基本动画属性
        //2.1.设置旋转的起点和终点
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI * 2);
    //2.2.设置重复的次数   NSIntegerMax表示一直旋转
    
    rotationAnimation.repeatCount = NSIntegerMax;
    //2.3.设置旋转时长
    rotationAnimation.duration = 40;

    // 3.添加动画到图层上
    [self.layer addAnimation:rotationAnimation forKey:nil];

    return self;
}

#pragma mark - 设置圆角 将图片改为圆形
-(UIImageView *)setImageViewCornerRadius{
    //设置圆角半径
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    
    
    self.layer.masksToBounds = YES;
    
    //设置外延宽度
    self.layer.borderWidth = 8.0;
    
    //设置外延的颜色
    self.layer.borderColor = [UIColor cyanColor].CGColor;
    
    return self;

}

#pragma mark - 毛玻璃实现
/**
 毛玻璃实现方法

 @return 一个UIImageView
 */
-(UIImageView *)setBlurView{
    
    //初始化毛玻璃控件
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.frame];
    
    //设置毛玻璃默认的值
    [toolBar setBarStyle:UIBarStyleBlack];
    
    //将毛玻璃添加到视图上
    [self addSubview:toolBar];
    
    return self;
}
@end
