//
//  UserInfo.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "UserInfo.h"

#define UserKey             @"userName"
#define PasswordKey         @"password"
#define RealNameKey         @"RealName"
#define CurrentCityKey      @"currentCity"
#define LastSignDateKey     @"lastSignDate"
#define LastSignUserKey     @"lastSignUser"
#define KeyKey              @"key"
#define LoginStatusKey      @"LoginStatus"
#define IsLoginStatusKey    @"IsLoginStatus"


@implementation UserInfo

singleton_implementation(UserInfo);

/**
 *  保存数据到沙盒
 */
- (void)saveUserInfoToSanbox{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.userName forKey:UserKey];
    [userDefaults setObject:self.password forKey:PasswordKey];
    [userDefaults setObject:self.realName forKey:RealNameKey];
    [userDefaults setObject:self.currentCity forKey:CurrentCityKey];
    [userDefaults setObject:self.lastSignDate forKey:LastSignDateKey];
    [userDefaults setObject:self.lastSignUser forKey:LastSignUserKey];
    [userDefaults setObject:self.key forKey:KeyKey];
    [userDefaults setBool:self.loginStatus forKey:LoginStatusKey];
    [userDefaults setBool:self.isLoginStatusChanged forKey:IsLoginStatusKey];
    [userDefaults synchronize];
}

/**
 *  从沙盒取出数据
 */
-(void)loadUserInfoFromSanbox{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userName = [userDefaults objectForKey:UserKey];
    self.password = [userDefaults objectForKey:PasswordKey];
    self.realName = [userDefaults objectForKey:RealNameKey];
    self.currentCity = [userDefaults objectForKey:CurrentCityKey];
    self.lastSignDate = [userDefaults objectForKey:LastSignDateKey];
    self.lastSignUser = [userDefaults objectForKey:LastSignUserKey];
    self.key = [userDefaults objectForKey:KeyKey];
    self.loginStatus = [userDefaults boolForKey:LoginStatusKey];
    self.isLoginStatusChanged = [userDefaults boolForKey:IsLoginStatusKey];
}

@end
