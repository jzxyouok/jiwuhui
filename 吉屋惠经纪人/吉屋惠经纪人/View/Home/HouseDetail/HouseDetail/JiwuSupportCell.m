//
//  JiwuSupportCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "JiwuSupportCell.h"

@implementation JiwuSupportCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell70";
    JiwuSupportCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[JiwuSupportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  吉屋支持按钮
        UIButton *mbkhBtn = [[UIButton alloc] init];
        mbkhBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        mbkhBtn.userInteractionEnabled = NO;
        
        [mbkhBtn setImage:[UIImage imageNamed:@"icon_surpport"] forState:UIControlStateNormal];
        [self addSubview:mbkhBtn];
        CGRect fxsyjFrame = [@"吉屋支持" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        
        fxsyjFrame.origin.x = 15;
        fxsyjFrame.origin.y = 10;
        fxsyjFrame.size.width += 30;
        mbkhBtn.frame = fxsyjFrame;
        
        mbkhBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, mbkhBtn.frame.size.width - 18);
        mbkhBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [mbkhBtn setTitle:@"吉屋支持" forState:UIControlStateNormal];
        [mbkhBtn setTitleColor:kColor(130, 130, 130) forState:UIControlStateNormal];
        
    }
    
    return self;
}

@end