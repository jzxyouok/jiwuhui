//
//  MyCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (nonatomic, strong)UIImageView *buildPathImageView;
@property (nonatomic, strong)UILabel *priceRemarkLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *bnameBtn;
@property (nonatomic, strong)UILabel *countCusLabel;
@property (nonatomic, strong)UILabel *yxCusNumberLabel;
@property (nonatomic, strong)UIButton *commissionBtn;
@property (nonatomic, strong)UIView *cornermarkView;
@property (nonatomic, strong)UILabel *cornermarkLabel;
@property (nonatomic, strong)UIButton *cellButton;

@property (nonatomic, strong)NSMutableDictionary *homeData;

+(instancetype)homeCellWithTableView:(UITableView *)tableView;

@end

