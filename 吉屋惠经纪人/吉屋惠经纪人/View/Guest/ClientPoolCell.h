//
//  ClientPoolCell.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClientPoolCellDelegate <NSObject>

- (void)clientPoolCellReceiveBtnClick;

@end

@interface ClientPoolCell : UITableViewCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, weak) id <ClientPoolCellDelegate> delegate;


@end
