//
//  ScenePreferentialCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ScenePreferentialCell.h"

@implementation ScenePreferentialCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell21";
    ScenePreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[ScenePreferentialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  现场优惠按钮
        UIButton *xcyhBtn = [[UIButton alloc] init];
        xcyhBtn.userInteractionEnabled = NO;
        xcyhBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [xcyhBtn setImage:[UIImage imageNamed:@"icon_youhui"] forState:UIControlStateNormal];
        [self addSubview:xcyhBtn];
        CGRect fxsyjFrame = [@"现场优惠：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        fxsyjFrame.origin.x = 15;
        fxsyjFrame.origin.y = 14;
        fxsyjFrame.size.width += 30;
        xcyhBtn.frame = fxsyjFrame;
        
        xcyhBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, xcyhBtn.frame.size.width - 18);
        xcyhBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [xcyhBtn setTitle:@"现场优惠：" forState:UIControlStateNormal];
        [xcyhBtn setTitleColor:kColor(30, 30, 30) forState:UIControlStateNormal];
        
        //  现场优惠标签
        self.xcyhLabel = [[UILabel alloc] initWithFrame:(CGRect){45,40,k_w,21}];
        self.xcyhLabel.font = [UIFont systemFontOfSize:13];
        self.xcyhLabel.alpha = 0.5;
        [self.contentView addSubview:self.xcyhLabel];
        
    }
    
    return self;
}

-(void)setXcyh:(NSString *)xcyh{
    if (xcyh == nil) return;
    self.xcyhLabel.text = xcyh;
}

@end
