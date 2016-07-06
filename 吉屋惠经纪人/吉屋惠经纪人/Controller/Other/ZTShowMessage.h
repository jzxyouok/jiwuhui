//
//  ZTShowMessage.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/30.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTShowMessage : UIView

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message Title:(NSString *)title LeftButton:(NSString *)leftStr RightButton:(NSString *)rightStr leftBtnClick:(void (^)(void))leftblock rightBtnClick:(void (^)(void))rghtblock;

@end
