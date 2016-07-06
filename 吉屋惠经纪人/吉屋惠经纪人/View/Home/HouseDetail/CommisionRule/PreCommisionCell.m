//
//  PreCommisionCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "PreCommisionCell.h"

@implementation PreCommisionCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell00";
    PreCommisionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[PreCommisionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  前佣标签
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){15,10,50,21}];
        label.text = @"前佣：";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.alpha = 0.6;
        [self addSubview:label];
        
        //  佣金标签
        self.fxsyjLabel = [[UILabel alloc] initWithFrame:(CGRect){55,10,k_w,21}];
        self.fxsyjLabel.font = [UIFont systemFontOfSize:13];
        self.fxsyjLabel.textColor = kColor(255, 93, 10);
        [self addSubview:self.fxsyjLabel];
        
        
        
    }
    
    return self;
}

-(void)setFxsyj:(NSString *)fxsyj{
    if (fxsyj == nil) return;
    self.fxsyjLabel.text = fxsyj;
}

@end