//
//  HomeTableViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "HomeTableViewController.h"
#import "ChooseCityViewController.h"
#import "HomeHeaderView.h"
#import "HomeCell.h"
#import "HouseDetailViewController.h"
#import "LoginViewController.h"
#import "GodViewController.h"
#import "NewsViewController.h"
#import "IntegralMallViewController.h"
#import "WalletViewController.h"

@interface HomeTableViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,ChooseCityViewControllerDelegate,HomeHeaderViewDelegate,GodViewControllerDelegate>

@property (nonatomic, strong) UITableView         *tableView;           //  表视图
@property (nonatomic, strong) UIButton            *godButton;           //  财神爷按钮
@property (nonatomic, strong) NSMutableArray      *homes;               //  存放城市数据的数组
@property (nonatomic, strong) NSMutableDictionary *citys;               //  键:城市名  值:城市ID
@property (nonatomic, strong) UIView              *messageView;         //  消息提示框
@property (nonatomic, strong) HomeHeaderView      *headerView;
@property (nonatomic, strong) CLLocationManager   *locationManager;
@property (nonatomic, copy  ) NSString            *locCity;
@property (nonatomic, assign) BOOL                isNeedLocate;
@property (nonatomic, assign) BOOL                isNoMoreData;
@property (nonatomic, assign) int                 page;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

-(NSMutableArray *)homes{
    if (!_homes) {
        _homes = [NSMutableArray array];
    }
    return _homes;
}

//  懒加载
-(NSMutableDictionary *)citys{
    if (!_citys) {
        _citys = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityId.plist" ofType:nil]];
    }
    return _citys;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    static int i = 0;
    if (i++ != 0) return;
    
    [manager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        self.currentCity = [placemark locality];
        [UserInfo sharedUserInfo].currentCity = [placemark locality];
        [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
        
        NSArray *cityArr = [self.citys allKeys];
        [self setNavTitle:[placemark locality] image:@"icon_arrow_down"];
        for (NSString *cityname in cityArr) {
            //  如果该城市数据不为空，从服务器获取数据
            if ([[placemark locality] rangeOfString:cityname].location != NSNotFound) {
                [self getCityDataWithId:self.citys[cityname] page:@"0"];
                [self getPosterWithId:self.citys[cityname]];
                return;
            }
        }
    }];
}

/**
 *  判断是否能够定位
 *
 *  @param manager
 *  @param status
 */
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusDenied) {
        self.isNeedLocate = NO;
    }else if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.isNeedLocate = YES;
    }
}

#pragma mark -getCityDataWithId

/**
 *  根据城市ID获取城市数据
 *
 *  @param cityId 城市ID
 *  @param page   页数
 */
- (void)getCityDataWithId:(NSString *)cityId page:(NSString *)page{
    if (cityId == nil) return;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //  设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityId"] = cityId;
    params[@"isSide"] = @"0";
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"page"] = page;
    params[@"pageSize"] = @"10";
    params[@"seeclient"] = @"0";
    params[@"sortWay"] = @"1";
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    //  发送POST请求
    [mgr POST:khomeListUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //  用于判断请求结果
        NSNumber *result = (NSNumber *)dict[@"result"];
        
        if (result.intValue == 0) {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.mj_footer endRefreshing];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.mj_header endRefreshing];
            
            if ([page isEqualToString:@"0"]) {
                self.page = 2;
                [self.homes removeAllObjects];
            }
            NSMutableArray *array = dict[@"Homes"];
            for (NSDictionary *dict in array) {
                [self.homes addObject:dict];
            }
        }else if (result.intValue == -4){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_footer endRefreshing];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  获取首页广告数据
 *
 *  @param cityId 城市ID
 */
