//
//  IntegralMallHeaderView.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntegralMallHeaderViewDelegate <NSObject>

- (void)IntegralMallHeaderViewSignBtnClick:(UIButton *)button;

@end

@interface IntegralMallHeaderView : UIView

@property (nonatomic, copy) NSString *integral;
@property (nonatomic, weak) id <IntegralMallHeaderViewDelegate> delegate;

@end
