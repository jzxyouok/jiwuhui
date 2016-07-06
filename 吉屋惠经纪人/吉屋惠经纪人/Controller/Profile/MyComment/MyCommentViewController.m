//
//  MyCommentViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "MyCommentViewController.h"

@interface MyCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 113} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setNavTitle:@"我的评价" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    [self setNavRightBtnWithTitle:nil OrImage:@[@"eva_rul"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,180}];
        imageView.image = [UIImage imageNamed:@"Profile_comment1"];
        [cell.contentView addSubview:imageView];
    }else{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,180}];
        imageView.image = [UIImage imageNamed:@"Profile_comment2"];
        [cell.contentView addSubview:imageView];
    }
    
    return cell;
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
