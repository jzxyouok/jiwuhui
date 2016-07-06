//
//  PreferentialCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "PreferentialCell.h"

@implementation PreferentialCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell20";
    PreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[PreferentialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  优惠活动标签
        UILabel *commissionRewardLabel = [[UILabel alloc] initWithFrame:(CGRect){15,10,100,21}];
        commissionRewardLabel.text = @"优惠活动";
        commissionRewardLabel.font = [UIFont systemFontOfSize:13];
        commissionRewardLabel.alpha = 0.5;
        [self.contentView addSubview:commissionRewardLabel];
        
    }
    
    return self;
}

@end
