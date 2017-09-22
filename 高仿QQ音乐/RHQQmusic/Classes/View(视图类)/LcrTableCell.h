//
//  LcrTableCell.h
//  RHQQmusic
//
//  Created by 阮浩 on 17/7/7.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LrcLabel;

@interface LcrTableCell : UITableViewCell

@property (nonatomic, weak, readonly) LrcLabel *lrcLabel;

+(instancetype)lrcCellWithTableViewCell:(UITableView *)tableView;
@end
