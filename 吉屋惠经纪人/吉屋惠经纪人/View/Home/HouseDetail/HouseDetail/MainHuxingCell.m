//
//  MainHuxingCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "MainHuxingCell.h"

@implementation MainHuxingCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell30";
    MainHuxingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[MainHuxingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  主力户型标签
        UILabel *commissionRewardLabel = [[UILabel alloc] initWithFrame:(CGRect){15,10,100,21}];
        commissionRewardLabel.text = @"主力户型";
        commissionRewardLabel.font = [UIFont systemFontOfSize:13];
        commissionRewardLabel.alpha = 0.5;
        [self.contentView addSubview:commissionRewardLabel];
        
        //  全部户型标签
        UILabel *houseDetailLabel = [[UILabel alloc] initWithFrame:(CGRect){k_w - 130,8,150,21}];
        houseDetailLabel.text = @"全部户型（共    个）";
        houseDetailLabel.font = [UIFont systemFontOfSize:12];
        houseDetailLabel.alpha = 0.5;
        [self addSubview:houseDetailLabel];
        
        //  户型个数标签
        self.huxingLabel = [[UILabel alloc] initWithFrame:(CGRect){k_w - 61,8,20,21}];
        self.huxingLabel.font = [UIFont systemFontOfSize:12];
        self.huxingLabel.textColor = [UIColor blackColor];
        self.huxingLabel.textColor = kColor(255, 93, 10);
        self.huxingLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.huxingLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

-(void)setHuxing:(NSString *)huxing{
    if (huxing == nil) return;
    self.huxingLabel.text = huxing;
}

@end
