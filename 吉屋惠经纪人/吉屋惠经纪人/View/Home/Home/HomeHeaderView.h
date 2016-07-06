//
//  HeaderView.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeaderViewDelegate <NSObject>

- (void)homeHeaderViewPosterClick:(NSURLRequest *)request;
- (void)homeHeaderViewIconClick:(NSInteger)tag;

@end

@interface HomeHeaderView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray *poster;
@property (nonatomic, weak) id<HomeHeaderViewDelegate>delegate;

@end
