//
//  LoginViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong)UITextField *userName;
@property (nonatomic, strong)UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 *  创建视图
 */
- (void)setupView{
    [self setNavTitle:@"登录" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    [self setNavRightBtnWithTitle:@[@"注册"] OrImage:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //  控件背景
    CGFloat viewX = 30;
    CGFloat viewY = 20;
    CGFloat viewW = k_w - 60;
    CGFloat viewH = 230;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){viewX,viewY,viewW,viewH}];
    [self.view addSubview:view];
    
    //  用户名文本框
    self.userName = [[UITextField alloc] initWithFrame:(CGRect){0,0,viewW,50}];
    self.userName.text = [UserInfo sharedUserInfo].userName;
    self.userName.backgroundColor = [UIColor clearColor];
    [view addSubview:self.userName];
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userName.font = [UIFont systemFontOfSize:15];
    
    UIButton *leftView = [[UIButton alloc] initWithFrame:(CGRect){0,0,23 + 15,23}];
    self.userName.leftView = leftView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    [leftView setImage:[UIImage imageNamed:@"login_phone"] forState:UIControlStateNormal];
    leftView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    leftView.userInteractionEnabled = NO;
    
    //  分隔线1
    UIView *separactorline1 = [[UIView alloc] initWithFrame:(CGRect){0,50,viewW,1}];
    [view addSubview:separactorline1];
    separactorline1.backgroundColor = kColor(233, 233, 233);
    
    //  密码文本框
    self.password = [[UITextField alloc] initWithFrame:(CGRect){0,50,viewW,50}];
    self.password.text = [UserInfo sharedUserInfo].password;
    self.password.backgroundColor = [UIColor clearColor];
    [self.password setSecureTextEntry:YES];
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.font = [UIFont systemFontOfSize:15];
    
    [view addSubview:self.password];
    UIButton *leftView1 = [[UIButton alloc] initWithFrame:(CGRect){0,0,23 + 15,23}];
    self.password.leftView = leftView1;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    [leftView1 setImage:[UIImage imageNamed:@"login_pass"] forState:UIControlStateNormal];
    leftView1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    leftView1.userInteractionEnabled = NO;
    
    //  分隔线2
    UIView *separactorline2 = [[UIView alloc] initWithFrame:(CGRect){0,100,viewW,1}];
    [view addSubview:separactorline2];
    separactorline2.backgroundColor = kColor(233, 233, 233);
    
    //  登录按钮文本框
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 130, viewW - 10, 50)];
    [view addSubview:button];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = kColor(255, 136, 56);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    
    //  忘记密码
    UIButton *forgotBtn = [[UIButton alloc] initWithFrame:(CGRect){viewW - 64,viewH - 18,64,1}];
    [view addSubview:forgotBtn];
    [forgotBtn addTarget:self action:@selector(forgotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgotBtn setTitleColor:kColor(106, 106, 106) forState:UIControlStateNormal];
    forgotBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //  分隔线3
    UIView *separactorline3 = [[UIView alloc] initWithFrame:(CGRect){viewW - 64,viewH - 10,64,1}];
    [view addSubview:separactorline3];
    separactorline3.backgroundColor = kColor(176, 176, 176);
}

/**
 *  点击登录按钮
 *
 *  @param button 
 */
- (void)login:(UIButton *)button{
    if (self.userName.text.length == 0) {
        [ZTShowMessage showMessage:@"请输入手机号码"];
        return;
    }else if(self.password.text.length == 0){
        [ZTShowMessage showMessage:@"请输入密码"];
        return;
    }
    [self loginWithUserName:self.userName.text password:self.password.text];
}

/**
 *  发送登录请求
 *
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password{
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //  设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_key"] = @"12345678";
    params[@"channelId"] = @"appstore";
    params[@"deviceNumber"] = @"CDED4FEEFBF04B9780464FA4BF7C0C27";
    params[@"deviceType"] = @"IOS";
    params[@"key"] = @"";
    params[@"password"] = password;
    params[@"sessionId"] = @"123";
    params[@"timestamp"] = [NSDate date];
    params[@"userName"] = userName;
    params[@"v"] = @"2.00";
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    //  发送POST请求
    [mgr POST:kloginUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *agent = dict[@"agent"];
        
        //  如果登陆成功，则dict[@"agent"]值不为空
        if (dict[@"agent"]) {
            [UserInfo sharedUserInfo].userName = self.userName.text;
            [UserInfo sharedUserInfo].password = self.password.text;
            [UserInfo sharedUserInfo].realName = agent[@"turename"];
            [UserInfo sharedUserInfo].key = agent[@"appkey"];
            [UserInfo sharedUserInfo].loginStatus = YES;
            [UserInfo sharedUserInfo].isLoginStatusChanged = YES;
            [[UserInfo sharedUserInfo] saveUserInfoToSanbox];
            
            [MBProgressHUD showSuccess:@"登陆成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"似乎已断开与互联网的连接"];
    }];
}

- (void)forgotBtnClick{
    [ZTShowMessage showMessage:@"找回密码"];
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick{
    [ZTShowMessage showMessage:@"注册成功"];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    [self hideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideTabBar:NO];
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
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h - 149, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    }
    [UIView commitAnimations];
}

@end
