//
//  HeaderView.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ProfileHeaderView.h"

@implementation ProfileHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, k_w, 200);
        self.backgroundBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, k_w, 200)];
        [self addSubview:self.backgroundBtn];
        [self.backgroundBtn addTarget:self action:@selector(backGroundBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundBtn setBackgroundImage:[UIImage imageNamed:@"icon_mine_head"] forState:UIControlStateNormal];
        
        
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){(k_w - 160) / 2, 120, 160, 80}];
        view.userInteractionEnabled = NO;
        [self addSubview:view];
        
        //  头像
        UIImageView *personImageView = [[UIImageView alloc] initWithFrame:(CGRect){(k_w - 70) / 2,40,70,70}];
        personImageView.image = [UIImage imageNamed:@"icon_mine_person"];
        [self addSubview:personImageView];
        personImageView.layer.cornerRadius = 35;
        personImageView.layer.borderWidth = 5;
        personImageView.layer.borderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1].CGColor;
        personImageView.layer.masksToBounds = YES;
        
        if ([UserInfo sharedUserInfo].loginStatus == YES) {
            //  头像
            UIImageView *modifyImageView = [[UIImageView alloc] initWithFrame:(CGRect){CGRectGetMaxX(personImageView.frame) - 20,CGRectGetMaxY(personImageView.frame) - 30,20,20}];
            modifyImageView.image = [UIImage imageNamed:@"icon_mine_modify"];
            [self addSubview:modifyImageView];
            modifyImageView.layer.cornerRadius = 10;
            modifyImageView.layer.borderWidth = 2;
            modifyImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            modifyImageView.layer.masksToBounds = YES;
            
            //  姓名
            UILabel *realNameLabel = [[UILabel alloc] init];
            CGRect realNameFrame = [[UserInfo sharedUserInfo].realName boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            realNameFrame.origin.x = 14;
            realNameFrame.origin.y = 2;
            realNameLabel.frame = realNameFrame;
            
            realNameLabel.text = [UserInfo sharedUserInfo].realName;
            realNameLabel.font = [UIFont systemFontOfSize:15];
            realNameLabel.textColor = [UIColor whiteColor];
            [view addSubview:realNameLabel];
            
            
            
            //  实
            UILabel *realLabel = [[UILabel alloc] initWithFrame:(CGRect){CGRectGetMaxX( realNameLabel.frame) + 15,2,18,18}];
            realLabel.text = @"实";
            realLabel.font = [UIFont systemFontOfSize:14];
            realLabel.textColor = [UIColor whiteColor];
            [view addSubview:realLabel];
            realLabel.backgroundColor = kColor(238, 238, 238);
            realLabel.textAlignment = NSTextAlignmentCenter;
            //  证
            UILabel *proveLabel = [[UILabel alloc] initWithFrame:(CGRect){CGRectGetMaxX( realLabel.frame) + 5,2,18,18}];
            proveLabel.text = @"证";
            proveLabel.font = [UIFont systemFontOfSize:14];
            proveLabel.textColor = [UIColor whiteColor];
            [view addSubview:proveLabel];
            proveLabel.backgroundColor = kColor(238, 238, 238);
            proveLabel.textAlignment = NSTextAlignmentCenter;
            //  v
            UILabel *vLabel = [[UILabel alloc] initWithFrame:(CGRect){CGRectGetMaxX( proveLabel.frame) + 5,2,18,18}];
            vLabel.text = @"v";
            vLabel.font = [UIFont systemFontOfSize:14];
            vLabel.textColor = [UIColor whiteColor];
            [view addSubview:vLabel];
            vLabel.backgroundColor = kColor(238, 238, 238);
            vLabel.textAlignment = NSTextAlignmentCenter;
            
            //  账号
            UILabel *userNameLabel = [[UILabel alloc] initWithFrame:(CGRect){0,28,160,26}];
            userNameLabel.text = [UserInfo sharedUserInfo].userName;
            userNameLabel.font = [UIFont systemFontOfSize:15];
            userNameLabel.textColor = [UIColor whiteColor];
            [view addSubview:userNameLabel];
            userNameLabel.textAlignment = NSTextAlignmentCenter;
            
            //  认证经纪人
            UILabel *agentLabel = [[UILabel alloc] initWithFrame:(CGRect){0,50,160,26}];
            agentLabel.text = @"未认证经纪人";
            agentLabel.font = [UIFont systemFontOfSize:15];
            agentLabel.textColor = [UIColor whiteColor];
            [view addSubview:agentLabel];
            agentLabel.textAlignment = NSTextAlignmentCenter;
            
        }else{
            
            //  未登录
            UILabel *unLoginLabel = [[UILabel alloc] initWithFrame:(CGRect){3,0,160,26}];
            unLoginLabel.text = @"请登录";
            unLoginLabel.font = [UIFont systemFontOfSize:15];
            unLoginLabel.textColor = [UIColor whiteColor];
            [view addSubview:unLoginLabel];
            unLoginLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return self;
}

- (void)backGroundBtnClick{
    if ([self.delegate respondsToSelector:@selector(profileHeaderViewLoginButtonClick)]) {
        [self.delegate profileHeaderViewLoginButtonClick];
    }
}

@end