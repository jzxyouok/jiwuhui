//
//  ProfileTableViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ProfileHeaderView.h"
#import "MyCommentViewController.h"
#import "RankViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import "UserDetailViewController.h"

@interface ProfileTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ProfileHeaderViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)UIButton *backgroundMask;
@property (nonatomic, weak)UIButton *backgroundMask1;
@property (nonatomic, weak)UIView *messageView;


@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [self hideTabBar:NO];
    
    //  根据登录状态是否改变，更新HeaderView
    if ([UserInfo sharedUserInfo].isLoginStatusChanged) {
        [UserInfo sharedUserInfo].isLoginStatusChanged = NO;
        [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
        
        ProfileHeaderView *headerView = [[ProfileHeaderView alloc] init];
        self.tableView.tableHeaderView = headerView;
        headerView.delegate = self;
    }else{
        
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:(CGRect){0,-20,k_w,k_h + 15} style:UITableViewStylePlain];
        ProfileHeaderView *headerView = [[ProfileHeaderView alloc] init];
        self.tableView.tableHeaderView = headerView;
        headerView.delegate = self;
        
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 4;
    if (section == 1) return 1;
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell.contentView addSubview:[self buttonWithTitle:@"我的评价" imageName:@"my_evaluate" subTitle:@"" subImageName:nil]];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        [cell.contentView addSubview:[self buttonWithTitle:@"排行榜" imageName:@"mine_top_icon" subTitle:@"" subImageName:nil]];
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        [cell.contentView addSubview:[self buttonWithTitle:@"我的新房" imageName:@"mine_new_house_icon" subTitle:@"" subImageName:nil]];
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        [cell.contentView addSubview:[self buttonWithTitle:@"我的二手房" imageName:@"mine_used_house_icon" subTitle:@"" subImageName:nil]];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        [cell.contentView addSubview:[self buttonWithTitle:@"帮助与反馈" imageName:@"house_details_fatie" subTitle:@"送积分" subImageName:@"agent_team_integal_visiable"]];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        [cell.contentView addSubview:[self buttonWithTitle:@"设置" imageName:@"mine_setting_icon" subTitle:@"" subImageName:nil]];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        [cell.contentView addSubview:[self buttonWithTitle:@"联系客服" imageName:@"mine_contact_us_icon" subTitle:@"4007055833" subImageName:nil]];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UIView *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName subTitle:(NSString *)subTitle subImageName:(NSString *)subImageName{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,44}];
    
    //  设置左边的图标和文字
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){0,0,150,44}];
    CGRect buttonFrame = [title boundingRectWithSize:(CGSize){MAXFLOAT,44} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    button.imageEdgeInsets = UIEdgeInsetsMake(11, 15, 11, 150 - 5 - 30);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, buttonFrame.size.width - 100, 0, 0);
    button.userInteractionEnabled = NO;
    [view addSubview:button];
    
    
    //  设置左边的图标和文字
    UIButton *button1 = [[UIButton alloc] initWithFrame:(CGRect){k_w - 150,0,150,44}];
    [button1 setTitle:subTitle forState:UIControlStateNormal];
    button1.userInteractionEnabled = NO;
    [view addSubview:button1];
    
    if (subImageName) {
        CGRect buttonFrame1 = [subTitle boundingRectWithSize:(CGSize){MAXFLOAT,44} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        [button1 setImage:[UIImage imageNamed:subImageName] forState:UIControlStateNormal];
        [button1 setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
        
        button1.imageEdgeInsets = UIEdgeInsetsMake(11, 100, 11, 30);
        button1.titleEdgeInsets = UIEdgeInsetsMake(0, 50 - buttonFrame1.size.width, 0, 40);
        button1.titleLabel.font = [UIFont systemFontOfSize:12];
    }else{
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return view;
}

/**
 *  选中cell
 *
 *  @param tableView
 *  @param indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //  我的评价
    if (indexPath.section == 0 && indexPath.row == 0) {
        MyCommentViewController *commentViewController = [[MyCommentViewController alloc] init];
        [self.navigationController pushViewController:commentViewController animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        
        //  排行榜
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        RankViewController *rankViewController = [[RankViewController alloc] init];
        [self.navigationController pushViewController:rankViewController animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        
        //  我的新房
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        [ZTShowMessage showMessage:@"亲，认证是你拿高佣的保障哟！" Title:@"认证个人信息" LeftButton:@"暂不" RightButton:@"认证个人信息" leftBtnClick:^{
            
        } rightBtnClick:^{
            UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
            [self.navigationController pushViewController:userDetailViewController animated:YES];
            self.navigationController.navigationBar.hidden = NO;
        }];
        
        //  我的二手房
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        [ZTShowMessage showMessage:@"亲，认证是你拿高佣的保障哟！" Title:@"认证个人信息" LeftButton:@"暂不" RightButton:@"认证个人信息" leftBtnClick:^{
            
        } rightBtnClick:^{
            UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
            [self.navigationController pushViewController:userDetailViewController animated:YES];
            self.navigationController.navigationBar.hidden = NO;
        }];
        
        //  帮助与反馈
    }else if (indexPath.section == 1) {
        HelpViewController *helpViewController = [[HelpViewController alloc] init];
        [self.navigationController pushViewController:helpViewController animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        
        //  设置
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        SettingViewController *settingViewController = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        
        //  联系客服
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"400-705-5833" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alertview show];
    }
}

#pragma mark - UIAlertViewDelegate
/**
 *  拨打客服电话
 *
 *  @param alertView
 *  @param buttonIndex
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-705-5833"]];
    }
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

#pragma mark - ProfileHeaderViewDelegate

/**
 *  如果未登录，点击HeaderView进行登录,否则显示个人信息
 */
-(void)profileHeaderViewLoginButtonClick{
    if ([UserInfo sharedUserInfo].loginStatus) {
        UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
        [self.navigationController pushViewController:userDetailViewController animated:YES];
        self.navigationController.navigationBar.hidden = NO;
    }else{
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

@end
