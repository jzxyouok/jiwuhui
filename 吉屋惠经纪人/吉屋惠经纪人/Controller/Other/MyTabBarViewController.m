//
//  MyTabBarViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "MyTabbrItem.h"


@interface MyTabBarViewController ()

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self createView];
}

/**
 *  创建视图
 */
- (void)createView{
    self.myTabBar = [[UIView alloc] initWithFrame:(CGRect){0,k_h - 49,k_w,49}];
    self.myTabBar.backgroundColor = kColor(0, 179, 90);
    [self.view addSubview:self.myTabBar];
    
    //  中间圆形View
    CGFloat circleViewW = 75;
    UIView *circleView = [[UIView alloc] initWithFrame:(CGRect){k_w / 2 - circleViewW/2, -10,circleViewW,circleViewW}];
    circleView.backgroundColor = kColor(0, 179, 90);
    circleView.layer.cornerRadius = circleViewW / 2;
    circleView.layer.masksToBounds = YES;
    [self.myTabBar addSubview:circleView];
    
}

/**
 *  创建按钮
 *
 *  @param titles 按钮文字
 *  @param images 按钮图片
 *  @param color  文字颜色
 *  @param font   文字字体
 */
- (void)tabbarWithTitle:(NSArray *)titles andNolImage:(NSArray *)images andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font{
    for (int i = 0; i < titles.count; i++) {
        MyTabbrItem *item = [[MyTabbrItem alloc] initWithFrame:(CGRect){i * k_w/titles.count,0,k_w/titles.count,49} andTitle:titles[i] andImage:images[i] andTitleColor:color andTitleFont:font];
        item.tag = i;
        if (i == 2) {
            [item setTitleColor:kColor(221, 255, 99) forState:UIControlStateNormal];
            self.currentIndex = 2;
        }
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.myTabBar addSubview:item];
    }
}

/**
 *  设置选中后切换TabBar图标
 *
 *  @param sender
 */
- (void)itemClick:(UIButton *)sender{
    //  如果是第0和第3个，需要登录
    if ((sender.tag == 0 || sender.tag == 3) && [UserInfo sharedUserInfo].loginStatus == NO) {
        [MBProgressHUD showSuccess:@"请先登录"];
        UINavigationController *navigationController = [self.viewControllers objectAtIndex:self.currentIndex];
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    NSArray *imaegName = @[@"首-bot-客户1",@"首-bot-客户2",@"首-bot-动态1",@"首-bot-动态2",@"首-bot-首页1",@"首-bot-首页2",@"改-底部标签栏-换客户",@"改-底部标签栏-换客户2_",@"首-bot-我1",@"首-bot-我2"];
    self.selectedIndex = sender.tag;
    self.currentIndex = sender.tag;
    int i = 0;
    
    for (UIButton *item in self.myTabBar.subviews) {
        if (i == 0) {
            i++;
            continue;
        }
        if (i - 1 == sender.tag) {
            [item setImage:[UIImage imageNamed:[imaegName objectAtIndex:(i - 1) * 2 + 1]] forState:UIControlStateNormal];
            [item setTitleColor:kColor(221, 255, 99) forState:UIControlStateNormal];
        }else{
            [item setImage:[UIImage imageNamed:[imaegName objectAtIndex:(i - 1) * 2]] forState:UIControlStateNormal];
            [item setTitleColor:kColor(255, 255, 255) forState:UIControlStateNormal];
        }
        i++;
    }
}

@end
