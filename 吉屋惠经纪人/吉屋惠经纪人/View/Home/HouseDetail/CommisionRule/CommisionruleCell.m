//
//  CommisionruleCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "CommisionruleCell.h"

@implementation CommisionruleCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell01";
    CommisionruleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[CommisionruleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  规则标签
        self.yongjinuize = [[UILabel alloc] initWithFrame:(CGRect){15,15,80,21}];
        self.yongjinuize.text = @"佣金规则：";
        self.yongjinuize.font = [UIFont systemFontOfSize:14];
        self.yongjinuize.textColor = [UIColor blackColor];
        self.yongjinuize.alpha = 0.6;
        
        //  规则内容
        self.yjgzLabel = [[UITextView alloc] init];
        self.yjgzLabel.font = [UIFont systemFontOfSize:14];
        self.yjgzLabel.textColor = [UIColor blackColor];
        self.yjgzLabel.alpha = 0.8;
        self.yjgzLabel.userInteractionEnabled = NO;
        [self addSubview:self.yjgzLabel];
        [self addSubview:self.yongjinuize];
    }
    
    return self;
}

-(void)setYjgz:(NSString *)yjgz{
    if (yjgz == nil) return;
    
    self.yjgzLabel.text = [NSString stringWithFormat:@"                   %@",yjgz];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle};
    self.yjgzLabel.attributedText = [[NSAttributedString alloc] initWithString:self.yjgzLabel.text attributes:attributes];
    
    CGRect yjgzLabelFrame = [[NSString stringWithFormat:@"                   %@",yjgz] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    yjgzLabelFrame.origin.x = 10;
    yjgzLabelFrame.origin.y = 10;
    yjgzLabelFrame.size.height += 10;
    yjgzLabelFrame.size.width += 10;
//    NSLog(@"%f",yjgzLabelFrame.size.height);
    self.yjgzLabel.frame = yjgzLabelFrame;
}

@end