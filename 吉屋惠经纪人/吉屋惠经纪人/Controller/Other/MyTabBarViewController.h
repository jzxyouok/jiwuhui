//
//  MyTabBarViewController.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTabBarViewControllerDelegate <UITabBarControllerDelegate>

- (void)myTabBarViewControllerItemClick;

@end


@interface MyTabBarViewController : UITabBarController

@property (nonatomic, strong)UIView *myTabBar;
@property (nonatomic, weak)id <MyTabBarViewControllerDelegate>delegate;

- (void)tabbarWithTitle:(NSArray *)titles andNolImage:(NSArray *)images andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font;

@end