- (void)getPosterWithId:(NSString *)cityId{
    if (cityId == nil) return;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"cityId"] = @"37";
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    [mgr POST:kappPosterUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self.headerView.poster = dict[@"Poster"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/**
 *  创建视图
 */
- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 27} style:UITableViewStyleGrouped];
    self.headerView = [[HomeHeaderView alloc] init];
    self.headerView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setNavRightBtnWithTitle:nil OrImage:@[@"home_navi_right"]];
    [self setupGodButton];
    self.isNeedLocate = NO;
    self.isNoMoreData = NO;
    self.page = 2;
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置颜色
    header.stateLabel.alpha = 0.6;
    
    // 设置刷新控件
    self.tableView.mj_header = header;
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = -40;
    [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    
    
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //  从沙盒取出当前城市
    self.currentCity = [UserInfo sharedUserInfo].currentCity;
    
    //  用于判断网络状态是否发生改变
    __block AFNetworkReachabilityStatus status1;
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (status1 == AFNetworkReachabilityStatusReachableViaWiFi || status1 == AFNetworkReachabilityStatusReachableViaWWAN) break;
                status1 = status;
                
                //  网络状态发生改变，重新加载数据
                [self loadNewData];
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

#pragma mark - loadNewData
- (void)loadNewData{
    // 刷新数据
    NSArray *cityArr = [self.citys allKeys];
    for (NSString *cityname in cityArr) {
        //  如果该城市数据不为空，从服务器获取数据
        if (self.currentCity != nil && [self.currentCity rangeOfString:cityname].location != NSNotFound) {
            [self setNavTitle:self.currentCity image:@"icon_arrow_down"];
            [self getCityDataWithId:self.citys[cityname] page:@"0"];
            [self getPosterWithId:self.citys[cityname]];
            return;
        }
    }
    if (self.isNeedLocate) {
        [self.locationManager startUpdatingLocation];
    }else{
        //  如果该城市数据为空，则显示全部城市
        [self setNavTitle:@"全国" image:@"icon_arrow_down"];
        [ZTShowMessage showMessage:@"您所选的城市暂无楼盘信息，已为您切换到全国楼盘信息."];
        [UserInfo sharedUserInfo].currentCity = nil;
        [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
        [self getCityDataWithId:@"0" page:@"0"];
        [self getPosterWithId:@"0"];
    }
    
}

#pragma mark - loadMoreData
- (void)loadMoreData{
    // 刷新数据
    NSArray *cityArr = [self.citys allKeys];
    for (NSString *cityname in cityArr) {
        //  如果该城市数据不为空，从服务器获取数据
        if (self.currentCity != nil && [self.currentCity rangeOfString:cityname].location != NSNotFound) {
            [self getCityDataWithId:self.citys[cityname] page:[NSString stringWithFormat:@"%d",_page++]];
            return;
        }
    }
    [self getCityDataWithId:@"0" page:[NSString stringWithFormat:@"%d",_page++]];
}



#pragma mark - ChooseCityViewControllerDelegate

/**
 *  选择城市完成后的代理
 *
 *  @param city 城市名
 */
-(void)chooseCityViewControllerDidFinishChoose:(NSString *)city{
    self.currentCity = city;
    
    [UserInfo sharedUserInfo].currentCity = city;
    [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
    
    [self setNavTitle:self.currentCity image:@"icon_arrow_down"];
    self.isNeedLocate = NO;
    [self loadNewData];
}

/**
 *  点击标题后进入选择城市控制器
 */
- (void)titleBtnClick{
    ChooseCityViewController *chooseCityViewController = [[ChooseCityViewController alloc] init];
    chooseCityViewController.delegate = self;
    [self.navigationController pushViewController:chooseCityViewController animated:YES];
}

#pragma mark - UITableViewControllerDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homes.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [HomeCell homeCellWithTableView:tableView];
    }
    cell.homeData = [self.homes objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    
    return cell;
}

/**
 *  选中cell后，将fid传给楼盘详情控制器
 *
 *  @param tableView
 *  @param indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HouseDetailViewController *houseDetailViewController = [[HouseDetailViewController alloc] init];
    [self.navigationController pushViewController:houseDetailViewController animated:YES];
    
    NSDictionary *dict = self.homes[indexPath.row];
    houseDetailViewController.fid = dict[@"fid"];
}

/**
 *  创建财神爷浮动按钮
 */
- (void)setupGodButton{
    CGFloat buttonW = 60;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(k_w - buttonW, k_h / 2 - buttonW / 2, buttonW, buttonW)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(godButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.godButton = button;
    
    UIImageView *godImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, buttonW, buttonW)];
    [button addSubview:godImageView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGod:)];
    [button addGestureRecognizer:pan];
    
    NSArray *imageName = @[@"God_down_",@"God_in_",@"God_up_"];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:imageName[i]];
        [images addObject:image];
    }
    
    godImageView.animationImages = images;
    godImageView.animationDuration = 1;
    godImageView.animationRepeatCount = 0;
    [godImageView startAnimating];
}

/**
 *  财神爷点击事件
 */
