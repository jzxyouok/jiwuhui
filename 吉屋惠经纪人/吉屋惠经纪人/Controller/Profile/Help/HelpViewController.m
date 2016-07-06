//
//  HelpViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 60} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setNavTitle:@"常见问题" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    [self setNavRightBtnWithTitle:@[@"意见反馈"] OrImage:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 355;
    }
    return 430;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,430}];
        imageView.image = [UIImage imageNamed:@"Profile_help1"];
        [cell.contentView addSubview:imageView];
    }else{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,355}];
        imageView.image = [UIImage imageNamed:@"Profile_help2"];
        [cell.contentView addSubview:imageView];
    }
    
    return cell;
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
        self.tableView.frame = CGRectMake(0,0,k_w,k_h - 15);
    } else {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h - 49, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
        self.tableView.frame = CGRectMake(0,0,k_w,k_h - 157);
    }
    [UIView commitAnimations];
}
@end
