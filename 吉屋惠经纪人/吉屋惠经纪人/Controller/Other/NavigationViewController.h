//
//  NavigationViewController.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UIViewController

-(void)setNavTitle:(NSString *)title image:(NSString *)imageName;
-(void)setNavLeftBtnWithTitle:(NSArray *)titles OrImage:(NSArray *)images;
-(void)setNavRightBtnWithTitle:(NSArray *)titles OrImage:(NSArray *)images;

@end
