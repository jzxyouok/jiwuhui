//
//  WalletView.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "WalletView.h"

@implementation WalletView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){0, 0, k_w, k_h - 64}];
        [self addSubview:scrollView];
        scrollView.contentSize = CGSizeMake(k_w, k_h - 112);
        scrollView.showsVerticalScrollIndicator = NO;
        
        //  余额按钮
        UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){0, 0, k_w, k_h * 0.397}];
        button.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:button];
        button.tag = 0;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  余额图标
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:(CGRect){(k_w - 115) / 2, 25, 115, 115}];
        imageview.image = [UIImage imageNamed:@"bag_icon"];
        [button addSubview:imageview];
        
        //  余额标签
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0, imageview.maxY + 14, k_w, 21}];
        [button addSubview:label];
        label.text = @"余额";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        //  余额
        UILabel *balanceLabel = [[UILabel alloc] initWithFrame:(CGRect){0, label.maxY + 10, k_w, 21}];
        [button addSubview:balanceLabel];
        balanceLabel.text = @"0.00";
        balanceLabel.font = [UIFont systemFontOfSize:24];
        balanceLabel.textColor = [UIColor blackColor];
        balanceLabel.textAlignment = NSTextAlignmentCenter;
        
        //  冻结金额按钮
        UIButton *button1 = [[UIButton alloc] initWithFrame:(CGRect){0, button.maxY + 1, k_w / 2 - 0.5, k_h * 0.132}];
        button1.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:button1];
        button1.tag = 1;
        [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  冻结金额
        UILabel *freezMoneyLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 14, k_w / 2, 21}];
        [button1 addSubview:freezMoneyLabel];
        freezMoneyLabel.text = @"0.00";
        freezMoneyLabel.font = [UIFont systemFontOfSize:15];
        freezMoneyLabel.textColor = [UIColor blackColor];
        freezMoneyLabel.textAlignment = NSTextAlignmentCenter;
        freezMoneyLabel.alpha = 0.9;
        
        //  冻结金额标签
        UILabel *label1 = [[UILabel alloc] initWithFrame:(CGRect){0, 39, k_w / 2, 21}];
        [button1 addSubview:label1];
        label1.text = @"冻结金额";
        label1.font = [UIFont systemFontOfSize:15];
        label1.textColor = [UIColor blackColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.alpha = 0.9;
        
        
        //  银行卡按钮
        UIButton *button2 = [[UIButton alloc] initWithFrame:(CGRect){k_w / 2 + 0.5, button.maxY + 1, k_w / 2 - 0.5, k_h * 0.132}];
        button2.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:button2];
        button2.tag = 2;
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  银行卡
        UILabel *cardnumLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 14, k_w / 2, 21}];
        [button2 addSubview:cardnumLabel];
        cardnumLabel.text = @"0";
        cardnumLabel.font = [UIFont systemFontOfSize:15];
        cardnumLabel.textColor = [UIColor blackColor];
        cardnumLabel.textAlignment = NSTextAlignmentCenter;
        cardnumLabel.alpha = 0.9;
        
        //  银行卡标签
        UILabel *label2 = [[UILabel alloc] initWithFrame:(CGRect){0, 39, k_w / 2, 21}];
        [button2 addSubview:label2];
        label2.text = @"银行卡";
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [UIColor blackColor];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.alpha = 0.9;
        
        //  账单记录按钮
        UIButton *button3 = [[UIButton alloc] initWithFrame:(CGRect){0, button1.maxY + 10, k_w / 2 - 0.5, k_h / 4}];
        button3.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:button3];
        button3.tag = 3;
        [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  账单记录图标
        UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:(CGRect){(k_w / 2 - 28) / 2, 37, 28, 28}];
        imageview1.image = [UIImage imageNamed:@"zhangdanjilu_icon"];
        [button3 addSubview:imageview1];
        
        //  账单记录标签
        UILabel *label3 = [[UILabel alloc] initWithFrame:(CGRect){0, imageview1.maxY + 18, k_w / 2, 21}];
        [button3 addSubview:label3];
        label3.text = @"账单记录";
        label3.font = [UIFont systemFontOfSize:18];
        label3.textColor = [UIColor blackColor];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.alpha = 0.8;
        
        //  常见问题按钮
        UIButton *button4 = [[UIButton alloc] initWithFrame:(CGRect){k_w / 2 + 0.5, button1.maxY + 10, k_w / 2 - 0.5, k_h / 4}];
        button4.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:button4];
        button4.tag = 4;
        [button4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  常见问题图标
        UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:(CGRect){(k_w / 2 - 28) / 2, 37, 28, 28}];
        imageview2.image = [UIImage imageNamed:@"wenti_icon"];
        [button4 addSubview:imageview2];
        
        //  常见问题标签
        UILabel *label4 = [[UILabel alloc] initWithFrame:(CGRect){0, imageview1.maxY + 18, k_w / 2, 21}];
        [button4 addSubview:label4];
        label4.text = @"常见问题";
        label4.font = [UIFont systemFontOfSize:18];
        label4.textColor = [UIColor blackColor];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.alpha = 0.8;
    }
    return self;
}

- (void)buttonClick:(UIButton *)button{
    self.buttonClick(button.tag);
}

@end
