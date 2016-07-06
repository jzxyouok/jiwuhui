//
//  NewsViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    [self setNavTitle:@"消息" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    self.view.backgroundColor = kColor(238, 238, 238);
    
    NoDataView *noDataView = [[NoDataView alloc] initWithFrame:[UIScreen mainScreen].bounds message:@"暂无消息"];
    [self.view addSubview:noDataView];
}


- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
