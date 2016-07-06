//
//  countCus_yxCusNumberCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface countCus_yxCusNumberCell : UITableViewCell

@property (nonatomic, copy) NSString *countCus;
@property (nonatomic, copy) NSString *yxCusNumber;

@property (nonatomic, strong)UIButton *countCusBtn;
@property (nonatomic, strong)UIButton *yxCusNumberBtn;

@property (nonatomic, strong)UILabel *countCusLabel;
@property (nonatomic, strong)UILabel *yxCusNumberLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
