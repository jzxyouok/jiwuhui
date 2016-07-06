//
//  ChooseCityViewController.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseCityViewControllerDelegate <NSObject>

- (void)chooseCityViewControllerDidFinishChoose:(NSString *)city;

@end

@interface ChooseCityViewController : NavigationViewController

@property (nonatomic, strong)id <ChooseCityViewControllerDelegate>delegate;

@end
