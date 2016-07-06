//
//  HouseSellingPointCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HouseSellingPointCell.h"

@implementation HouseSellingPointCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell40";
    HouseSellingPointCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[HouseSellingPointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  楼盘卖点按钮
        UIButton *lpmdBtn = [[UIButton alloc] init];
        lpmdBtn.userInteractionEnabled = NO;
        lpmdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [lpmdBtn setImage:[UIImage imageNamed:@"icon_salepoint"] forState:UIControlStateNormal];
        [self addSubview:lpmdBtn];
        CGRect fxsyjFrame = [@"楼盘卖点" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        fxsyjFrame.origin.x = 15;
        fxsyjFrame.origin.y = 10;
        fxsyjFrame.size.width += 30;
        lpmdBtn.frame = fxsyjFrame;
        
        lpmdBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, lpmdBtn.frame.size.width - 18);
        lpmdBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [lpmdBtn setTitle:@"楼盘卖点" forState:UIControlStateNormal];
        [lpmdBtn setTitleColor:kColor(130, 130, 130) forState:UIControlStateNormal];
        
    }
    
    return self;
}

@end
