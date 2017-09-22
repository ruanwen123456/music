//
//  lrcTool.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/7.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "lrcTool.h"
#import "lrcLine.h"
@implementation lrcTool
+(NSArray *)lrcToolWithMusicName:(NSString *)lrcName{
    //获取歌词的文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    
    //读取歌词
    NSString *lrcString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //每一行的歌词
    NSArray *lrcLineArr = [lrcString componentsSeparatedByString:@"\n"];
//        NSLog(@"%@",lrcString);
    //创建可变数组保存歌词数据
    NSMutableArray *lrcArr = [NSMutableArray array];
    //将歌词转成模型 遍历数组赋值
    for (NSString *lrcLineString in lrcLineArr) {
        //判断过滤掉不需要的歌词
        if ([lrcLineString hasPrefix:@"[ti:"] || [lrcLineString hasPrefix:@"[ar:"] || [lrcLineString hasPrefix:@"[al:"] || ![lrcLineString hasPrefix:@"["] ) {
            //跳出解析
            continue;
        }
        //将歌词转成模型
        lrcLine *model = [lrcLine lrcLineStringWithString:lrcLineString];
        [lrcArr addObject:model];
    }
//    NSLog(@"%@",lrcArr);
//    for (lrcLine *string in lrcArr) {
//        NSLog(@"text:%@ ----time:%f",string.lrcText ,string.time);
//    }
    return lrcArr;
}

@end
