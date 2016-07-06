//
//  CommissionRuleCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CommissionRuleCell.h"

@implementation CommissionRuleCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell11";
    CommissionRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[CommissionRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  佣金按钮
        self.fxsyjBtn = [[UIButton alloc] init];
        self.fxsyjBtn.userInteractionEnabled = NO;
        self.fxsyjBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.fxsyjBtn setImage:[UIImage imageNamed:@"icon_money"] forState:UIControlStateNormal];
        [self addSubview:self.fxsyjBtn];
        CGRect fxsyjFrame = [@"佣金：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        fxsyjFrame.origin.x = 15;
        fxsyjFrame.origin.y = 14;
        fxsyjFrame.size.width += 30;
        self.fxsyjBtn.frame = fxsyjFrame;
        
        self.fxsyjBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, self.fxsyjBtn.frame.size.width - 18);
        self.fxsyjBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self.fxsyjBtn setTitle:@"佣金：" forState:UIControlStateNormal];
        [self.fxsyjBtn setTitleColor:kColor(30, 30, 30) forState:UIControlStateNormal];
        
        //  佣金标签
        self.fxsyjLabel = [[UILabel alloc] init];
        self.fxsyjLabel.font = [UIFont systemFontOfSize:14];
        self.fxsyjLabel.textColor = [UIColor blackColor];
        self.fxsyjLabel.textColor = kColor(255, 93, 10);
        [self addSubview:self.fxsyjLabel];
        
        //  规则按钮
        self.yjgzBtn = [[UIButton alloc] init];
        self.yjgzBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.yjgzBtn setTitleColor:kColor(60, 60, 60) forState:UIControlStateNormal];
        [self addSubview:self.yjgzBtn];
        CGRect yjgzFrame = [@"规则：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        yjgzFrame.origin.x = 44;
        yjgzFrame.origin.y = 40;
        self.yjgzBtn.frame = yjgzFrame;
        
        [self.yjgzBtn setTitle:@"规则：" forState:UIControlStateNormal];
        [self.yjgzBtn setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
        
        //  规则标签
        self.yjgzLabel = [[UILabel alloc] init];
        self.yjgzLabel.font = [UIFont systemFontOfSize:14];
        self.yjgzLabel.textColor = [UIColor blackColor];
        self.yjgzLabel.numberOfLines = 0;
        self.yjgzLabel.alpha = 0.8;
        [self addSubview:self.yjgzLabel];
    }
    
    return self;
}

-(void)setFxsyj:(NSString *)fxsyj{
    if (fxsyj == nil) return;
    
    CGRect fxsyjLabelFrame = [fxsyj boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    fxsyjLabelFrame.origin.x = CGRectGetMaxX(self.fxsyjBtn.frame) - 1;
    fxsyjLabelFrame.origin.y = self.fxsyjBtn.frame.origin.y - 2;
    
    self.fxsyjLabel.frame = fxsyjLabelFrame;
    self.fxsyjLabel.text = fxsyj;
}

-(void)setYjgz:(NSString *)yjgz{
    if (yjgz == nil) return;
    
    NSString *yjgzStr = [NSString stringWithFormat:@"           %@",yjgz];
    CGRect yjgzLabelFrame = [yjgzStr boundingRectWithSize:(CGSize){k_w - 45 - 20,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    yjgzLabelFrame.origin.x = 44;
    yjgzLabelFrame.origin.y = self.yjgzBtn.frame.origin.y;
    
    self.yjgzLabel.frame = yjgzLabelFrame;
    self.yjgzLabel.text = yjgzStr;
}

@end
