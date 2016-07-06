//
//  AccountHisViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "AccountHisViewController.h"

@interface AccountHisViewController ()

@end

@implementation AccountHisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    [self setNavTitle:@"账单记录" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    self.view.backgroundColor = kColor(238, 238, 238);
    
    //  灰色背景视图
    UIView *grayView = [[UIView alloc] initWithFrame:(CGRect){0, 0, k_w, 62}];
    grayView.backgroundColor = kColor(118, 118, 118);
    [self.view addSubview:grayView];
    
    //  分隔线
    UIView *separator = [[UIView alloc] initWithFrame:(CGRect){k_w / 2, 10, 1, 42}];
    separator.backgroundColor = kColor(138, 138, 138);
    [self.view addSubview:separator];
    
    //  累计收入标签
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0, 12, k_w / 2, 21}];
    [grayView addSubview:label];
    label.text = @"累计收入";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    //  ￥0.00标签
    UILabel *label1 = [[UILabel alloc] initWithFrame:(CGRect){0, 32, k_w / 2, 21}];
    [grayView addSubview:label1];
    label1.text = @"￥0.00";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    
    //  累计提取标签
    UILabel *labe2 = [[UILabel alloc] initWithFrame:(CGRect){k_w / 2, 12, k_w / 2, 21}];
    [grayView addSubview:labe2];
    labe2.text = @"累计提取";
    labe2.font = [UIFont systemFontOfSize:13];
    labe2.textColor = [UIColor whiteColor];
    labe2.textAlignment = NSTextAlignmentCenter;
    
    //  ￥0.00标签
    UILabel *label3 = [[UILabel alloc] initWithFrame:(CGRect){k_w / 2, 32, k_w / 2, 21}];
    [grayView addSubview:label3];
    label3.text = @"￥0.00";
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = [UIColor whiteColor];
    label3.textAlignment = NSTextAlignmentCenter;
    
    //  累计收入标签
    NoDataView *noDataView = [[NoDataView alloc] initWithFrame:(CGRect){0, 40, k_w, k_h} message:@"还没有账单记录哦"];
    [self.view addSubview:noDataView];
}

/**
 *  返回上级视图
 */
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
