//
//  GiftDetailView.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@protocol GiftDetailViewDelegate <NSObject>

- (void)GiftDetailViewExchangeBtnClick;

@end

@interface GiftDetailView : UIView

@property (nonatomic, strong) GiftModel *gift;
@property (nonatomic, weak) UIView *maskview;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, weak) id <GiftDetailViewDelegate> delegate;

@end
