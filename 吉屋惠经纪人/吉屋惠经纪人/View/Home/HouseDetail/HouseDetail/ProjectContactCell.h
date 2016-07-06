//
//  ProjectContactCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectContactCell : UITableViewCell

@property (nonatomic, copy) NSString *projectContact;
@property (nonatomic, strong)UILabel *projectContactLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
