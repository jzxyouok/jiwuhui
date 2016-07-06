//
//  Price_AddressCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "Price_AddressCell.h"

@implementation Price_AddressCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell01";
    Price_AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[Price_AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  均价按钮
        self.averagePriceBtn = [[UIButton alloc] init];
        self.averagePriceBtn.userInteractionEnabled = NO;
        self.averagePriceBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.averagePriceBtn setTitleColor:kColor(60, 60, 60) forState:UIControlStateNormal];
        [self.averagePriceBtn setImage:[UIImage imageNamed:@"housedetails_price_icon"] forState:UIControlStateNormal];
        [self addSubview:self.averagePriceBtn];
        CGRect averagePriceFrame = [@"均价：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        averagePriceFrame.origin.x = 15;
        averagePriceFrame.origin.y = 14;
        averagePriceFrame.size.width += 30;
        self.averagePriceBtn.frame = averagePriceFrame;
        
        self.averagePriceBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, self.averagePriceBtn.frame.size.width - 14);
        self.averagePriceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self.averagePriceBtn setTitle:@"均价：" forState:UIControlStateNormal];
        [self.averagePriceBtn setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
        
        //  均价标签
        self.averagePriceLabel = [[UILabel alloc] init];
        self.averagePriceLabel.font = [UIFont systemFontOfSize:14];
        self.averagePriceLabel.textColor = [UIColor blackColor];
        self.averagePriceLabel.textColor = kColor(255, 93, 10);
        [self addSubview:self.averagePriceLabel];
        
        //  地址按钮
        self.saleAddressBtn = [[UIButton alloc] init];
        self.saleAddressBtn.userInteractionEnabled = NO;
        self.saleAddressBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.saleAddressBtn setTitleColor:kColor(60, 60, 60) forState:UIControlStateNormal];
        [self.saleAddressBtn setImage:[UIImage imageNamed:@"housedetails_location_pin"] forState:UIControlStateNormal];
        [self addSubview:self.saleAddressBtn];
        CGRect saleAddressFrame = [@"地址：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        saleAddressFrame.origin.x = 15;
        saleAddressFrame.origin.y = 40;
        saleAddressFrame.size.width += 30;
        self.saleAddressBtn.frame = saleAddressFrame;
        
        self.saleAddressBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, self.saleAddressBtn.frame.size.width - 12);
        self.saleAddressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self.saleAddressBtn setTitle:@"地址：" forState:UIControlStateNormal];
        [self.saleAddressBtn setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
        
        //  地址标签
        self.saleAddressLabel = [[UILabel alloc] init];
        self.saleAddressLabel.font = [UIFont systemFontOfSize:14];
        self.saleAddressLabel.textColor = [UIColor blackColor];
        self.saleAddressLabel.numberOfLines = 0;
        self.saleAddressLabel.alpha = 0.8;
        [self addSubview:self.saleAddressLabel];
    }
    
    return self;
}

-(void)setAveragePrice:(NSString *)averagePrice{
    if (averagePrice == nil) return;
    
    CGRect averagePriceLabelFrame = [averagePrice boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    averagePriceLabelFrame.origin.x = CGRectGetMaxX(self.averagePriceBtn.frame) ;
    averagePriceLabelFrame.origin.y = self.averagePriceBtn.frame.origin.y;
    
    self.averagePriceLabel.frame = averagePriceLabelFrame;
    self.averagePriceLabel.text = averagePrice;
}

-(void)setSaleAddress:(NSString *)saleAddress{
    if (saleAddress == nil) return;
    
    CGRect saleAddressLabelFrame = [saleAddress boundingRectWithSize:(CGSize){k_w - CGRectGetMaxX(self.saleAddressBtn.frame) - 20,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    saleAddressLabelFrame.origin.x = CGRectGetMaxX(self.saleAddressBtn.frame) ;
    saleAddressLabelFrame.origin.y = self.saleAddressBtn.frame.origin.y;
    
    self.saleAddressLabel.frame = saleAddressLabelFrame;
    self.saleAddressLabel.text = saleAddress;
}

@end
