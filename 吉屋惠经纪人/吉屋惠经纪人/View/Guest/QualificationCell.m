//
//  QualificationCell.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/27.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "QualificationCell.h"

@interface QualificationCell()

@property (nonatomic, weak) UILabel *lingquLabel;           //  是否可领取标签
@property (nonatomic, weak) UILabel *auth_total_cusLabel;   //  总的认证客户数标签
@property (nonatomic, weak) UILabel *gen_total_cusLabel;    //  总的普通客户数标签

@end

@implementation QualificationCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"trendCell00";
    QualificationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[QualificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:(CGRect){15,15,40,40}];
        imageview.image = [UIImage imageNamed:@"icon_get_qualify"];
        [self addSubview:imageview];
        
        //  我的资格标签
        UILabel *label = [[UILabel alloc]initWithFrame:(CGRect){65,15,80,21}];
        label.text = @"我的资格";
        label.textColor = [UIColor blackColor];
        label.alpha = 0.9;
        label.font = [UIFont systemFontOfSize:16];
        [self addSubview:label];
        
        //  是否可领取标签
        UILabel *label1 = [[UILabel alloc]initWithFrame:(CGRect){140,15,80,21}];
        label1.text = @"不可领取";
        label1.textColor = [UIColor blackColor];
        label1.alpha = 0.5;
        label1.font = [UIFont systemFontOfSize:13];
        [self addSubview:label1];
        _lingquLabel = label1;
        
        //  认证客户个数默认0个
        UILabel *label2 = [[UILabel alloc]initWithFrame:(CGRect){65,42,10,21}];
        label2.text = @"0";
        label2.textColor = kColor(255, 88, 0);
        label2.alpha = 1;
        label2.font = [UIFont systemFontOfSize:15];
        [self addSubview:label2];
        _gen_total_cusLabel = label2;
        
        //  个认证客户或标签
        UILabel *label3 = [[UILabel alloc]initWithFrame:(CGRect){75,42,100,21}];
        label3.text = @"个认证客户或";
        label3.textColor = [UIColor blackColor];
        label3.alpha = 0.9;
        label3.font = [UIFont systemFontOfSize:15];
        [self addSubview:label3];
        
        //  普通客户个数默认0个
        UILabel *label4 = [[UILabel alloc]initWithFrame:(CGRect){165,42,10,21}];
        label4.text = @"0";
        label4.textColor = kColor(255, 88, 0);
        label4.alpha = 1;
        label4.font = [UIFont systemFontOfSize:15];
        [self addSubview:label4];
        _auth_total_cusLabel = label4;
        
        //  个普通客户或标签
        UILabel *label5 = [[UILabel alloc]initWithFrame:(CGRect){175,42,100,21}];
        label5.text = @"个普通客户";
        label5.textColor = [UIColor blackColor];
        label5.alpha = 0.9;
        label5.font = [UIFont systemFontOfSize:15];
        [self addSubview:label5];
        
        //  分隔线
        UIView *separator = [[UIView alloc] initWithFrame:(CGRect){0,70,k_w,13}];
        separator.backgroundColor = kColor(230, 230, 230);
        [self addSubview:separator];
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    if (!data[@"approveNumber"]) return;
    
    NSString *approveNumber = data[@"approveNumber"];
    NSString *commonNumber = data[@"commonNumber"];
    
    //  如果可兑换的普通客户数和可兑换的认证客户数都为零
    if ([approveNumber isEqualToString:@"0"] && [commonNumber isEqualToString:@"0"]) {
        _lingquLabel.text = @"不可领取";
    }else{
        _lingquLabel.text = @"可领取";
    }
    _auth_total_cusLabel.text = data[@"auth_total_cus"];
    _gen_total_cusLabel.text = data[@"gen_total_cus"];
}

@end
