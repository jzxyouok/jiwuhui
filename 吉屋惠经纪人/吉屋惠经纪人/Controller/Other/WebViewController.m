//
//  BagHelpViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  初始化控制器
 *
 *  @param title       导航栏标题
 *  @param titleImage  导航栏标题的图片
 *  @param leftTitles  leftBarButtonItems文字
 *  @param leftImages  leftBarButtonItems的图片
 *  @param rightTitles rightBarButtonItems文字
 *  @param rightImages rightBarButtonItems的图片
 *  @param request     URL请求
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftTitle:(NSArray *)leftTitles leftImage:(NSArray *)leftImages rightTitle:(NSArray *)rightTitles rightImage:(NSArray *)rightImages request:(NSURLRequest *)request{
    self = [super init];
    if (self) {
        [self setNavTitle:title image:titleImage];
        [self setNavLeftBtnWithTitle:leftTitles OrImage:leftImages];
        [self setNavRightBtnWithTitle:rightTitles OrImage:rightImages];
        
        self.webView = [[UIWebView alloc] init];
        [self.view addSubview:self.webView];
        self.webView.frame = self.view.bounds;
        self.webView.scalesPageToFit = YES;
        [self.webView loadRequest:request];
        [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end