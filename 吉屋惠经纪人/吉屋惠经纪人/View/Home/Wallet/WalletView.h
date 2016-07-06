//
//  WalletView.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletView : UIView

@property (nonatomic, copy) void (^buttonClick)(NSInteger tag);

@end
