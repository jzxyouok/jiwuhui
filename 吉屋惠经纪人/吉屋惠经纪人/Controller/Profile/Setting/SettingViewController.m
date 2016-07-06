//
//  SettingViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-35,k_w,k_h - 15) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setNavTitle:@"设置" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, k_w - 20, 44)];
    [self.tableView addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = kColor(255, 136, 56);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    
    //  根据当前登录状态设置按钮文字
    if ([UserInfo sharedUserInfo].loginStatus) {
        [button setTitle:@"退出" forState:UIControlStateNormal];
    }else{
        [button setTitle:@"登录" forState:UIControlStateNormal];
    }
}

/**
 *  点击登录按钮
 *
 *  @param button
 */
- (void)buttonClick:(UIButton *)button{
    //  如果已登录，退出登录
    if ([UserInfo sharedUserInfo].loginStatus) {
        [ZTShowMessage showMessage:@"已退出登录"];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        
        [UserInfo sharedUserInfo].loginStatus = NO;
        [UserInfo sharedUserInfo].isLoginStatusChanged = YES;
        [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
    }else{
        //  如果未登录，进入登录页面
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改密码";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"给我们打分";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"快捷回复";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self hideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideTabBar:NO];
}

/**
 *  隐藏TabBar
 *
 *  @param hidden 
 */
- (void) hideTabBar:(BOOL) hidden{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    MyTabBarViewController *tabBarViewController = (MyTabBarViewController *)self.tabBarController;
    if (hidden) {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h + 10, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    } else {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h - 49, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    }
    [UIView commitAnimations];
}

@end