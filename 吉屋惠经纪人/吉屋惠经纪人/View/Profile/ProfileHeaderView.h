//
//  HeaderView.h
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileHeaderViewDelegate <NSObject>

- (void)profileHeaderViewLoginButtonClick;

@end

@interface ProfileHeaderView : UIView

@property (nonatomic, strong)UIButton *backgroundBtn;
@property (nonatomic, weak)id <ProfileHeaderViewDelegate>delegate;

@end
