//
//  ReceiveGuestViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ReceiveGuestViewController.h"
#import "ReceiveView1.h"
#import "ReceiveCell.h"

@interface ReceiveGuestViewController ()<UITableViewDataSource,UITableViewDelegate,ReceiveCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIButton *genBtn;
@property (nonatomic, weak) UIButton *authBtn;

@end

@implementation ReceiveGuestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    [self setNavTitle:@"设置" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    [self setNavRightBtnWithTitle:@[@"管理"] OrImage:nil];
    self.view.backgroundColor = kColor(230, 230, 230);
    
    
    ReceiveView1 *view = [[ReceiveView1 alloc] initWithFrame:(CGRect){0,0,k_w,44}];
    [self.view addSubview:view];
    
    
    UIButton *genBtn = [[UIButton alloc] initWithFrame:(CGRect){21,60,(k_w - 40) / 2 ,36}];
    [genBtn setTitle:@"普通客户" forState:UIControlStateNormal];
    [genBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    genBtn.backgroundColor = kColor(0, 179, 90);
    [self.view addSubview:genBtn];
    genBtn.layer.cornerRadius = 3;
    genBtn.layer.borderWidth = 1;
    genBtn.layer.borderColor = kColor(0, 179, 90).CGColor;
    genBtn.layer.masksToBounds = YES;
    [genBtn addTarget:self action:@selector(genBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.genBtn = genBtn;
    
    UIButton *authBtn = [[UIButton alloc] initWithFrame:(CGRect){k_w / 2 - 1,60,(k_w - 40) / 2 ,36}];
    [authBtn setTitle:@"认证客户" forState:UIControlStateNormal];
    [authBtn setTitleColor:kColor(0, 179, 90) forState:UIControlStateNormal];
    authBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:authBtn];
    authBtn.layer.cornerRadius = 3;
    authBtn.layer.borderWidth = 1;
    authBtn.layer.borderColor = kColor(0, 179, 90).CGColor;
    authBtn.layer.masksToBounds = YES;
    [authBtn addTarget:self action:@selector(authBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.authBtn = authBtn;
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,CGRectGetMaxY(authBtn.frame),k_w,k_h - CGRectGetMaxY(authBtn.frame) - 64}];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kColor(230, 230, 230);
    self.tableView.allowsSelection = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    self.tableView.mj_header = header;
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    
    //  用于判断网络状态是否发生改变
    __block AFNetworkReachabilityStatus status1 = AFNetworkReachabilityStatusReachableViaWiFi;
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                if (status1 == AFNetworkReachabilityStatusReachableViaWiFi || status1 == AFNetworkReachabilityStatusReachableViaWWAN) break;
                status1 = status;
                
                //  网络状态发生改变，重新加载数据
                [self.tableView.mj_header beginRefreshing];
                break;
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                status1 = status;
                [MBProgressHUD showError:@"似乎已断开与互联网的连接"];
                break;
                
            default:
                break;
        }
    }];
    
    //  开始监控
    [mgr startMonitoring];
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

- (void)genBtnClick{
    [self changeBtn:0];
}

- (void)authBtnClick{
    [self changeBtn:1];
}

/**
 *  改变按钮选中状态
 *
 *  @param tag
 */
- (void)changeBtn:(int)tag{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"BtnTag"] = [NSString stringWithFormat:@"%d",tag];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"Broadcast" object:self userInfo:userInfo];
    
    if (tag == 0) {
        [_authBtn setTitleColor:kColor(0, 179, 90) forState:UIControlStateNormal];
        _authBtn.backgroundColor = [UIColor whiteColor];
        [_genBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _genBtn.backgroundColor = kColor(0, 179, 90);
    }else{
        [_authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _authBtn.backgroundColor = kColor(0, 179, 90);
        [_genBtn setTitleColor:kColor(0, 179, 90) forState:UIControlStateNormal];
        _genBtn.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - UITableViewControllerDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return k_h - CGRectGetMaxY(_authBtn.frame) - 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReceiveCell *cell = [[ReceiveCell alloc] init];
    cell.delegate = self;
    return cell;
}

- (void)loadNewData{
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData{
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - ReceiveCellDelegate

- (void)receiveCellscrollViewDidEndDecelerating:(int)i{
    if (i == 0) {
        [self authBtnClick];
    }else{
        [self genBtnClick];
    }
}

@end