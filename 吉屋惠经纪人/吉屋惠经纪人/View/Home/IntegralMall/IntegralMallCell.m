//
//  IntegralMallCell.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "IntegralMallCell.h"

@interface IntegralMallCell()

@property (nonatomic, weak) UIImageView *imageview;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *convertConditionLabel;
@property (nonatomic, weak) UILabel *convertConditionContentLabel;
@property (nonatomic, weak) UILabel *residueNumberLabel;
@property (nonatomic, weak) UILabel *residueNumberContentLabel;
@property (nonatomic, weak) UILabel *convertpriceLabel;
@property (nonatomic, weak) UIButton *convertBtn;

@end

@implementation IntegralMallCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"trendCell";
    IntegralMallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[IntegralMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:(CGRect){15, 12, 105, 123}];
        imageview.image = [UIImage imageNamed:@"bag_icon"];
        [self addSubview:imageview];
        self.imageview = imageview;
        
        //  商品名称
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        self.nameLabel = nameLabel;
        
        //  商品兑换条件标签
        UILabel *convertConditionLabel = [[UILabel alloc] init];
        [self addSubview:convertConditionLabel];
        convertConditionLabel.text = @"兑换条件：";
        convertConditionLabel.font = [UIFont systemFontOfSize:13];
        convertConditionLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.convertConditionLabel = convertConditionLabel;
        
        //  商品兑换条件内容
        UILabel *convertConditionContentLabel = [[UILabel alloc] init];
        [self addSubview:convertConditionContentLabel];
        convertConditionContentLabel.font = [UIFont systemFontOfSize:13];
        convertConditionContentLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        convertConditionContentLabel.numberOfLines = 0;
        self.convertConditionContentLabel = convertConditionContentLabel;
        
        //  商品兑换剩余标签
        UILabel *residueNumberLabel = [[UILabel alloc] init];
        [self addSubview:residueNumberLabel];
        residueNumberLabel.text = @"兑换剩余：";
        residueNumberLabel.font = [UIFont systemFontOfSize:13];
        residueNumberLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.residueNumberLabel = residueNumberLabel;
        
        //  商品兑换剩余内容
        UILabel *residueNumberContentLabel = [[UILabel alloc] init];
        [self addSubview:residueNumberContentLabel];
        residueNumberContentLabel.font = [UIFont systemFontOfSize:13];
        residueNumberContentLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        residueNumberContentLabel.numberOfLines = 0;
        self.residueNumberContentLabel = residueNumberContentLabel;
        
        //  商品所需兑换积分
        UILabel *convertpriceLabel = [[UILabel alloc] init];
        [self addSubview:convertpriceLabel];
        convertpriceLabel.font = [UIFont systemFontOfSize:15];
        convertpriceLabel.textColor = kColor(255, 88, 0);
        self.convertpriceLabel = convertpriceLabel;
        
        //  我要兑换按钮
        CGFloat convertBtnW = 90;
        CGFloat convertBtnH = 30;
        CGFloat convertBtnX = k_w - 104;
        CGFloat convertBtnY = 105;
        
        UIButton *convertBtn = [[UIButton alloc] initWithFrame:CGRectMake(convertBtnX, convertBtnY, convertBtnW, convertBtnH)];
        [self addSubview:convertBtn];
        convertBtn.backgroundColor = kColor(255, 136, 56);
        [convertBtn setTitle:@"我要兑换" forState:UIControlStateNormal];
        convertBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        convertBtn.layer.cornerRadius = 3;
        convertBtn.layer.masksToBounds = YES;
        self.convertBtn = convertBtn;
    }
    return self;
}

-(void)setGift:(GiftModel *)gift{
    if (!gift) return;
    //  设置图片
    [_imageview sd_setImageWithURL:[NSURL URLWithString:gift.path] placeholderImage:[UIImage imageNamed:@"placehoder"]];
    
    //  设置商品名称
    CGFloat X = CGRectGetMaxX(self.imageview.frame) + 10;
    CGRect frame = [gift.name boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    frame.origin.x = X;
    frame.origin.y = 15;
    self.nameLabel.text = gift.name;
    self.nameLabel.frame = frame;
    
    //  设置商品兑换条件标签位置
    frame = [@"兑换条件：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    frame.origin.x = X;
    frame.origin.y = CGRectGetMaxY(self.nameLabel.frame) + 5;
    self.convertConditionLabel.frame = frame;
    
    //  设置商品兑换条件内容和位置
    frame = [gift.convertCondition boundingRectWithSize:(CGSize){k_w - CGRectGetMaxX(self.convertConditionLabel.frame),MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    frame.origin.x = CGRectGetMaxX(self.convertConditionLabel.frame);
    frame.origin.y = CGRectGetMaxY(self.nameLabel.frame) + 5;
    self.convertConditionContentLabel.frame = frame;
    self.convertConditionContentLabel.text = gift.convertCondition;
    
    //  设置商品兑换剩余标签位置
    frame = [@"兑换剩余：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    frame.origin.x = X;
    frame.origin.y = CGRectGetMaxY(self.convertConditionContentLabel.frame) + 5;
    self.residueNumberLabel.frame = frame;
    
    //  设置商品兑换剩余内容和位置
    NNLog(@"%@",[gift.residueNumber class]);
    frame = [gift.residueNumber boundingRectWithSize:(CGSize){100,MAXFLOAT} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    frame.origin.x = CGRectGetMaxX(self.residueNumberLabel.frame);
    frame.origin.y = CGRectGetMaxY(self.convertConditionContentLabel.frame) + 5;
    self.residueNumberContentLabel.frame = frame;
    self.residueNumberContentLabel.text = [NSString stringWithFormat:@"%@份",gift.residueNumber];
    if ([gift.residueNumber isEqualToString:@"0"]) {
        [self.convertBtn setTitle:@"换光了" forState:UIControlStateNormal];
        self.convertBtn.backgroundColor = kColor(204, 204, 204);
    }
    
    //  设置商品所需兑换积分内容和位置
    frame = [[NSString stringWithFormat:@"%@积分",gift.convertprice] boundingRectWithSize:(CGSize){150,MAXFLOAT} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    frame.origin.x = X;
    frame.origin.y = CGRectGetMaxY(self.residueNumberContentLabel.frame) + 10;
    self.convertpriceLabel.frame = frame;
    self.convertpriceLabel.text = [NSString stringWithFormat:@"%@积分",gift.convertprice];
}

@end
