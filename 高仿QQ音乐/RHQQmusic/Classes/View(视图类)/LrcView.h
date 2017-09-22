//
//  LrcView.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/6.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LrcLabel;

@interface LrcView : UIScrollView

@property (nonatomic, copy) NSString *lrcName;
/** lrcLabel */
@property (nonatomic, weak) LrcLabel *lcrlable;

/** 时间 */
@property (nonatomic, assign) NSTimeInterval  currentTime;
@end
