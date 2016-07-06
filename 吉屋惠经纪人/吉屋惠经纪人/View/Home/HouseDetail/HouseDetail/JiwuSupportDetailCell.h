//
//  JiwuSupportDetailCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiwuSupportDetailCell : UITableViewCell

@property (nonatomic, copy) NSString *jwzc;
@property (nonatomic, strong)UILabel *jwzcLabel;
@property (nonatomic, strong)UITextView *jwzcContentTextView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
