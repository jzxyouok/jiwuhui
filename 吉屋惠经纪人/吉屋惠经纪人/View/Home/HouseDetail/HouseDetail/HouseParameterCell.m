//
//  HouseParameterTableViewCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HouseParameterCell.h"

@implementation HouseParameterCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell00";
    HouseParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[HouseParameterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  bname
        self.bnameLabel = [[UILabel alloc] init];
        self.bnameLabel.font = [UIFont systemFontOfSize:17];
        self.bnameLabel.textColor = kColor(60, 60, 60);
        [self.contentView addSubview:self.bnameLabel];
        
        
        //  销售状态salestatusText
        self.colorView = [[UIView alloc] initWithFrame:(CGRect){0,0,0,0}];
        self.colorView.layer.cornerRadius = 2;
        self.colorView.layer.masksToBounds = YES;
        self.colorView.backgroundColor = kColor(255, 73, 0);
        
        self.salestatusTextLabel = [[UILabel alloc] init];
        self.salestatusTextLabel.font = [UIFont systemFontOfSize:12];
        self.salestatusTextLabel.textColor = [UIColor whiteColor];
        
        //  楼盘参数
        UILabel *houseDetailLabel = [[UILabel alloc] initWithFrame:(CGRect){k_w - 80,12,60,21}];
        houseDetailLabel.text = @"楼盘参数";
        houseDetailLabel.font = [UIFont systemFontOfSize:12];
        houseDetailLabel.alpha = 0.6;
        [self addSubview:houseDetailLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)setBname:(NSString *)bname{
    if (bname == nil) return;
    CGRect bnameFrame = [bname boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    bnameFrame.origin.x = 15;
    bnameFrame.origin.y = 14;
    self.bnameLabel.frame = bnameFrame;
    self.bnameLabel.text = bname;
}

//  设置在售状态的位置大小和内容
-(void)setSalestatusText:(NSString *)salestatusText{
    if (salestatusText == nil) return ;
        
    CGRect salestatusTextFrame = [salestatusText boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    salestatusTextFrame.origin.x = 4;
    salestatusTextFrame.origin.y = 2;
    self.salestatusTextLabel.frame = salestatusTextFrame;
    
    salestatusTextFrame.origin.x = CGRectGetMaxX(self.bnameLabel.frame) + 10;
    salestatusTextFrame.origin.y = 14;
    salestatusTextFrame.size.width += 8;
    salestatusTextFrame.size.height += 4;
    self.colorView.frame = salestatusTextFrame;
    
    self.salestatusTextLabel.text = salestatusText;
    [self.colorView addSubview:self.salestatusTextLabel];
    [self.contentView addSubview:self.colorView];
}

@end
