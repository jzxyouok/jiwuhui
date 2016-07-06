//
//  RankViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,64,k_w,k_h - 113} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setNavTitle:@"排行榜" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){-1,0,k_w + 2,64}];
    imageView.image = [UIImage imageNamed:@"Profile_rank1"];
    [self.view addSubview:imageView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,300}];
    imageView.image = [UIImage imageNamed:@"Profile_rank"];
    [cell.contentView addSubview:imageView];
    
    
    return cell;
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
