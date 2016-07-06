//
//  ExtensionGuestSkillDetailCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ExtensionGuestSkillDetailCell.h"

@implementation ExtensionGuestSkillDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell61";
    ExtensionGuestSkillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[ExtensionGuestSkillDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  客户年龄标题
        self.tkjqLabel = [[UILabel alloc] initWithFrame:(CGRect){15,15,k_w,21}];
        self.tkjqLabel.text = @"技巧说明：";
        self.tkjqLabel.font = [UIFont systemFontOfSize:13];
        self.tkjqLabel.textColor = [UIColor blackColor];
        self.tkjqLabel.alpha = 0.5;
        [self addSubview:self.tkjqLabel];
        
        //  客户年龄内容
        self.tkjqContentTextView = [[UITextView alloc] init];
        self.tkjqContentTextView.font = [UIFont systemFontOfSize:13];
        self.tkjqContentTextView.textColor = [UIColor blackColor];
        self.tkjqContentTextView.alpha = 0.9;
        self.tkjqContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.tkjqContentTextView];
        
        
        
    }
    
    return self;
}

-(void)setTkjq:(NSString *)tkjq{
    if (tkjq == nil) return;
    
    self.tkjqContentTextView.text = tkjq;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    self.tkjqContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.tkjqContentTextView.text attributes:attributes];
    
    CGRect tkjqLabelFrame = [tkjq boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    tkjqLabelFrame.origin.x = 10;
    tkjqLabelFrame.origin.y = 32;
    tkjqLabelFrame.size.height += 10;
    tkjqLabelFrame.size.width += 10;
    
    self.tkjqContentTextView.frame = tkjqLabelFrame;
}

@end