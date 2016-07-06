//
//  CooperateRuleCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CooperateRuleCell.h"

@implementation CooperateRuleCell

@synthesize parameters;

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell10";
    CooperateRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[CooperateRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        NSLog(@"%@",self.parameters);
    }
    
    return self;
}

-(NSMutableArray *)parameters{
    if (!parameters) {
        parameters = [NSMutableArray array];
    }
    return parameters;
}

-(void)setParameters:(NSMutableArray *)parameters1{
    if (parameters1 == nil) return;
    
    parameters = parameters1;
    NSArray *array = @[@"合作日期：",@"合作房源：",@"可售套数：",@"开盘时间：",@"结佣公司：",@"结佣周期：",@"分销奖励："];
    
    for (int i = 0; i < 15; i++) {
        UILabel *label = [[UILabel alloc] init];
        
        NSString *str;
        if (i < 7) {
            str = [array objectAtIndex:i];
            label.alpha = 0.6;
        }else{
            if (i == 7) {
                str = [NSString stringWithFormat:@"%@ - %@",[parameters objectAtIndex:i - 7],[parameters objectAtIndex:i - 6]];
            }
            else if (i == 8) {
                continue;
            }else{
                str = [parameters objectAtIndex:i - 7];
            }
        }
        
        CGRect bstimeFrame = [str boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        if (i < 7) {
            bstimeFrame.origin.x = 15;
            bstimeFrame.origin.y = 5 + i * 26.6;
        }else{
            bstimeFrame.origin.x = 85;
            if (i == 7)
                bstimeFrame.origin.y = 5 + (i - 7) * 26.6;
            else
                bstimeFrame.origin.y = 5 + (i - 8) * 26.6;
        }
        label.frame = bstimeFrame;
        label.text = str;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
    }
}

@end