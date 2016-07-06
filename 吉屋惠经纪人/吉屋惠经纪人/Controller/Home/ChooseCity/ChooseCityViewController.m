//
//  ChooseCityViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "HotCityCell.h"
#import <CoreLocation/CoreLocation.h>
#import "HomeTableViewController.h"

@interface ChooseCityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate,HotCityCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)NSDictionary *citys;
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, copy) NSString *locCity;
@property (nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation ChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
    [self setupTableView];
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }else{
        [self.locationManager startUpdatingLocation];
    }
    
    [self setNavTitle:@"选择城市" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
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
        self.tableView.frame = CGRectMake(0,44,k_w,k_h - 108);
    } else {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h - 49, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
        self.tableView.frame = CGRectMake(0,44,k_w,k_h - 157);
    }
    [UIView commitAnimations];
}

- (void)setupSearchBar{
    self.searchBar = [[UISearchBar alloc] initWithFrame:(CGRect){0,0,k_w,44}];
    [self.view addSubview:self.searchBar];
}

- (void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,44,k_w,k_h - 157} style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.currentCity = @"桂林";
}

- (NSDictionary *)citys{
    if (!_citys) {
        _citys = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citys.plist" ofType:nil]];
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
    [manager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        self.locCity = [placemark locality];
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSArray *array = [self.citys allKeys];
    return array.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
        return 1;
    
    NSArray *array = [self.citys allKeys];
    array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSArray *cityArr = [self.citys objectForKey:[array objectAtIndex:section - 2]];
    return cityArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 450;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) return @"GPS";
    if (section == 1) return @"热门城市";
    NSArray *array = [self.citys allKeys];
    array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    return [array objectAtIndex:section - 2];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *array = [self.citys allKeys];
    NSMutableArray *titlesArr = [NSMutableArray array];
    [titlesArr addObject:@"1"];
    [titlesArr addObject:@"."];
    
    array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSString *cityStr in array) {
        [titlesArr addObject:cityStr];
    }
    return titlesArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  GPS定位城市cell
    if(indexPath.section == 0){
        static NSString *CellIdentifier = @"Cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        for (UIView *childView in cell.contentView.subviews) {
            if ([childView isKindOfClass:[UILabel class]]){
                [childView removeFromSuperview];
            }
        }
        
        cell.textLabel.text = @"定位城市：";
        UILabel *currentCityLabel = [[UILabel alloc] initWithFrame:(CGRect){100,11,100,21}];
        currentCityLabel.text = self.locCity;
        currentCityLabel.textColor = [UIColor redColor];
        [cell.contentView addSubview:currentCityLabel];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(k_w - 44, 10, 24, 24)];
        [cell.contentView addSubview:button];
        [button setBackgroundImage:[UIImage imageNamed:@"loc"] forState:UIControlStateNormal];
        
        
        return cell;
        
    //  热门城市cell
    }else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"Cell1";
        HotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[HotCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = NO;
            cell.delegate = self;
        }
        return cell;
    }
    
    
    //  所有城市cell
    static NSString *CellIdentifier1 = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    NSArray *array = [self.citys allKeys];
    array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSArray *cityArr = [self.citys objectForKey:[array objectAtIndex:indexPath.section - 2]];
    cell.textLabel.text = [cityArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self finisheChoose:self.locCity];
    }else if (indexPath.section == 1) {
        
    }else{
        NSArray *array = [self.citys allKeys];
        array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        NSArray *cityArr = [self.citys objectForKey:[array objectAtIndex:indexPath.section - 2]];
        [self finisheChoose:[cityArr objectAtIndex:indexPath.row]];
    }
}

- (void)finisheChoose:(NSString *)city{
    if ([self.delegate respondsToSelector:@selector(chooseCityViewControllerDidFinishChoose:)]) {
        [self.delegate chooseCityViewControllerDidFinishChoose:city];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HotCityCellDelegate

-(void)hotCityCellCityButtonClick:(NSString *)city{
    [self finisheChoose:city];
}


#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
