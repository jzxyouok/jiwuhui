//
//  ZTShowMessage.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/30.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ZTShowMessage.h"

static void (^leftBlock)();
static void (^rightBlock)();
UIButton *backgroundMask;
UIView *messageView;

@interface ZTShowMessage()

@end

@implementation ZTShowMessage

/**
 *  消息提示框
 *
 *  @param message
 */
+(void)showMessage:(NSString *)message{
    UIView *messageView = [[UIView alloc] init];
    CGRect messageFrame = [message boundingRectWithSize:(CGSize){260,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:(CGRect){10,10,messageFrame.size.width,messageFrame.size.height}];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:16];
    messageLabel.numberOfLines = 0;
    
    messageLabel.textColor = [UIColor whiteColor];
    [messageView addSubview:messageLabel];
    messageFrame.size.width += 20;
    messageFrame.size.height += 20;
    
    messageView.frame = messageFrame;
    messageView.center = CGPointMake(k_w / 2, k_h / 2 );
    messageView.backgroundColor = [UIColor blackColor];
    
    messageView.alpha = 0.8;
    messageView.layer.cornerRadius = 10;
    messageView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:messageView];
    
    [UIView animateWithDuration:3 animations:^{
        messageView.alpha = 0;
    } completion:^(BOOL finished) {
        [messageView removeFromSuperview];
    }];
    
}

/**
 *  弹出消息提示框
 *
 *  @param message   消息
 *  @param title     标题
 *  @param leftStr   左按钮文字
 *  @param rightStr  右按钮文字
 *  @param leftblock 左按钮代码块
 *  @param rghtblock 右按钮代码块
 */
+ (void)showMessage:(NSString *)message Title:(NSString *)title LeftButton:(NSString *)leftStr RightButton:(NSString *)rightStr leftBtnClick:(void (^)(void))leftblock rightBtnClick:(void (^)(void))rghtblock{
    leftBlock = leftblock;
    rightBlock = rghtblock;
    
    //  黑色背景
    backgroundMask = [[UIButton alloc] initWithFrame:(CGRect){0, 0, k_w, k_h}];
    [backgroundMask addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    backgroundMask.backgroundColor = [UIColor blackColor];
    backgroundMask.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundMask];
    
    //  消息框
    messageView = [[UIView alloc] initWithFrame:(CGRect){(k_w - 280)/2,-150,280,143}];
    messageView.backgroundColor = kColor(238, 238, 238);
    [[UIApplication sharedApplication].keyWindow addSubview:messageView];
    
    //  消息
    UILabel *messagelabel = [[UILabel alloc] initWithFrame:(CGRect){0,40,messageView.frame.size.width,58}];
    messagelabel.text = message;
    messagelabel.font = [UIFont systemFontOfSize:14];
    messagelabel.textColor = kColor(130, 130, 130);
    messagelabel.backgroundColor = [UIColor whiteColor];
    messagelabel.textAlignment = NSTextAlignmentCenter;
    messagelabel.numberOfLines = 0;
    [messageView addSubview:messagelabel];
    
    if (title) {
        //  标题
        UILabel *titlelabel = [[UILabel alloc] initWithFrame:(CGRect){0,0,messageView.frame.size.width,49}];
        titlelabel.text = title;
        titlelabel.font = [UIFont systemFontOfSize:17];
        titlelabel.textColor = [UIColor blackColor];
        titlelabel.backgroundColor = [UIColor whiteColor];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        [messageView addSubview:titlelabel];
    }else{
        messagelabel.frame = (CGRect){0,0,messageView.frame.size.width,97};
    }
    
    
    //  分隔线1
    UIView *separactorline1 = [[UIView alloc] initWithFrame:(CGRect){0,97,280,1}];
    [messageView addSubview:separactorline1];
    separactorline1.backgroundColor = kColor(0, 179, 90);
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundMask.alpha = 0.7;
    }];
    
    //  左边按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 98, 140, 143 - 98)];
    [messageView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:leftStr forState:UIControlStateNormal];
    [leftButton setTitleColor:kColor(150, 150, 150) forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    leftButton.tag = 1;
    
    //  右边按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 98, 140, 143 - 98)];
    [messageView addSubview:rightButton];
    [rightButton addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:rightStr forState:UIControlStateNormal];
    [rightButton setTitleColor:kColor(0, 179, 90) forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    rightButton.tag = 2;
    
    messageView.transform = CGAffineTransformMakeRotation(-M_PI / 12);
    [UIView animateWithDuration:0.3 animations:^{
        messageView.center = [UIApplication sharedApplication].keyWindow.center;
        messageView.transform = CGAffineTransformMakeRotation(0);
    }];
}

/**
 *  点击消息框的按钮
 *
 */
+ (void)BtnClick:(UIView *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        backgroundMask.alpha = 0;
        messageView.transform = CGAffineTransformMakeRotation(-M_PI / 12);
        messageView.center = CGPointMake(k_w / 2, k_h + 130);
    } completion:^(BOOL finished) {
        [backgroundMask removeFromSuperview];
        [messageView removeFromSuperview];
        
        //  判断点击哪个按钮，执行哪个代码块
        if (sender.tag == 1) {
            leftBlock();
        }else if (sender.tag == 2){
            rightBlock();
        }
    }];
    
}

@end
