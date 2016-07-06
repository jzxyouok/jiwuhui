//
//  ReceiveCell.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReceiveCellDelegate <NSObject>

- (void)receiveCellscrollViewDidEndDecelerating:(int)i;

@end

@interface ReceiveCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, weak) id <ReceiveCellDelegate> delegate;

- (void)BtnClick:(UIButton *)button;

@end
