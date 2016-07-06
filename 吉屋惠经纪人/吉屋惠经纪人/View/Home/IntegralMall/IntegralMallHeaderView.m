//
//  IntegralMallHeaderView.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "IntegralMallHeaderView.h"

@interface IntegralMallHeaderView()

@property (nonatomic, weak) UILabel *integralLabel;                 //  我的积分标签
@property (nonatomic, weak) UILabel *integralContentLabel;          //  我的积分内容

@end

@implementation IntegralMallHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){0, 0, k_w, 115}];
        [button setImage:[UIImage imageNamed:@"shangcheng_bg"] forState:UIControlStateNormal];
        [self addSubview:button];
        
        
        //  我的积分标签
        UILabel *integralLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 15, k_w, 21}];
        [self addSubview:integralLabel];
        integralLabel.font = [UIFont systemFontOfSize:16];
        integralLabel.textColor = [UIColor whiteColor];
        integralLabel.textAlignment = NSTextAlignmentCenter;
        self.integralLabel = integralLabel;
        
        //  我的积分内容
        UILabel *integralContentLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 34, k_w, 21}];
        [self addSubview:integralContentLabel];
        integralContentLabel.font = [UIFont systemFontOfSize:12];
        integralContentLabel.textColor = [UIColor whiteColor];
        integralContentLabel.text = @"点击查看积分详情>>";
        integralContentLabel.textAlignment = NSTextAlignmentCenter;
        
        //  签到按钮
        UIButton *signBtn = [[UIButton alloc] initWithFrame:(CGRect){(k_w - 143) / 2, 60, 143, 40}];
        [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        signBtn.layer.cornerRadius = 3;
        signBtn.layer.masksToBounds = YES;
        signBtn.layer.borderWidth = 1;
        signBtn.layer.borderColor = kColor(255, 100, 0).CGColor;
        [self addSubview:signBtn];
        [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  获取当前日期，判断今天是否已经签到
        NSDate * date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString * dateStr = [dateFormatter stringFromDate:date];
        
        if ([[UserInfo sharedUserInfo].lastSignDate isEqualToString:dateStr] && [[UserInfo sharedUserInfo].lastSignUser isEqualToString:[UserInfo sharedUserInfo].userName]){
            [signBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
            signBtn.backgroundColor = kColor(255, 146, 76);
        }else{
            [signBtn setTitle:@"今日签到+5" forState:UIControlStateNormal];
            signBtn.backgroundColor = kColor(255, 100, 0);
        }
        
        
        //  积分规则、团队赚积分、查看订单按钮
        NSArray *array = @[@"积分规则",@"团队赚积分",@"查看订单"];
        NSArray *imageNmes = @[@"jifenrule",@"tuandui",@"order"];
        
        for (int i = 0; i < 3; i++) {
            CGFloat ruleBtnW = k_w / 3;
            CGFloat ruleBtnH = 57;
            UIButton *ruleBtn = [[UIButton alloc] initWithFrame:(CGRect){i * ruleBtnW, CGRectGetMaxY(button.frame), ruleBtnW, ruleBtnH}];
            [ruleBtn setImage:[UIImage imageNamed:[imageNmes objectAtIndex:i]] forState:UIControlStateNormal];
            ruleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [ruleBtn setTitleColor:kColor_alpha(0, 0, 0, 0.5) forState:UIControlStateNormal];
            [self addSubview:ruleBtn];
            ruleBtn.imageEdgeInsets = UIEdgeInsetsMake(8, ruleBtnW / 2.5, 28, ruleBtnW / 2.5);
            
            NSString *str = [array objectAtIndex:i];
            CGRect frame = [str boundingRectWithSize:(CGSize){MAXFLOAT,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            frame.origin.x = i * k_w / 3 + (ruleBtnW - frame.size.width) / 2;
            frame.origin.y = CGRectGetMaxY(button.frame) + 35;
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            [self addSubview:label];
            label.text = str;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = kColor_alpha(0, 0, 0, 0.5);
            
            UIView *separator = [[UIView alloc] initWithFrame:(CGRect){ruleBtnW * i,CGRectGetMaxY(button.frame) + 15, 1,30}];
            separator.backgroundColor = kColor(210, 210, 210);
            [self addSubview:separator];
        }
        
    }
    return self;
}

/**
 *  设置积分数据
 *
 *  @param integral 积分
 */
-(void)setIntegral:(NSString *)integral{
    if (!integral) return;
    self.integralLabel.text = [NSString stringWithFormat:@"积分：%@",integral];
}

/**
 *  签到按钮点击事件
 *
 *  @param button
 */
- (void)signBtnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(IntegralMallHeaderViewSignBtnClick:)]) {
        [self.delegate IntegralMallHeaderViewSignBtnClick:button];
    }
}

@end
