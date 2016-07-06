//
//  HouseParameterTableViewCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseParameterCell : UITableViewCell

@property (nonatomic, copy) NSString *bname;
@property (nonatomic, copy) NSString *salestatusText;

@property (nonatomic, strong)UILabel *bnameLabel;
@property (nonatomic, strong)UILabel *salestatusTextLabel;
@property (nonatomic, strong)UIView *colorView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
