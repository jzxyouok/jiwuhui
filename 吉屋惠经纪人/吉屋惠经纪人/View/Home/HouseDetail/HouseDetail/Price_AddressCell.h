//
//  Price_AddressCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Price_AddressCell : UITableViewCell

@property (nonatomic, copy) NSString *averagePrice;
@property (nonatomic, copy) NSString *saleAddress;

@property (nonatomic, strong)UIButton *averagePriceBtn;
@property (nonatomic, strong)UIButton *saleAddressBtn;

@property (nonatomic, strong)UILabel *averagePriceLabel;
@property (nonatomic, strong)UILabel *saleAddressLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
