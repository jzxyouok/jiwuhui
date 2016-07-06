//
//  ReceiveCell.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ReceiveCell.h"

@interface ReceiveCell()

@property (nonatomic, weak)UIScrollView *scrollView;

@end

@implementation ReceiveCell

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = kColor(230, 230, 230);
        
        CGFloat scrollViewW = k_w;
        CGFloat scrollViewH = k_h - 160;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){0, 0, scrollViewW, scrollViewH}];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(4 * scrollViewW, scrollViewH);
        scrollView.contentOffset = CGPointMake(k_w, 0);
        scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < 4; i++) {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:(CGRect){k_w * i + (k_w - 130) / 2, k_h / 6.17, 130,130}];
            imageview.image = [UIImage imageNamed:@"icon_default_empty"];
            [scrollView addSubview:imageview];
            
            UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){k_w * i + (k_w - 170) / 2,CGRectGetMaxY(imageview.frame) + 20,170,40}];
            [scrollView addSubview:label];
            label.text = [NSString stringWithFormat:@"小吉正在努力审核推送中...敬请期待！"];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
        }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(BtnClick:) name:@"Broadcast" object:nil];
        
    }
    return self;
}

#pragma mark -UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i = scrollView.contentOffset.x / k_w;
    if (i == 0) {
        scrollView.contentOffset = CGPointMake(k_w * 2, 0);
    }else if (i == 3){
        scrollView.contentOffset = CGPointMake(k_w, 0);
    }
    if ([self.delegate respondsToSelector:@selector(receiveCellscrollViewDidEndDecelerating:)]) {
        [self.delegate receiveCellscrollViewDidEndDecelerating:i % 2];
    }
}

//  接收点击普通客户或者认证客户按钮后发出的通知，改变scrollView的偏移量
- (void)BtnClick:(NSNotification *)noti{
    [UIView animateWithDuration:0.5 animations:^{
        NSString *BtnTag = noti.userInfo[@"BtnTag"];
        if ([BtnTag isEqualToString:@"0"]) {
            _scrollView.contentOffset = CGPointMake(k_w, 0);
        }else {
            _scrollView.contentOffset = CGPointMake(k_w * 2, 0);
        }
    }];
    
}

@end
