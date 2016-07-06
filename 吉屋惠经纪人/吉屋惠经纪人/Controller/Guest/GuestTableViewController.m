//
//  GuestTableViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "GuestTableViewController.h"
#import "ReceiveGuestViewController.h"
#import "QualificationCell.h"
#import "ClientPoolCell.h"
#import "SongkeRuleCell.h"

@interface GuestTableViewController ()<UITableViewDelegate,UITableViewDataSource,ClientPoolCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSDictionary *data;
@property (nonatomic, strong)NSMutableDictionary *citys;    //  键:城市名  值:城市ID

@end

@implementation GuestTableViewController

//  懒加载
-(NSMutableDictionary *)citys{
    if (!_citys) {
        _citys = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityId.plist" ofType:nil]];
    }
    return _citys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadNewData];
}

/**
 *  创建视图
 */
- (void)setupView{
    [self setNavTitle:@"吉屋送客" image:nil];
    [self setNavRightBtnWithTitle:@[@"管理"] OrImage:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 64} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    
    
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return k_w - 10;
    }
    if (indexPath.row == 2) {
        return 550;
    }
    return 83;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //  我的资格
    if (indexPath.row == 0) {
        QualificationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [QualificationCell homeCellWithTableView:tableView];
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            data[@"approveNumber"] = self.data[@"approveNumber"];
            data[@"commonNumber"] = self.data[@"commonNumber"];
            data[@"auth_total_cus"] = self.data[@"auth_total_cus"];
            data[@"gen_total_cus"] = self.data[@"gen_total_cus"];
            cell.data = data;
        }
        return cell;
    }
    //  吉屋客户池
    if (indexPath.row == 1) {
        ClientPoolCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [ClientPoolCell homeCellWithTableView:tableView];
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            data[@"approveNumber"] = self.data[@"approveNumber"];
            data[@"commonNumber"] = self.data[@"commonNumber"];
            data[@"auth_convert_cus"] = self.data[@"auth_convert_cus"];
            data[@"gen_convert_cus"] = self.data[@"gen_convert_cus"];
            cell.data = data;
            cell.delegate = self;
        }
        return cell;
    }
    //  吉屋送客规则
    if (indexPath.row == 2) {
        SongkeRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [SongkeRuleCell homeCellWithTableView:tableView];
        }
        return cell;
    }
    
   return nil;
}

#pragma mark - loadNewData
- (void)loadNewData{
    // 刷新数据
    NSString *currentCity = [UserInfo sharedUserInfo].currentCity;
    NSArray *cityArr = [self.citys allKeys];
    for (NSString *cityname in cityArr) {
        //  如果该城市数据不为空，从服务器获取数据
        if (currentCity != nil && [currentCity rangeOfString:cityname].location != NSNotFound) {
            [self getCityDataWithId:self.citys[cityname]];
            return;
        }
    }
    [self getCityDataWithId:@"0"];
}

/**
 *  根据城市ID获取城市动态数据
 *
 *  @param cityID 城市ID
 */
- (void)getCityDataWithId:(NSString *)cityID{
    if (cityID == nil)
        return;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //  设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityId"] = cityID;
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    //  发送POST请求
    [mgr POST:kpushDataUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - ClientPoolCellDelegate

-(void)clientPoolCellReceiveBtnClick{
    ReceiveGuestViewController *receiveGuestViewController = [[ReceiveGuestViewController alloc] init];
    [self.navigationController pushViewController:receiveGuestViewController animated:YES];
}

@end
