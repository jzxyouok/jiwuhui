//
//  GiftDetailView.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "GiftDetailView.h"

@interface GiftDetailView()

@property (nonatomic, weak) UIImageView *imageview;                 //  商品图片
@property (nonatomic, weak) UILabel *nameLabel;                     //  商品名称
@property (nonatomic, weak) UILabel *integralLabel;                 //  我的积分标签
@property (nonatomic, weak) UILabel *integralContentLabel;          //  我的积分内容
@property (nonatomic, weak) UILabel *convertConditionLabel;         //  商品兑换条件标签
@property (nonatomic, weak) UILabel *convertConditionContentLabel;  //  商品兑换条件内容
@property (nonatomic, weak) UILabel *convertpriceLabel;             //  兑换所需积分标签
@property (nonatomic, weak) UILabel *convertpriceContentLabel;      //  兑换所需积分内容
@property (nonatomic, weak) UILabel *remarkLabel;                   //  商品描述标签
@property (nonatomic, weak) UILabel *remarkContentLabel;            //  商品描述内容
@property (nonatomic, weak) UIButton *exchangeBtn;                  //  积分兑换按钮

@end

@implementation GiftDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //  上半部分遮罩视图
        UIView *maskview = [[UIView alloc] initWithFrame:(CGRect){0, -1000, k_w, 1000}];
        [self addSubview:maskview];
        maskview.backgroundColor = [UIColor blackColor];
        maskview.alpha = 0;
        self.maskview = maskview;
        
        //  商品图片
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:(CGRect){15, -20, 105, 105}];
        [self addSubview:imageview];
        imageview.layer.cornerRadius = 10;
        imageview.layer.masksToBounds = YES;
        self.imageview = imageview;
        
        //  商品名称
        CGFloat nameX = CGRectGetMaxX(imageview.frame) + 30;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:(CGRect){nameX, 15, 200,21}];
        [self addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        self.nameLabel = nameLabel;
        
        //  我的积分标签
        CGFloat integralX = CGRectGetMaxX(imageview.frame) + 30;
        CGFloat integralY = CGRectGetMaxY(nameLabel.frame) + 10;
        UILabel *integralLabel = [[UILabel alloc] initWithFrame:(CGRect){integralX, integralY, 70, 21}];
        [self addSubview:integralLabel];
        integralLabel.text = @"我的积分：";
        integralLabel.font = [UIFont systemFontOfSize:14];
        integralLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        self.integralLabel = integralLabel;
        
        //  我的积分内容
        UILabel *integralContentLabel = [[UILabel alloc] initWithFrame:(CGRect){integralX + 70, integralY, 50, 21}];
        [self addSubview:integralContentLabel];
        integralContentLabel.font = [UIFont systemFontOfSize:14];
        integralContentLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        integralContentLabel.numberOfLines = 0;
        self.integralContentLabel = integralContentLabel;
        
        //  分隔线1
        UIView *separator1 = [[UIView alloc] initWithFrame:(CGRect){0, 100, k_w, 1}];
        separator1.backgroundColor = kColor(235, 235, 235);
        [self addSubview:separator1];
        
        //  兑换所需积分标签
        UILabel *convertpriceLabel = [[UILabel alloc] init];
        [self addSubview:convertpriceLabel];
        convertpriceLabel.text = @"兑换所需积分：";
        convertpriceLabel.font = [UIFont systemFontOfSize:12];
        convertpriceLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.convertpriceLabel = convertpriceLabel;
        
        //  兑换所需积分内容
        UILabel *convertpriceContentLabel = [[UILabel alloc] init];
        [self addSubview:convertpriceContentLabel];
        convertpriceContentLabel.font = [UIFont systemFontOfSize:12];
        convertpriceContentLabel.textColor = kColor(255, 88, 0);
        convertpriceContentLabel.numberOfLines = 0;
        self.convertpriceContentLabel = convertpriceContentLabel;
        
        //  商品兑换条件标签
        UILabel *convertConditionLabel = [[UILabel alloc] init];
        [self addSubview:convertConditionLabel];
        convertConditionLabel.text = @"兑换条件：";
        convertConditionLabel.font = [UIFont systemFontOfSize:12];
        convertConditionLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.convertConditionLabel = convertConditionLabel;
        
        //  商品兑换条件内容
        UILabel *convertConditionContentLabel = [[UILabel alloc] init];
        [self addSubview:convertConditionContentLabel];
        convertConditionContentLabel.font = [UIFont systemFontOfSize:12];
        convertConditionContentLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        convertConditionContentLabel.numberOfLines = 0;
        self.convertConditionContentLabel = convertConditionContentLabel;
        
        //  分隔线2
        UIView *separator2 = [[UIView alloc] initWithFrame:(CGRect){0, 168, k_w, 1}];
        separator2.backgroundColor = kColor(235, 235, 235);
        [self addSubview:separator2];
        
        //  商品描述标签
        UILabel *remarkLabel = [[UILabel alloc] init];
        [self addSubview:remarkLabel];
        remarkLabel.text = @"商品描述：";
        remarkLabel.font = [UIFont systemFontOfSize:12];
        remarkLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.remarkLabel = remarkLabel;
        
        //  商品描述内容
        UILabel *remarkContentLabel = [[UILabel alloc] init];
        [self addSubview:remarkContentLabel];
        remarkContentLabel.font = [UIFont systemFontOfSize:12];
        remarkContentLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
        remarkContentLabel.numberOfLines = 0;
        self.remarkContentLabel = remarkContentLabel;
        
        
        //  积分兑换按钮
        UIButton *exchangeBtn = [[UIButton alloc] initWithFrame:(CGRect){0, frame.size.height - 50, k_w, 50}];
        exchangeBtn.backgroundColor = kColor(230, 90, 40);
        [exchangeBtn setTitle:@"积分兑换" forState:UIControlStateNormal];
        [exchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        exchangeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:exchangeBtn];
        [exchangeBtn addTarget:self action:@selector(exchangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.exchangeBtn = exchangeBtn;
    }
    return self;
}

-(void)setGift:(GiftModel *)gift{
    if (!gift) return;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:gift.path] placeholderImage:[UIImage imageNamed:@"placehoder"]];
    
    self.nameLabel.text = gift.name;
    
    CGFloat X = 15;
    
    //  设置商品兑换所需积分标签位置
    CGRect frame = [@"兑换所需积分：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.origin.x = X;
    frame.origin.y = CGRectGetMaxY(self.imageview.frame) + 30;
    self.convertpriceLabel.frame = frame;
    
    //  设置商品兑换所需积分内容和位置
    frame = [gift.convertprice boundingRectWithSize:(CGSize){k_w - CGRectGetMaxX(self.convertpriceLabel.frame),MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.origin.x = CGRectGetMaxX(self.convertpriceLabel.frame);
    frame.origin.y = self.convertpriceLabel.frame.origin.y;
    self.convertpriceContentLabel.frame = frame;
    self.convertpriceContentLabel.text = gift.convertprice;
    NNLog(@"%@",[gift.tagColor class]);
    
    //  设置商品兑换条件标签位置
    frame = [@"兑换条件：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.origin.x = X;
    frame.origin.y = CGRectGetMaxY(self.convertpriceContentLabel.frame) + 10;
    self.convertConditionLabel.frame = frame;
    
    //  设置商品兑换条件内容和位置
    frame = [gift.convertCondition boundingRectWithSize:(CGSize){k_w - CGRectGetMaxX(self.convertConditionLabel.frame),MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.origin.x = CGRectGetMaxX(self.convertConditionLabel.frame);
    frame.origin.y = self.convertConditionLabel.frame.origin.y;
    self.convertConditionContentLabel.frame = frame;
    self.convertConditionContentLabel.text = gift.convertCondition;
    
    
    //  设置商品描述标签位置
    frame = [@"商品描述：" boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.origin.x = X;
    frame.origin.y = CGRectGetMaxY(self.convertConditionContentLabel.frame) + 32;
    self.remarkLabel.frame = frame;
    
    //  设置商品描述内容和位置
    NSString *remark = [NSString stringWithFormat:@"                  %@",gift.remark];
    frame = [remark boundingRectWithSize:(CGSize){k_w - 29, MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.origin.x = X;
    frame.origin.y = self.remarkLabel.frame.origin.y;
    self.remarkContentLabel.frame = frame;
    self.remarkContentLabel.text = remark;
    
    //
    if ([gift.residueNumber isEqualToString:@"0"]) {
        [self.exchangeBtn setTitle:@"换光了" forState:UIControlStateNormal];
        self.exchangeBtn.backgroundColor = kColor(128, 128, 128);
    }
}

-(void)setIntegral:(NSString *)integral{
    if (!integral) return;
    self.integralContentLabel.text = integral;
}

- (void)exchangeBtnClick{
    if ([self.delegate respondsToSelector:@selector(GiftDetailViewExchangeBtnClick)]) {
        [self.delegate GiftDetailViewExchangeBtnClick];
    }
}

@end
