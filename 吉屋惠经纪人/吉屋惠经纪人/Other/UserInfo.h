//
//  UserInfo.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface UserInfo : NSObject

singleton_interface(UserInfo);

@property (nonatomic, copy) NSString *userName;             //  用户名
@property (nonatomic, copy) NSString *password;             //  密码
@property (nonatomic, copy) NSString *realName;             //  真是姓名
@property (nonatomic, copy) NSString *currentCity;          //  当前城市
@property (nonatomic, copy) NSString *lastSignDate;         //  上次签到日期
@property (nonatomic, copy) NSString *lastSignUser;         //  上次签到用户
@property (nonatomic, copy) NSString *key;                  //  吉屋惠返回的key值
@property (nonatomic, assign) BOOL loginStatus;             //  登录状态
@property (nonatomic, assign) BOOL isLoginStatusChanged;    //  登录状态是否发生改变

- (void)loadUserInfoFromSanbox;
- (void)saveUserInfoToSanbox;

@end
