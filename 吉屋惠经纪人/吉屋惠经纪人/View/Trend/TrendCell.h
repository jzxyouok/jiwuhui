//
//  TrendCell.h
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrendFrameModelDelegate <NSObject>

- (void)trendFrameModelImageClick:(UIButton *)button;
- (void)trendFrameMoreRemarkClick:(UIButton *)button;

@end

@class TrendFrameModel;

@interface TrendCell : UITableViewCell

+(instancetype)trendCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)TrendFrameModel *frameTrend;
@property (nonatomic, assign) NSInteger btnTag;
@property (nonatomic, weak)id <TrendFrameModelDelegate>delegate;

@end
