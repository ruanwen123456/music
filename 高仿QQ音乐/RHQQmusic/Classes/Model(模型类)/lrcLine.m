//
//  lrcLine.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/7.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "lrcLine.h"

@implementation lrcLine
-(instancetype)initWithLrcLineString:(NSString *)lrcLineString{
    if (self = [super init]) {
//            NSArray *lrcArray = [lrcLineString componentsSeparatedByString:@"]"];
//
//        //获取歌词
//        self.lrcText =lrcArray[1];
//        
//        //获取歌词对应的时间
//        self.time = lrcArray[0] substringFromIndex:1 ;
//        // [01:05.43]我想就这样牵着你的手不放开
        NSArray *lrcArray = [lrcLineString componentsSeparatedByString:@"]"];
        self.lrcText = lrcArray[1];
        NSString *timeString = lrcArray[0];
        self.time = [self timeWithString:[timeString substringFromIndex:1]];
    }
    return self;
}
+(instancetype)lrcLineStringWithString:(NSString *)lrcLineString{

    return [[self alloc] initWithLrcLineString:lrcLineString];
}

-(NSTimeInterval)timeWithString:(NSString *)timeString{
    //[00:01.72]阳光下的泡沫　是彩色的
    //获取分钟数
    NSInteger min =[ [timeString componentsSeparatedByString:@":"][0] integerValue];
    //获取秒
    NSInteger second = [[timeString substringWithRange:NSMakeRange(3, 2)] integerValue];
    
    //获取毫秒
    NSInteger haomiao =[ [timeString componentsSeparatedByString:@"."][1] integerValue];
    
    return  (min * 60 + second + haomiao * 0.01);
}


@end
