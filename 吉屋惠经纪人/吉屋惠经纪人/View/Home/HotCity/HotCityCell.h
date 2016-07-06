//
//  HotCityCell.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotCityCellDelegate <NSObject>

- (void)hotCityCellCityButtonClick:(NSString *)city;

@end

@interface HotCityCell : UITableViewCell

@property (nonatomic, strong)id <HotCityCellDelegate>delegate;

@end