- (void)godButtonClick{
    GodViewController *godViewController = [[GodViewController alloc] init];
    godViewController.homes = self.homes;
    godViewController.delegate = self;
    [self presentViewController:godViewController animated:YES completion:nil];
}

/**
 *  平移财神爷按钮
 *
 *  @param pan
 */
- (void)panGod:(UIPanGestureRecognizer *)pan{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(godStop) object:nil];
    CGPoint point = [pan translationInView:self.godButton];
    
    
    CGRect frame = self.godButton.frame;
    
    
    if (frame.origin.y <= k_h - 170 && frame.origin.y >= 0) {
        self.godButton.transform = CGAffineTransformTranslate(self.godButton.transform, point.x, point.y);
        [pan setTranslation:CGPointZero inView:self.godButton];
    }
    
    
    [self performSelector:@selector(godStop) withObject:nil afterDelay:0.2];
    
}

/**
 *  停止平移财神爷按钮
 */
-(void)godStop{
    CGRect frame = self.godButton.frame;
    if (frame.origin.x > k_w/2 - frame.size.width/2) {
        frame.origin.x = k_w - frame.size.width;
    }else{
        frame.origin.x = 0;
    }
    
    if (frame.origin.y > k_h - 115 - frame.size.height){
        frame.origin.y = k_h - 115 - frame.size.height;
    }
    
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.godButton.frame = frame;
    }];
}

#pragma mark - GodViewControllerDelegate

- (void)godDetailViewControllerFinishChoose:(NSString *)fid{
    
    HouseDetailViewController *houseDetailViewController = [[HouseDetailViewController alloc] init];
    houseDetailViewController.fid = fid;
    [self.navigationController pushViewController:houseDetailViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    if ([UserInfo sharedUserInfo].loginStatus == NO) {
        [self setNavLeftBtnWithTitle:@[@"登录"] OrImage:nil];
    }else{
        [self setNavLeftBtnWithTitle:@[@""] OrImage:nil];
    }
    
    [self hideTabBar:NO];
}

- (void)dealloc{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
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

/**
 *  登录
 */
- (void)leftBtnClick
{
    if ([UserInfo sharedUserInfo].loginStatus == NO) {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }else{
        
    }
}

- (void)rightBtnClick
{
    [MBProgressHUD showSuccess:@"添加成功！"];
}

#pragma mark - HomeHeaderViewDelegate

- (void)homeHeaderViewPosterClick:(NSURLRequest *)request{
    WebViewController *bagHelpViewController = [[WebViewController alloc] initWithTitle:@"最新活动" titleImage:nil leftTitle:nil leftImage:@[@"navigation_back"] rightTitle:nil rightImage:@[@"navigation_share"] request:request];
    [self.navigationController pushViewController:bagHelpViewController animated:YES];
}

- (void)homeHeaderViewIconClick:(NSInteger)tag{
    //  消息盒子
    if (tag == 0) {
        NewsViewController *newsViewController = [[NewsViewController alloc] init];
        [self.navigationController pushViewController:newsViewController animated:YES];
        
        //  钱包
    }else if (tag == 1) {
        WalletViewController *walletViewController = [[WalletViewController alloc] init];
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:walletViewController];
        nav1.navigationBar.barTintColor = kColor(0, 179, 90);
        nav1.navigationBar.translucent = NO;
        [self presentViewController:nav1 animated:YES completion:nil];
        
        //  积分商城
    }else if (tag == 2) {
        IntegralMallViewController *integralMallViewController = [[IntegralMallViewController alloc] init];
        [self.navigationController pushViewController:integralMallViewController animated:YES];
    
    //  优选经纪人
    }else if (tag == 3) {
        [ZTShowMessage showMessage:@"亲，认证是你拿高佣的保障哟！" Title:@"认证个人信息" LeftButton:@"暂不" RightButton:@"认证个人信息" leftBtnClick:^{
            
        } rightBtnClick:^{
            UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
            [self.navigationController pushViewController:userDetailViewController animated:YES];
        }];
        
    //  微店
    }else if (tag == 4) {
        [ZTShowMessage showMessage:@"亲，认证是你拿高佣的保障哟！" Title:@"认证个人信息" LeftButton:@"暂不" RightButton:@"认证个人信息" leftBtnClick:^{
            
        } rightBtnClick:^{
            UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
            [self.navigationController pushViewController:userDetailViewController animated:YES];
        }];
    }
}

@end
