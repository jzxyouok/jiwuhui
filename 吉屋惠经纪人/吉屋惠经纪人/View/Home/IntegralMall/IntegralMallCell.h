//
//  IntegralMallCell.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@interface IntegralMallCell : UITableViewCell

@property (nonatomic, strong) GiftModel *gift;

+(instancetype)homeCellWithTableView:(UITableView *)tableView;

@end
