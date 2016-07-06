//
//  GiftDetailViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "GiftDetailViewController.h"
#import "GiftDetailView.h"

@interface GiftDetailViewController ()<GiftDetailViewDelegate>

@property (nonatomic, weak) GiftDetailView *view1;

@end

@implementation GiftDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    //  黑色背景视图
    CGFloat Y = k_h / 4.25;
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){0, 0, k_w , Y - 20}];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(maskviewClick) forControlEvents:UIControlEventTouchUpInside];
    
    //  商品信息视图
    GiftDetailView *view = [[GiftDetailView alloc] initWithFrame:(CGRect){0, Y,k_w, k_h - Y}];
    view.gift = self.gift;
    view.integral = self.integral;
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    self.view1 = view;
    view.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
        self.view1.maskview.alpha = 0;
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
        self.view1.maskview.alpha = 0.5;
    }];
}

/**
 *  点击了兑换积分按钮
 */
-(void)GiftDetailViewExchangeBtnClick{
    [self dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].keyWindow.backgroundColor = kColor(0, 179, 90);
        [ZTShowMessage showMessage:@"兑换礼品需完成公司认证、个人认证" Title:@"提示" LeftButton:@"放弃礼品" RightButton:@"速往认证" leftBtnClick:^{
            NNLog(@"left");
        } rightBtnClick:^{
            UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
            [self.navigationController pushViewController:userDetailViewController animated:YES];
        }];
    }];
}

#pragma mark - GiftDetailViewDelegate
/**
 *  点击了黑色背景视图
 */
- (void)maskviewClick{
    [self dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].keyWindow.backgroundColor = kColor(0, 179, 90);
    }];
}

@end
