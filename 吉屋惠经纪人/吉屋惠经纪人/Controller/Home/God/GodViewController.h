//
//  GodViewController.h
//  吉屋惠经纪人
//
//  Created by mac on 16/6/11.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GodViewControllerDelegate <NSObject>

- (void)godDetailViewControllerFinishChoose:(NSString *)fid;

@end

@interface GodViewController : UIViewController

@property (nonatomic, strong) NSMutableArray      *homes;               //  存放城市数据的数组
@property (nonatomic, weak)id <GodViewControllerDelegate>delegate;

@end
