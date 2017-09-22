//
//  LrcView.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/6.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "LrcView.h"
#import "Masonry.h"
#import "LcrTableCell.h"
#import "lrcTool.h"
#import "lrcLine.h"
#import "LrcLabel.h"

@interface LrcView()<UITableViewDataSource>

/** UItableView */
@property (nonatomic, strong) UITableView *tabelView;

/** 歌词列表 */
@property (nonatomic, strong) NSArray *lrcList;

/** 时间 */
//@property (nonatomic, assign) NSTimeInterval  currentTime;

/** 设置当前下标值 */
@property (nonatomic, assign) NSInteger  currentIndex;
@end

@implementation LrcView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUptableView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUptableView];
    }
    return self;
}

-(void)setUptableView{
    UITableView *tableView = [[UITableView alloc] init];
    
    
    tableView.rowHeight = 35;

    
    [self addSubview:tableView];
    //设置数据源协议
    tableView.dataSource = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tabelView = tableView;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //设置tableView的尺寸
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    self.tabelView.backgroundColor = [UIColor clearColor];
    //取消分割线
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tabelView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
}



#pragma mark - 数据源协议实现方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return self.lrcList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LcrTableCell *cell = [LcrTableCell lrcCellWithTableViewCell:tableView];
    if (self.currentIndex == indexPath.row) {
        cell.lrcLabel.font = [UIFont systemFontOfSize:17];
    }
    else{
        cell.lrcLabel.font = [UIFont systemFontOfSize:14];
        //取消重复利用
        cell.lrcLabel.progress = 0;
    }
    lrcLine *line = self.lrcList[indexPath.row];
    
    cell.lrcLabel.text = line.lrcText;

    return cell;
}
-(void)setLrcName:(NSString *)lrcName{
    // 重置保存的当前位置的下标
    self.currentIndex = 0;
    
    //保存歌词的名称
    _lrcName = [lrcName copy];
    
    //解析歌词
    self.lrcList = [lrcTool lrcToolWithMusicName:_lrcName];
    
    //刷新表格
    [self.tabelView reloadData];
}

#pragma mark - 重写currentTime的set方法
-(void)setCurrentTime:(NSTimeInterval)currentTime{
    _currentTime  =currentTime;
    NSInteger count = self.lrcList.count;
    for (NSInteger i = 0; i < count; i++) {
        //拿到歌词
        lrcLine *currentLine = self.lrcList[i];
        //拿到下一句的歌词
        lrcLine *nextLine = nil;
        NSInteger nextIndex = i + 1;
        if (nextIndex <count) {
           nextLine = self.lrcList[nextIndex];
        }
        // 用当前的时间和i位置的歌词比较,并且和下一句比较,如果大于i位置的时间,并且小于下一句歌词的时间,那么显示当前的歌词
        if (currentTime >= currentLine.time && currentTime < nextLine.time && self.currentIndex != i) {
            
            // 1.获取需要刷新的行号
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            
            // 2.记录当前i的行号
            self.currentIndex = i;
            
            // 3.刷新当前的行,和上一行
            [self.tabelView reloadRowsAtIndexPaths:@[indexPath, previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            // 4.显示对应句的歌词
            [self.tabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            // 5.设置外面歌词的Label的显示歌词
            self.lcrlable.text = currentLine.lrcText;
        }
        //根据进度显示label
        if (self.currentIndex == i) {
            // 4.1.拿到i位置的cell
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            LcrTableCell *cell = (LcrTableCell *)[self.tabelView cellForRowAtIndexPath:indexPath];
            
            // 4.2.更新label的进度
            CGFloat progress = (currentTime - currentLine.time) / (nextLine.time - currentLine.time);
            //设置cell的进度
            cell.lrcLabel.progress = progress;
             //设置外面歌词的Label的进度
            self.lcrlable.progress = progress;
        }

    }

}
@end
