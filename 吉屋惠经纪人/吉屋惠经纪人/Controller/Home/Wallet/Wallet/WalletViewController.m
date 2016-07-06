//
//  WalletViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletView.h"
#import "WebViewController.h"
#import "AccountHisViewController.h"

@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
//    [self loadNewData];
}

- (void)setupView{
    [self setNavTitle:@"钱包" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    self.view.backgroundColor = kColor(238, 238, 238);
    
    WalletView *walletView = [[WalletView alloc] initWithFrame:(CGRect){0, 0, k_w, k_h - 64}];
    [self.view addSubview:walletView];
    walletView.buttonClick = ^(NSInteger tag){
        if (tag == 0) {
            
        //  冻结金额
        }else if (tag == 1) {
            WebViewController *bagHelpViewController = [[WebViewController alloc] initWithTitle:@"冻结金额" titleImage:nil leftTitle:nil leftImage:@[@"navigation_back"] rightTitle:nil rightImage:nil request:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://t.jiwu.com/html/redPacket/redPacket.html"]]];
            [self.navigationController pushViewController:bagHelpViewController animated:YES];
            
        //  银行卡
        }else if (tag == 2) {
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://pay.jiwu.com/payment/mfbank.html"]];
            request.HTTPMethod = @"POST";
            request.HTTPBody = [[NSString stringWithFormat:@"sign=73574f50aa3a86f014f28592bcfda6dd&uid=1463208722155&time=1467598600177&pid=20150806342&type=1"] dataUsingEncoding:NSUTF8StringEncoding];
            
            WebViewController *bagHelpViewController = [[WebViewController alloc] initWithTitle:@"我的银行卡" titleImage:nil leftTitle:nil leftImage:@[@"navigation_back"] rightTitle:nil rightImage:nil request:request];
            [self.navigationController pushViewController:bagHelpViewController animated:YES];
            
        //  账单记录
        }else if (tag == 3) {
            AccountHisViewController *accountHisViewController = [[AccountHisViewController alloc] init];
            [self.navigationController pushViewController:accountHisViewController animated:YES];
            
        //  常见问题
        }else{
            WebViewController *bagHelpViewController = [[WebViewController alloc] initWithTitle:@"常见问题" titleImage:nil leftTitle:nil leftImage:@[@"navigation_back"] rightTitle:nil rightImage:nil request:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://t.jiwu.com/html/bagHelp/index.html"]]];
            [self.navigationController pushViewController:bagHelpViewController animated:YES];
        }
    };
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
