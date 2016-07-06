//
//  DistrictNameViewController.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "NavigationViewController.h"

@interface DistrictNameViewController : NavigationViewController

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *dtid;
@property (nonatomic, copy) void (^finishChoose)(NSString *districtName);

@end
