//
//  IntegralMallViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "IntegralMallViewController.h"
#import "IntegralMallHeaderView.h"
#import "IntegralMallCell.h"
#import "LHCustomModalTransition.h"
#import "GiftDetailViewController.h"

@interface IntegralMallViewController ()<UITableViewDelegate,UITableViewDataSource,IntegralMallHeaderViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)IntegralMallHeaderView *headerView;
@property (nonatomic, strong)NSMutableArray *gifts;
@property (nonatomic, strong) LHCustomModalTransition *transition;
@property (nonatomic, copy) NSString *integral;

@end

@implementation IntegralMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [MBProgressHUD showMessage:nil toView:self.view];
    [self getGiftlData];
}

/**
 *  创建视图
 */
- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 52} style:UITableViewStylePlain];
    self.headerView = [[IntegralMallHeaderView alloc] initWithFrame:(CGRect){0, 0, k_w, 172}];
    self.headerView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kColor(238, 238, 238);
    
    //  设置导航栏
    [self setNavTitle:@"积分商城" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    
    //  设置底部文字
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:(CGRect){0, k_h - 35 - 64, k_w, 35}];
    bottomLabel.text = @"   本活动与苹果公司无关，最总解释权由吉屋网所有";
    bottomLabel.font = [UIFont systemFontOfSize:12];
    bottomLabel.textColor = kColor(150, 150, 150);
    [self.view addSubview:bottomLabel];
    bottomLabel.backgroundColor = kColor(238, 238, 238);
    
}

/**
 *  礼品数据
 */
-(void)getGiftlData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [mgr POST:kgiftListUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            self.gifts = dict[@"Gift"];
//            if (self.gifts.count == 0) {
                self.gifts = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gifts" ofType:@"plist"]];
//            }
            
            self.headerView.integral = dict[@"integral"];
            NSNumber *integral = dict[@"integral"];
            self.integral = integral.stringValue;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    });
}

#pragma mark - UITableViewControllerDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gifts.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 144;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    IntegralMallCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[IntegralMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dict = [self.gifts objectAtIndex:indexPath.row];
    GiftModel *gift = [[GiftModel alloc] initWithDict:dict];
    cell.gift = gift;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self.gifts objectAtIndex:indexPath.row];
    GiftModel *gift = [[GiftModel alloc] initWithDict:dict];
    
    [UIApplication sharedApplication].keyWindow.backgroundColor = kColor(0, 0, 0);
    
    //  设置动态切换效果
    GiftDetailViewController *viewcontroller = [GiftDetailViewController new];
    viewcontroller.gift = gift;
    viewcontroller.integral = self.integral;
    self.transition = [[LHCustomModalTransition alloc] initWithModalViewController:viewcontroller];
    viewcontroller.transitioningDelegate = self.transition;
    viewcontroller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewcontroller animated:YES completion:nil];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self hideTabBar:YES];
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

#pragma mark - IntegralMallHeaderViewDelegate

-(void)IntegralMallHeaderViewSignBtnClick:(UIButton *)button{
    //  获取当前时间
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    button.backgroundColor = kColor(255, 146, 76);
    [button setTitle:@"今日已签到" forState:UIControlStateNormal];
    //  如果已经签到
    if ([[UserInfo sharedUserInfo].lastSignDate isEqualToString:dateStr] && [[UserInfo sharedUserInfo].lastSignUser isEqualToString:[UserInfo sharedUserInfo].userName]){
        [ZTShowMessage showMessage:@"今日已经签到过了哦，明天再来吧~"];
    }else{
        //  如果还未签到
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"appType"] = @"0";
        params[@"key"] = [UserInfo sharedUserInfo].key;
        params[@"type"] = @"0";
        params[@"version"] = @"50";
        params[@"versionCode"] = @"50";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [mgr POST:kaddIntegralUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                NSNumber *resutl = dict[@"result"];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if ([resutl.stringValue isEqualToString:@"0"]) {
                        [UserInfo sharedUserInfo].lastSignDate = dateStr;
                        [UserInfo sharedUserInfo].lastSignUser = [UserInfo sharedUserInfo].userName;
                        [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
                        [self getGiftlData];
                    }else{
                        [ZTShowMessage showMessage:@"今日已经签到过了哦，明天再来吧~"];
                    }
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            }];
        });
    }
    
}

@end
