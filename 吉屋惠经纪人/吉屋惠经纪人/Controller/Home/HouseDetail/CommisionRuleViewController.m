//
//  CommisionRuleViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CommisionRuleViewController.h"
#import "PreCommisionCell.h"
#import "CommisionruleCell.h"
#import "CooperateRuleCell.h"

@interface CommisionRuleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation CommisionRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView{
    [self setNavTitle:@"佣金规则" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 25} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
        self.tableView.allowsSelection = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 2;
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else if (section == 1){
        return 54;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 48;
    }else if (indexPath.section == 0 && indexPath.row == 1){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 7.5;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle};
        
        CGRect frame = [[NSString stringWithFormat:@"                   %@",self.yjgz] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return frame.size.height + 30;
    }else if (indexPath.section == 1){
        return 100;
    }
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    
    if (section == 0) {
        view.frame = CGRectMake(0,0,k_w,144);
        label.text = @"项目佣金";
        label.frame = CGRectMake(15,0,k_w,44);
    }else if (section == 1){
        view.frame = CGRectMake(0,0,k_w,154);
        label.text = @"合作规则";
        label.frame = CGRectMake(15,10,k_w,44);
        
        UIView *separator = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,10}];
        separator.backgroundColor = kColor(238, 238, 238);
        [view addSubview:separator];
    }
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor whiteColor];
    [view addSubview:label];
    
    UIView *separator1 = [[UIView alloc] initWithFrame:(CGRect){0,view.frame.size.height - 100,k_w,1}];
    separator1.backgroundColor = kColor(238, 238, 238);
    [view addSubview:separator1];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.section == 0 && indexPath.row == 0) {
        PreCommisionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[PreCommisionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.fxsyj = self.fxsyj;
        }
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        CommisionruleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CommisionruleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.yjgz = self.yjgz;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        CooperateRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CooperateRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            NSMutableArray *parameters = [NSMutableArray array];
            [parameters addObject:self.hzksrq];
            [parameters addObject:self.hzjsrq];
            [parameters addObject:self.hzfy];
            [parameters addObject:self.ksts];
            [parameters addObject:self.kpsj];
            [parameters addObject:self.jygs];
            [parameters addObject:self.jyTime];
            [parameters addObject:self.fxjl];
            cell.parameters = parameters;
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self hideTabBar:YES];
}

//  隐藏TabBar
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
