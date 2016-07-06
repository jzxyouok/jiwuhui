//
//  CustomTableViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController ()

@property (nonatomic, strong)UISearchBar *searchBar;

@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    [self setNavTitle:@"所有" image:@"icon_arrow_down"];
    [self setNavLeftBtnWithTitle:@[@"提醒"] OrImage:nil];
    [self setNavRightBtnWithTitle:nil OrImage:@[@"add_customer"]];
    self.view.backgroundColor = kColor(238, 238, 238);
    
    //  搜索框
    self.searchBar = [[UISearchBar alloc] initWithFrame:(CGRect){0,0,k_w,44}];
    [self.view addSubview:self.searchBar];
    
    NoDataView *noDataView = [[NoDataView alloc] initWithFrame:[UIScreen mainScreen].bounds message:@"暂无客户"];
    [self.view addSubview:noDataView];
}


- (void)leftBtnClick
{
    [MBProgressHUD showSuccess:@"提醒成功！"];
}

- (void)rightBtnClick
{
    [MBProgressHUD showSuccess:@"添加成功！"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
