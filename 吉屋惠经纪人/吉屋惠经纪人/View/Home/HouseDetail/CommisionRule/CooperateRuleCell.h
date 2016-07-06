//
//  CooperateRuleCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CooperateRuleCell : UITableViewCell

@property (nonatomic, strong)NSMutableArray *parameters;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
