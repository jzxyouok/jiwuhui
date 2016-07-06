//
//  ViewController.m
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "TrendTableViewController.h"
#import "TrendCell.h"
#import "TrendModel.h"
#import "TrendFrameModel.h"

@interface TrendTableViewController ()<UITableViewDataSource,UITableViewDelegate,TrendFrameModelDelegate>

@property (nonatomic, strong) UITableView *tableView;       //  表视图
@property (nonatomic, strong)NSMutableArray *Agentbbs;      //  存放全部动态数据的数组
@property (nonatomic, strong)NSMutableDictionary *citys;    //  键:城市名  值:城市ID
@property (strong, nonatomic) UIButton *cover;
@property (strong, nonatomic) UIButton *imageview;
@property (nonatomic, assign) CGRect imageViewFrame;
@property (nonatomic, assign) int page;


@end

@implementation TrendTableViewController

//  懒加载
-(NSMutableDictionary *)citys{
    if (!_citys) {
        _citys = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityId.plist" ofType:nil]];
    }
    return _citys;
}

-(NSMutableArray *)Agentbbs{
    if (!_Agentbbs) {
        _Agentbbs = [NSMutableArray array];
    }
    return _Agentbbs;
}

- (UIButton *)cover{
    if(_cover == nil){
        _cover = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_cover];
        _cover.alpha = 0.0;
        
        [_cover addTarget:self action:@selector(smallImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cover;
}

- (UIButton *)imageview{
    if (!_imageview) {
        _imageview = [[UIButton alloc] init];
        [self.cover addSubview:_imageview];
    }
    return _imageview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self hideTabBar:NO];
    NSString *currentCity = [UserInfo sharedUserInfo].currentCity;
    
    //  如果沙盒中城市数据为空，则显示全部城市动态信息
    if (currentCity == nil) {
        [self getCityDataWithId:@"0" page:@"0"];
        return;
    }
    
    NSArray *cityArr = [self.citys allKeys];
    for (NSString *cityname in cityArr) {
        
        //  如果该城市数据不为空，从服务器获取数据
        if ([currentCity rangeOfString:cityname].location != NSNotFound) {
            [self getCityDataWithId:self.citys[cityname] page:@"0"];
            return;
        }
    }
    
}

- (void)leftBtnClick
{
    [MBProgressHUD showSuccess:@"好消息！"];
}

- (void)rightBtnClick
{
    [MBProgressHUD showSuccess:@"评论成功！"];
}

/**
 *  创建视图
 */
-(void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 64} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setNavTitle:@"全部动态" image:@"icon_arrow_down"];
    [self setNavLeftBtnWithTitle:@[@"消息"] OrImage:nil];
    [self setNavRightBtnWithTitle:nil OrImage:@[@"publish_bbs_icon"]];
    self.view.backgroundColor = kColor(238, 238, 238);
    
    
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
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
//    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    
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
    NSString *currentCity = [UserInfo sharedUserInfo].currentCity;
    NSArray *cityArr = [self.citys allKeys];
    for (NSString *cityname in cityArr) {
        //  如果该城市数据不为空，从服务器获取数据
        if (currentCity != nil && [currentCity rangeOfString:cityname].location != NSNotFound) {
            [self getCityDataWithId:self.citys[cityname] page:@"0"];
            return;
        }
    }
    [self getCityDataWithId:@"0" page:@"0"];
    
}

#pragma mark - loadMoreData
- (void)loadMoreData{
    // 刷新数据
    NSString *currentCity = [UserInfo sharedUserInfo].currentCity;
    NSArray *cityArr = [self.citys allKeys];
    for (NSString *cityname in cityArr) {
        //  如果该城市数据不为空，从服务器获取数据
        if (currentCity != nil && [currentCity rangeOfString:cityname].location != NSNotFound) {
            [self getCityDataWithId:self.citys[cityname] page:[NSString stringWithFormat:@"%d",_page++]];
            return;
        }
    }
    [self getCityDataWithId:@"0" page:[NSString stringWithFormat:@"%d",_page++]];
}

//
/**
 *  根据城市ID获取城市动态数据
 *
 *  @param cityID 城市ID
 *  @param page   页数
 */
- (void)getCityDataWithId:(NSString *)cityID page:(NSString *)page{
    if (cityID == nil)
        return;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //  设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityId"] = cityID;
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"page"] = page;
    params[@"pageSize"] = @"10";
    params[@"type"] = @"0,1,2,4";
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    //  请求url
    
    //  发送POST请求
    [mgr POST:kbbsListUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //  用于判断请求结果
        NSNumber *result = (NSNumber *)dict[@"result"];
        
        if (result.intValue == 0) {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.mj_footer endRefreshing];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.mj_header endRefreshing];
            
            if ([page isEqualToString:@"0"]) {
                self.page = 2;
                [self.Agentbbs removeAllObjects];
            }
            NSMutableArray *array = dict[@"Agentbbs"];
            for (NSDictionary *dict in array) {
                [self.Agentbbs addObject:dict];
            }
        }else if (result.intValue == -4){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.Agentbbs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

/**
 *  根据数据动态计算行高
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return 行高
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrendFrameModel *model = [[TrendFrameModel alloc] init];
    model.bbsData = self.Agentbbs[indexPath.section];
    return model.cellH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrendCell *cell = [TrendCell trendCellWithTableView:tableView];
    TrendFrameModel *model = [[TrendFrameModel alloc] init];
    model.bbsData = self.Agentbbs[indexPath.section];
    cell.btnTag = indexPath.section;
    cell.frameTrend = model;
    cell.delegate = self;
    return cell;
}

/**
 *  隐藏TabBar
 *
 *  @param hidden
 */
- (void) hideTabBar:(BOOL) hidden{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.0];
    MyTabBarViewController *tabBarViewController = (MyTabBarViewController *)self.tabBarController;
    if (hidden) {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h + 10, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    } else {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h - 49, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    }
    [UIView commitAnimations];
}

#pragma mark - TrendFrameModelDelegate

/**
 *  cell的图片点击
 *
 *  @param button
 */
-(void)trendFrameModelImageClick:(UIButton *)button{
    [self.imageview setBackgroundImage:button.imageView.image forState:UIControlStateNormal];
    [self.imageview setBackgroundImage:button.imageView.image forState:UIControlStateHighlighted];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[button convertRect: button.bounds toView:window];
    
    
    [UIView animateWithDuration:0 animations:^{
        self.imageViewFrame = rect;
        self.imageview.frame = rect;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.cover.alpha = 1;
            self.imageview.frame = CGRectMake(0, (k_h - k_w) / 2, k_w, k_w);
            self.navigationController.navigationBarHidden = YES;
            [self hideTabBar:YES];
        }];
    }];
    
    
    [self.imageview addTarget:self action:@selector(smallImage:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  让图片变小
 *
 *  @param button
 */
- (void)smallImage:(UIButton *)button{
    CGRect rect = self.imageview.frame;
    rect.origin.y -= 64;
    self.imageview.frame = rect;
    [UIView animateWithDuration:0.2 animations:^{
        self.cover.alpha = 0;
        CGRect rect = self.imageViewFrame;
        rect.origin.y -= 64;
        self.imageview.frame = rect;
    }];
    self.navigationController.navigationBarHidden = NO;
    [self hideTabBar:NO];
}

@end
