//
//  NSString+timeString.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/4.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "NSString+timeString.h"

@implementation NSString (timeString)
+ (NSString *)stringWithTime:(NSTimeInterval)time
{
    NSInteger min = time / 60;
    NSInteger second = (NSInteger)time % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}
@end
