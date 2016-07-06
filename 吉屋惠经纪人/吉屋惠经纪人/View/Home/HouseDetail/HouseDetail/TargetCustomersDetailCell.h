//
//  TargetCustomersDetailCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetCustomersDetailCell : UITableViewCell

@property (nonatomic, copy) NSString *khnl;
@property (nonatomic, copy) NSString *gfmd;
@property (nonatomic, copy) NSString *gfys;
@property (nonatomic, copy) NSString *kfzy;
@property (nonatomic, copy) NSString *gzqy;
@property (nonatomic, copy) NSString *jzqy;

@property (nonatomic, strong)UILabel *khnlLabel;
@property (nonatomic, strong)UILabel *gfmdLabel;
@property (nonatomic, strong)UILabel *gfysLabel;
@property (nonatomic, strong)UILabel *kfzyLabel;
@property (nonatomic, strong)UILabel *gzqyLabel;
@property (nonatomic, strong)UILabel *jzqyLabel;

@property (nonatomic, strong)UITextView *khnlContentTextView;
@property (nonatomic, strong)UITextView *gfmdContentTextView;
@property (nonatomic, strong)UITextView *gfysContentTextView;
@property (nonatomic, strong)UITextView *kfzyContentTextView;
@property (nonatomic, strong)UITextView *gzqyContentTextView;
@property (nonatomic, strong)UITextView *jzqyContentTextView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
