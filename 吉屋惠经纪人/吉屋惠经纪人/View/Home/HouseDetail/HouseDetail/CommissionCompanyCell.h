//
//  CommissionCompanyCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissionCompanyCell : UITableViewCell

@property (nonatomic, copy) NSString *jygs;
@property (nonatomic, strong)UILabel *jygsLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
