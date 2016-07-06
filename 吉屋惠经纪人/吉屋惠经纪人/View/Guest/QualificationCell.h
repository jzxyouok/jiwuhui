//
//  QualificationCell.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/27.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QualificationCell : UITableViewCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSDictionary *data;

@end
