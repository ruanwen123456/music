//
//  UIImageView+RHImageViewcatalogue.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/1.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RHImageViewcatalogue)


/**
 图片旋转

 */
-(UIImageView *)setImageViewAnimation;
/**
 毛玻璃实现
 */
-(UIImageView *)setBlurView;


/**
 将图片修改为圆形

 @return UIImageView
 */
-(UIImageView *)setImageViewCornerRadius;
@end
