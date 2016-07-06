//
//  SalePointCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalePointCell : UITableViewCell

@property (nonatomic, copy) NSString *jgys;
@property (nonatomic, copy) NSString *shpt;
@property (nonatomic, copy) NSString *xqpt;
@property (nonatomic, copy) NSString *jtpt;

@property (nonatomic, strong)UITextView *jgysContentTextView;
@property (nonatomic, strong)UITextView *shptContentTextView;
@property (nonatomic, strong)UITextView *xqptContentTextView;
@property (nonatomic, strong)UITextView *jtptContentTextView;


@property (nonatomic, strong)UILabel *jgysLabel;
@property (nonatomic, strong)UILabel *shptLabel;
@property (nonatomic, strong)UILabel *xqptLabel;
@property (nonatomic, strong)UILabel *jtptLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
