//
//  AppDelegate.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "CustomTableViewController.h"
#import "TrendTableViewController.h"
#import "HomeTableViewController.h"
#import "GuestTableViewController.h"
#import "ProfileTableViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong)BMKMapManager* mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"fbquj3wD3FZXAFHyclaYkXorqpGYyn22"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //  从沙盒加载数据
    [[UserInfo sharedUserInfo] loadUserInfoFromSanbox];
    [self setupTabBar];
    
    return YES;
}

/**
 *  设置TabBar
 */
- (void)setupTabBar{
    //  初始化5个控制器
    CustomTableViewController *customTableViewController = [[CustomTableViewController alloc] init];
    TrendTableViewController *trendTableViewController = [[TrendTableViewController alloc] init];
    HomeTableViewController *homeTableViewController = [[HomeTableViewController alloc] init];
    GuestTableViewController *guestTableViewController = [[GuestTableViewController alloc] init];
    ProfileTableViewController *profileTableViewController = [[ProfileTableViewController alloc] init];
    
    //  添加导航
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:customTableViewController];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:trendTableViewController];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:homeTableViewController];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:guestTableViewController];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:profileTableViewController];
    
    //  取消半透明
    nav1.navigationBar.translucent = NO;
    nav2.navigationBar.translucent = NO;
    nav3.navigationBar.translucent = NO;
    nav4.navigationBar.translucent = NO;
    nav5.navigationBar.translucent = NO;
    
    //  设置navigationBar颜色
    nav1.navigationBar.barTintColor = [UIColor colorWithRed:0 green:179/255.0 blue:90/255.0 alpha:1];
    nav2.navigationBar.barTintColor = [UIColor colorWithRed:0 green:179/255.0 blue:90/255.0 alpha:1];
    nav3.navigationBar.barTintColor = [UIColor colorWithRed:0 green:179/255.0 blue:90/255.0 alpha:1];
    nav4.navigationBar.barTintColor = [UIColor colorWithRed:0 green:179/255.0 blue:90/255.0 alpha:1];
    nav5.navigationBar.barTintColor = [UIColor colorWithRed:0 green:179/255.0 blue:90/255.0 alpha:1];
    
    //  将控制器加入数组
    NSMutableArray *controllers = [NSMutableArray array];
    [controllers addObject:nav1];
    [controllers addObject:nav2];
    [controllers addObject:nav3];
    [controllers addObject:nav4];
    [controllers addObject:nav5];
    
    //  TabBar图片数组
    NSArray *images = @[@"首-bot-客户1",@"首-bot-动态1",@"首-bot-首页2",@"改-底部标签栏-换客户",@"首-bot-我1"];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *imageName in images) {
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArr addObject:image];
    }
    
    //  Tabbar控制器
    MyTabBarViewController *tab = [[MyTabBarViewController alloc] init];
    [tab tabbarWithTitle:@[@"客户",@"动态",@"首页",@"送客",@"我"] andNolImage:imageArr andTitleColor:[UIColor whiteColor] andTitleFont:[UIFont systemFontOfSize:11]];
    tab.viewControllers = controllers;
    tab.selectedIndex = 2;
    
    //  将Tabbar控制器添加到window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tab;
    self.window.backgroundColor = kColor(0, 179, 90);
    [self.window makeKeyAndVisible];
        
}

@end
