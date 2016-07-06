//
//  MyActionSheet.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/1.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyActionSheet : UIView

@property (nonatomic, copy) void (^block)(NSInteger tag);

+ (void)ShowActionSheetWithTitles:(NSArray *)titles finishChoose:(void (^)(NSInteger tag))code;

@end
