//
//  CommissionRuleCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissionRuleCell : UITableViewCell

@property (nonatomic, copy) NSString *fxsyj;
@property (nonatomic, copy) NSString *yjgz;

@property (nonatomic, strong)UIButton *fxsyjBtn;
@property (nonatomic, strong)UIButton *yjgzBtn;

@property (nonatomic, strong)UILabel *fxsyjLabel;
@property (nonatomic, strong)UILabel *yjgzLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
