//
//  LcrTableCell.m
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/7.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "LcrTableCell.h"
#import "LrcLabel.h"
#import "Masonry.h"
@implementation LcrTableCell

 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         LrcLabel *lrcLabel = [[LrcLabel alloc] init];
         lrcLabel .textColor = [UIColor whiteColor];
         lrcLabel.font = [UIFont systemFontOfSize:14.0];
         lrcLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lrcLabel];
    _lrcLabel = lrcLabel;
    lrcLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}
    
    return self;
}

+(instancetype)lrcCellWithTableViewCell:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    
    LcrTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[LcrTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //取消背景色
        cell.backgroundColor = [UIColor clearColor];
        
//        cell.textLabel.textColor = [UIColor whiteColor];
//        
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return cell;
}


@end
