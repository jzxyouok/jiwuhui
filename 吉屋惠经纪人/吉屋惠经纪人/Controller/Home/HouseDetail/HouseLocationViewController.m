//
//  HouseLocationViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HouseLocationViewController.h"

@interface HouseLocationViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong)BMKMapView* mapView;

@end

@implementation HouseLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView{
    [self setNavTitle:@"楼盘位置" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, k_w, k_h)];
    self.view = self.mapView;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.latitude.floatValue, self.longitude.floatValue);
    self.mapView.centerCoordinate = coordinate;
    self.mapView.zoomLevel = 17.0;
    
    
    BMKPointAnnotation *anno = [[BMKPointAnnotation alloc] init];
    anno.coordinate = coordinate;
    anno.title = self.annoTitle;
    [self.mapView addAnnotation:anno];
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
@end
