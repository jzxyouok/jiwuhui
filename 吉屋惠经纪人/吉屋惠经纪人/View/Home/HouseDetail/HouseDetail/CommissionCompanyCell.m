//
//  CommissionCompanyCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CommissionCompanyCell.h"

@implementation CommissionCompanyCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell12";
    CommissionCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[CommissionCompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  结佣公司标签
        self.jygsLabel = [[UILabel alloc] initWithFrame:(CGRect){15,10,k_w,21}];
        self.jygsLabel.font = [UIFont systemFontOfSize:15];
        self.jygsLabel.textColor = [UIColor blackColor];
        self.jygsLabel.alpha = 0.9;
        [self addSubview:self.jygsLabel];
    }
    
    return self;
}

-(void)setJygs:(NSString *)jygs{
    if (jygs == nil) return;
    self.jygsLabel.text = [NSString stringWithFormat:@"结佣公司：%@",jygs];
}

@end
