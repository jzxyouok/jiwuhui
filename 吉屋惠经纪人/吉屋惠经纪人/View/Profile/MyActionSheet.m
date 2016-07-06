//
//  MyActionSheet.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/1.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "MyActionSheet.h"

UIButton *maskview;
UIView *bottomview;
void (^block)(NSInteger tag);

@implementation MyActionSheet

/**
 *  弹出ActionSheet提示框
 *
 *  @param titles 按钮的title值数组
 *  @param code   点击按钮后返回一个tag值
 */
+ (void)ShowActionSheetWithTitles:(NSArray *)titles finishChoose:(void (^)(NSInteger tag))code{
    block = code;
    //  背景
    maskview = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskview.backgroundColor = [UIColor blackColor];
    maskview.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:maskview];
    [maskview addTarget:self action:@selector(maskviewClick) forControlEvents:UIControlEventTouchUpInside];
    
    //  底部视图
    bottomview = [[UIView alloc] initWithFrame:(CGRect){0, k_h, k_w, 69 + 48 * titles.count}];
    [[UIApplication sharedApplication].keyWindow addSubview:bottomview];
    
    //  按钮背景
    UIView *view2 = [[UIView alloc] initWithFrame:(CGRect){10, 0, k_w - 20,  48 * titles.count}];
    [bottomview addSubview:view2];
    view2.backgroundColor = [UIColor whiteColor];
    view2.layer.cornerRadius = 3;
    view2.layer.masksToBounds = YES;
    
    //  循环创建按钮
    int i = 0;
    for (NSString *title in titles) {
        UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){0, 48 * i++, k_w - 20, 48}];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kColor(0, 179, 0) forState:UIControlStateNormal];
        [view2 addSubview:button];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i != titles.count) {
            UIView *separator = [[UIView alloc] initWithFrame:(CGRect){0, 48 * i+1, k_w - 20, 1}];
            separator.backgroundColor = kColor(230, 230, 230);
            [view2 addSubview:separator];
        }
    }
    
    //  取消按钮
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){10, 48 * i + 10, k_w - 20, 48}];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [bottomview addSubview:button];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //  弹出底部视图
    [UIView animateWithDuration:0.5 animations:^{
        maskview.alpha = 0.2;
        bottomview.frame = CGRectMake(0, k_h - 69 - 48 * titles.count, k_w, 165);
    }];
}

/**
 *  退出后销毁视图
 */
+ (void)maskviewClick{
    [UIView animateWithDuration:0.5 animations:^{
        bottomview.frame = CGRectMake(0, k_h, k_w, 165);
        maskview.alpha = 0;
    }completion:^(BOOL finished) {
        [bottomview removeFromSuperview];
        [maskview removeFromSuperview];
    }];
}

/**
 *  按钮点击事件
 *
 *  @param button 传入按钮tag值
 */
+ (void)buttonClick:(UIButton *)button{
    [self maskviewClick];
    block(button.tag);
}

@end
