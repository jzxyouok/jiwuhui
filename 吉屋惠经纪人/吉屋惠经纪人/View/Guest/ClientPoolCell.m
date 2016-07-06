//
//  ClientPoolCell.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ClientPoolCell.h"

@interface ClientPoolCell()

@property (nonatomic, weak) UILabel *approveNumberLabel;   //  可兑换的的认证客户数标签
@property (nonatomic, weak) UILabel *commonNumberLabel;    //  可兑换的的普通客户数标签
@property (nonatomic, weak) UILabel *auth_convert_cusLabel;   //  总的认证客户数标签
@property (nonatomic, weak) UILabel *gen_convert_cusLabel;    //  总的普通客户数标签

@end

@implementation ClientPoolCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"trendCell01";
    ClientPoolCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[ClientPoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:(CGRect){15,10,20,20}];
        imageview.image = [UIImage imageNamed:@"icon_chustomer_pool"];
        [self addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:(CGRect){45,10,80,21}];
        label.text = @"吉屋客户池";
        label.textColor = [UIColor blackColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        //  分隔线
        UIView *separator = [[UIView alloc] initWithFrame:(CGRect){15,37,k_w - 30,1}];
        separator.backgroundColor = kColor(240, 240, 240);
        [self addSubview:separator];
        
        //  普通客户
        UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:(CGRect){k_w / 12,k_w / 6,k_w / 2.8,k_w / 2.8}];
        imageview1.image = [UIImage imageNamed:@"icon_putong_customer"];
        [self addSubview:imageview1];
        
        CGFloat y = CGRectGetMaxY(imageview1.frame) + 10;
        UILabel *label1 = [[UILabel alloc]initWithFrame:(CGRect){k_w / 4 - 40,y,80,21}];
        label1.text = @"已被领    个";
        label1.textColor = [UIColor blackColor];
        label1.alpha = 0.5;
        label1.font = [UIFont systemFontOfSize:15];
        [self addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:(CGRect){k_w / 4 + 10,y,80,21}];
        label2.text = @"0";
        label2.textColor = [UIColor blackColor];
        label2.alpha = 1;
        label2.font = [UIFont systemFontOfSize:15];
        [self addSubview:label2];
        _gen_convert_cusLabel = label2;
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:(CGRect){k_w / 4 - 20,y - 50,80,21}];
        label3.text = @"普通客户";
        label3.textColor = [UIColor whiteColor];
        label3.font = [UIFont systemFontOfSize:15];
        [self addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:(CGRect){k_w / 4 - 5,k_w / 5 + 10,80,31}];
        label4.text = @"0";
        label4.textColor = kColor(80, 200, 150);
        label4.alpha = 1;
        label4.font = [UIFont systemFontOfSize:30];
        [self addSubview:label4];
        _commonNumberLabel = label4;
        
        //  认证客户
        UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:(CGRect){k_w - k_w / 12 - k_w / 2.8,k_w / 6,k_w / 2.8,k_w / 2.8}];
        imageview2.image = [UIImage imageNamed:@"icon_renzheng_customer"];
        [self addSubview:imageview2];
        UILabel *label5 = [[UILabel alloc]initWithFrame:(CGRect){3 * k_w / 4 - 40,y,80,21}];
        label5.text = @"已被领    个";
        label5.textColor = [UIColor blackColor];
        label5.alpha = 0.5;
        label5.font = [UIFont systemFontOfSize:15];
        [self addSubview:label5];
        
        UILabel *label6 = [[UILabel alloc]initWithFrame:(CGRect){3 * k_w / 4 + 10,y,80,21}];
        label6.text = @"0";
        label6.textColor = [UIColor blackColor];
        label6.alpha = 1;
        label6.font = [UIFont systemFontOfSize:15];
        [self addSubview:label6];
        _auth_convert_cusLabel = label6;
        
        UILabel *label7 = [[UILabel alloc]initWithFrame:(CGRect){3 * k_w / 4 - 30,y - 50,80,21}];
        label7.text = @"认证客户";
        label7.textColor = [UIColor whiteColor];
        label7.font = [UIFont systemFontOfSize:15];
        [self addSubview:label7];
        
        UILabel *label8 = [[UILabel alloc]initWithFrame:(CGRect){3 * k_w / 4 - 15,k_w / 5 + 10,80,31}];
        label8.text = @"0";
        label8.textColor = kColor(101, 187, 242);
        label8.alpha = 1;
        label8.font = [UIFont systemFontOfSize:30];
        [self addSubview:label8];
        _approveNumberLabel = label8;
        
        
        //  领取客户按钮
        CGFloat receiveBtnW = k_w / 2.5;
        CGFloat receiveBtnH = 40;
        CGFloat receiveBtnX = (k_w - receiveBtnW) / 2;
        CGFloat receiveBtnY = y + 50;
        
        UIButton *receiveBtn = [[UIButton alloc] initWithFrame:CGRectMake(receiveBtnX, receiveBtnY, receiveBtnW, receiveBtnH)];
        [self addSubview:receiveBtn];
        receiveBtn.backgroundColor = kColor(255, 136, 56);
        [receiveBtn setTitle:@"领取客户" forState:UIControlStateNormal];
        receiveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        receiveBtn.layer.cornerRadius = 3;
        receiveBtn.layer.masksToBounds = YES;
        [receiveBtn addTarget:self action:@selector(receiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        //  分隔线1
        UIView *separator1 = [[UIView alloc] initWithFrame:(CGRect){0,k_w - 23,k_w,13}];
        separator1.backgroundColor = kColor(230, 230, 230);
        [self addSubview:separator1];
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    if (!data[@"approveNumber"]) return;
    _approveNumberLabel.text = data[@"approveNumber"];
    _commonNumberLabel.text = data[@"commonNumber"];
    _auth_convert_cusLabel.text = data[@"auth_convert_cus"];
    _gen_convert_cusLabel.text = data[@"gen_convert_cus"];
}

- (void)receiveBtnClick{
    if ([self.delegate respondsToSelector:@selector(clientPoolCellReceiveBtnClick)]) {
        [self.delegate clientPoolCellReceiveBtnClick];
    }
}

@end