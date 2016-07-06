//
//  HouseParameterViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HouseParameterViewController.h"

@interface HouseParameterViewController ()

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UILabel *bstimeLabel;
@property (nonatomic, strong)UILabel *bftimeLabel;
@property (nonatomic, strong)UILabel *designHouseNumLabel;
@property (nonatomic, strong)UILabel *bulkPercentageLabel;
@property (nonatomic, strong)UILabel *parkingNumLabel;
@property (nonatomic, strong)UILabel *decorationLabel;
@property (nonatomic, strong)UILabel *totalAreaLabel;
@property (nonatomic, strong)UILabel *buildAreaLabel;
@property (nonatomic, strong)UILabel *buildTypeLabel;
@property (nonatomic, strong)UILabel *developerLabel;
@property (nonatomic, strong)UILabel *pnameLabel;
@property (nonatomic, strong)UILabel *propertyTypeLabel;
@property (nonatomic, strong)UILabel *pmpriceLabel;

@end

@implementation HouseParameterViewController

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 64}];
        _scrollView.contentSize = CGSizeMake(k_w, k_h - 112);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(NSMutableArray *)parameters{
    if (!_parameters) {
        _parameters = [NSMutableArray array];
    }
    return _parameters;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}

- (void)setupView{
    [self setNavTitle:@"楼盘参数" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    
    NSArray *array = @[@"开盘时间：",@"交房时间：",@"总  户  数：",@"容  积  率：",@"车  位  数：",@"装修情况：",@"占地面积：",@"建筑面积：",@"建筑类型：",@"开  发  商：",@"物业公司：",@"物业类型：",@"业  务  费："];
    
    for (int i = 0; i < 26; i++) {
        UILabel *bstimeLabel = [[UILabel alloc] init];
        
        NSString *str;
        if (i < 13) {
            str = [array objectAtIndex:i];
        }else{
            str = [self.parameters objectAtIndex:i - 13];
        }
        
        CGRect bstimeFrame = [str boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        if (i < 13) {
            bstimeFrame.origin.x = 15;
            bstimeFrame.origin.y = 5 + i * 26.6;
        }else{
            bstimeFrame.origin.x = 85;
            bstimeFrame.origin.y = 5 + (i - 13) * 26.6;
        }
        bstimeLabel.frame = bstimeFrame;
        bstimeLabel.text = str;
        bstimeLabel.font = [UIFont systemFontOfSize:14];
        bstimeLabel.textColor = [UIColor blackColor];
        [self.scrollView addSubview:bstimeLabel];
    }
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
