//
//  CommissionRewardCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CommissionRewardCell.h"

@implementation CommissionRewardCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell10";
    CommissionRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[CommissionRewardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  佣金奖励标签
        UILabel *commissionRewardLabel = [[UILabel alloc] initWithFrame:(CGRect){15,10,100,21}];
        commissionRewardLabel.text = @"佣金奖励";
        commissionRewardLabel.font = [UIFont systemFontOfSize:13];
        commissionRewardLabel.alpha = 0.5;
        [self.contentView addSubview:commissionRewardLabel];
        
        //  详情标签
        UILabel *houseDetailLabel = [[UILabel alloc] initWithFrame:(CGRect){k_w - 50,8,60,21}];
        houseDetailLabel.text = @"详情";
        houseDetailLabel.font = [UIFont systemFontOfSize:12];
        houseDetailLabel.alpha = 0.5;
        [self addSubview:houseDetailLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

@end
