//
//  PreCommisionCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreCommisionCell : UITableViewCell

@property (nonatomic, copy) NSString *fxsyj;
@property (nonatomic, strong)UILabel *fxsyjLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
