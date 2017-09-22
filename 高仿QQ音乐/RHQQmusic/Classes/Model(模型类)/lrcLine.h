//
//  lrcLine.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/7.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lrcLine : NSObject
/** 歌词内容 */
@property (nonatomic, copy) NSString *lrcText;

/** 时间 */
@property (nonatomic, assign) NSTimeInterval  time;

-(instancetype)initWithLrcLineString:(NSString *)lrcLineString;
+(instancetype)lrcLineStringWithString:(NSString *)lrcLineString;
@end
