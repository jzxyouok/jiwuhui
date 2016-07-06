//
//  SongkeRuleCell.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "SongkeRuleCell.h"

@implementation SongkeRuleCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"trendCell01";
    SongkeRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[SongkeRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:(CGRect){15,10,20,20}];
        imageview.image = [UIImage imageNamed:@"icon_song_ke_rule"];
        [self addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:(CGRect){45,10,100,21}];
        label.text = @"吉屋送客规则";
        label.textColor = [UIColor blackColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        //  水平分隔线
        UIView *separator = [[UIView alloc] initWithFrame:(CGRect){15,37,k_w - 30,1}];
        separator.backgroundColor = kColor(240, 240, 240);
        [self addSubview:separator];
        
        //  垂直分隔线
        UIView *separator1 = [[UIView alloc] initWithFrame:(CGRect){20,56,1,493}];
        separator1.backgroundColor = kColor(0, 179, 90);
        [self addSubview:separator1];
        
        NSArray *array = @[@"完成身份认证和公司认证，送1个普通客户",@"普通经纪人",@"邀约一个经纪人装机注册，送1个普通客户",@"完成一次有效带看，送2个普通客户或1个认证客户",@"完成一次认购，送4个普通客户或2个认证客户",@"VIP经纪人",@"在普通经纪人送客的基础上翻倍",@"客户解析",@"普通客户：",@"系统默认推送24小时内吉屋网来电的客户",@"认证客户：",@"系统推送通过人工审核高意向吉屋网的客户",@"注意事项",@"同一台手机注册多个账号，不视为邀约装机",@"被邀约装机的手机，必须从未安装过吉屋惠App"];
        CGFloat height = 48;
        int i = 0;
        
        for (NSString *str in array) {
            CGRect frame = [str boundingRectWithSize:(CGSize){k_w - 55,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
            
            UILabel *label = [[UILabel alloc] init];
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            view.backgroundColor = kColor(0, 179, 90);
            view.layer.masksToBounds = YES;
            
            
            //  设置label的frame和颜色
            frame.origin.x = 40;
            if (i == 1 || i == 5 || i == 7 || i == 12) {
                frame.origin.y = height + 25;
                label.textColor = kColor(0, 179, 90);
                view.frame = CGRectMake(20 - 7.5, frame.origin.y, 15, 15);
            }else{
                label.textColor = [UIColor blackColor];
                frame.origin.y = height + 6;
                if (i == 2 || i == 6 || i == 8 || i == 10 || i == 13) {
                    frame.origin.y += 10;
                }
                view.frame = CGRectMake(20 - 3, frame.origin.y, 6, 6);
            }
            
            
            //  设置绿色圆圈的frame
            if (i == 0 || i == 1 || i == 5 || i == 7 || i == 12) {
                view.frame = CGRectMake(20 - 7.5, frame.origin.y, 15, 15);
            }else{
                view.frame = CGRectMake(20 - 3, frame.origin.y + 3, 6, 6);
            }
            view.layer.cornerRadius = view.frame.size.width / 2;
            
            
            
            label.frame = frame;
            [self addSubview:label];
            label.text = str;
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:13];
            height = CGRectGetMaxY(label.frame);
            i++;
        }
    }
    return self;
}

@end