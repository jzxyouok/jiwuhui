//
//  countCus_yxCusNumberCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "countCus_yxCusNumberCell.h"

@implementation countCus_yxCusNumberCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell02";
    countCus_yxCusNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[countCus_yxCusNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  合作经纪人按钮
        self.countCusBtn = [[UIButton alloc] init];
        self.countCusBtn.userInteractionEnabled = NO;
        self.countCusBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.countCusBtn setTitleColor:kColor(60, 60, 60) forState:UIControlStateNormal];
        [self.countCusBtn setImage:[UIImage imageNamed:@"housedetails_hezuo_icon"] forState:UIControlStateNormal];
        [self addSubview:self.countCusBtn];
        CGRect countCusFrame = [@"合作经纪人：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        countCusFrame.origin.x = 15;
        countCusFrame.origin.y = 14;
        countCusFrame.size.width += 30;
        self.countCusBtn.frame = countCusFrame;
        
        self.countCusBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, self.countCusBtn.frame.size.width - 14);
        self.countCusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self.countCusBtn setTitle:@"合作经纪人：" forState:UIControlStateNormal];
        [self.countCusBtn setTitleColor:kColor(45, 45, 45) forState:UIControlStateNormal];
        
        //  合作经纪人标签
        self.countCusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.countCusBtn.frame), self.countCusBtn.frame.origin.y - 3, 40, 21)];
        self.countCusLabel.font = [UIFont systemFontOfSize:13];
        self.countCusLabel.textColor = [UIColor blackColor];
        self.countCusLabel.alpha = 0.8;
        [self addSubview:self.countCusLabel];
        
        //  意向客户按钮
        self.yxCusNumberBtn = [[UIButton alloc] init];
        self.yxCusNumberBtn.userInteractionEnabled = NO;
        self.yxCusNumberBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.yxCusNumberBtn setTitleColor:kColor(60, 60, 60) forState:UIControlStateNormal];
        [self.yxCusNumberBtn setImage:[UIImage imageNamed:@"housedetails_yixinag_icon"] forState:UIControlStateNormal];
        [self addSubview:self.yxCusNumberBtn];
        CGRect yxCusNumberFrame = [@"意向客户：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        yxCusNumberFrame.origin.x = k_w / 2;
        yxCusNumberFrame.origin.y = 14;
        yxCusNumberFrame.size.width += 30;
        self.yxCusNumberBtn.frame = yxCusNumberFrame;
        
        self.yxCusNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, self.yxCusNumberBtn.frame.size.width - 14);
        self.yxCusNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self.yxCusNumberBtn setTitle:@"意向客户：" forState:UIControlStateNormal];
        [self.yxCusNumberBtn setTitleColor:kColor(45, 45, 45) forState:UIControlStateNormal];
        
        //  意向客户标签
        self.yxCusNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.yxCusNumberBtn.frame), self.yxCusNumberBtn.frame.origin.y - 3, 40, 21)];
        self.yxCusNumberLabel.font = [UIFont systemFontOfSize:13];
        self.yxCusNumberLabel.textColor = [UIColor blackColor];
        self.yxCusNumberLabel.numberOfLines = 0;
        self.yxCusNumberLabel.alpha = 0.8;
        [self addSubview:self.yxCusNumberLabel];
    }
    
    return self;
}

-(void)setCountCus:(NSString *)countCus{
    if (countCus == nil || [countCus isEqualToString:@"(null)"]) return;
    self.countCusLabel.text = countCus;
}

-(void)setYxCusNumber:(NSString *)yxCusNumber{
    if (yxCusNumber == nil || [yxCusNumber isEqualToString:@"(null)"]) return;
    self.yxCusNumberLabel.text = yxCusNumber;
}

@end
