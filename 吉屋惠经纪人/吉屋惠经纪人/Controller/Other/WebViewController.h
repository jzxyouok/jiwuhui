//
//  BagHelpViewController.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "NavigationViewController.h"

@interface WebViewController : NavigationViewController

- (instancetype)initWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftTitle:(NSArray *)leftTitles leftImage:(NSArray *)leftImages rightTitle:(NSArray *)rightTitles rightImage:(NSArray *)rightImages request:(NSURLRequest *)request;

@end
