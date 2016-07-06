//
//  SalePointCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "SalePointCell.h"

@implementation SalePointCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell41";
    SalePointCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[SalePointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  价格优势标题
        self.jgysLabel = [[UILabel alloc] initWithFrame:(CGRect){15,15,k_w,21}];
        self.jgysLabel.text = @"价格优势：";
        self.jgysLabel.font = [UIFont systemFontOfSize:13];
        self.jgysLabel.textColor = [UIColor blackColor];
        self.jgysLabel.alpha = 0.5;
        [self addSubview:self.jgysLabel];
        
        //  价格优势内容
        self.jgysContentTextView = [[UITextView alloc] init];
        self.jgysContentTextView.font = [UIFont systemFontOfSize:13];
        self.jgysContentTextView.textColor = [UIColor blackColor];
        self.jgysContentTextView.alpha = 0.9;
        self.jgysContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.jgysContentTextView];
        
        //  生活配套标题
        self.shptLabel = [[UILabel alloc] init];
        self.shptLabel.text = @"生活配套：";
        self.shptLabel.font = [UIFont systemFontOfSize:13];
        self.shptLabel.textColor = [UIColor blackColor];
        self.shptLabel.alpha = 0.5;
        [self addSubview:self.shptLabel];
        
        //  生活配套内容
        self.shptContentTextView = [[UITextView alloc] init];
        self.shptContentTextView.font = [UIFont systemFontOfSize:13];
        self.shptContentTextView.textColor = [UIColor blackColor];
        self.shptContentTextView.alpha = 0.9;
        self.shptContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.shptContentTextView];
        
        //  学区配套标题
        self.xqptLabel = [[UILabel alloc] init];
        self.xqptLabel.text = @"学区配套：";
        self.xqptLabel.font = [UIFont systemFontOfSize:13];
        self.xqptLabel.textColor = [UIColor blackColor];
        self.xqptLabel.alpha = 0.5;
        [self addSubview:self.xqptLabel];
        
        //  学区配套内容
        self.xqptContentTextView = [[UITextView alloc] init];
        self.xqptContentTextView.font = [UIFont systemFontOfSize:13];
        self.xqptContentTextView.textColor = [UIColor blackColor];
        self.xqptContentTextView.alpha = 0.9;
        self.xqptContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.xqptContentTextView];
        
        //  交通配套标题
        self.jtptLabel = [[UILabel alloc] init];
        self.jtptLabel.text = @"交通配套：";
        self.jtptLabel.font = [UIFont systemFontOfSize:13];
        self.jtptLabel.textColor = [UIColor blackColor];
        self.jtptLabel.alpha = 0.5;
        [self addSubview:self.jtptLabel];
        
        //  交通配套内容
        self.jtptContentTextView = [[UITextView alloc] init];
        self.jtptContentTextView.font = [UIFont systemFontOfSize:13];
        self.jtptContentTextView.textColor = [UIColor blackColor];
        self.jtptContentTextView.alpha = 0.9;
        self.jtptContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.jtptContentTextView];
        
        
        
    }
    
    return self;
}

-(void)setJgys:(NSString *)jgys{
    if (jgys == nil) return;
    
    self.jgysContentTextView.text = jgys;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    self.jgysContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.jgysContentTextView.text attributes:attributes];
    
    CGRect jgysContentTextViewFrame = [jgys boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    jgysContentTextViewFrame.origin.x = 10;
    jgysContentTextViewFrame.origin.y = 32;
    jgysContentTextViewFrame.size.height += 10;
    jgysContentTextViewFrame.size.width += 10;
    
    self.jgysContentTextView.frame = jgysContentTextViewFrame;
    
    if (self.jgysContentTextView.frame.size.height < 40) {
        self.shptLabel.frame = CGRectMake(15, CGRectGetMaxY(self.jgysContentTextView.frame) - 5, k_w, 21);
    }else{
        self.shptLabel.frame = CGRectMake(15, CGRectGetMaxY(self.jgysContentTextView.frame), k_w, 21);
    }
}

-(void)setShpt:(NSString *)shpt{
    if (shpt == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect shptContentTextViewFrame = [shpt boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    shptContentTextViewFrame.origin.x = 10;
    shptContentTextViewFrame.origin.y = CGRectGetMaxY(self.shptLabel.frame) - 4;
    shptContentTextViewFrame.size.height += 10;
    shptContentTextViewFrame.size.width += 10;
    
    self.shptContentTextView.frame = shptContentTextViewFrame;
    self.shptContentTextView.text = shpt;
    self.xqptLabel.frame = CGRectMake(15, CGRectGetMaxY(self.shptContentTextView.frame) + 4, k_w, 21);
    self.shptContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.shptContentTextView.text attributes:attributes];
}

-(void)setXqpt:(NSString *)xqpt{
    if (xqpt == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect xqptContentTextViewFrame = [xqpt boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    xqptContentTextViewFrame.origin.x = 10;
    xqptContentTextViewFrame.origin.y = CGRectGetMaxY(self.xqptLabel.frame) - 4;
    xqptContentTextViewFrame.size.height += 10;
    xqptContentTextViewFrame.size.width += 10;
    
    self.xqptContentTextView.frame = xqptContentTextViewFrame;
    self.xqptContentTextView.text = xqpt;
    self.jtptLabel.frame = CGRectMake(15, CGRectGetMaxY(self.xqptContentTextView.frame) + 4, k_w, 21);
    self.xqptContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.xqptContentTextView.text attributes:attributes];
}

-(void)setJtpt:(NSString *)jtpt{
    if (jtpt == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect jtptContentTextViewFrame = [jtpt boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    jtptContentTextViewFrame.origin.x = 10;
    jtptContentTextViewFrame.origin.y = CGRectGetMaxY(self.jtptLabel.frame) - 4;
    jtptContentTextViewFrame.size.height += 10;
    jtptContentTextViewFrame.size.width += 10;
    
    self.jtptContentTextView.frame = jtptContentTextViewFrame;
    self.jtptContentTextView.text = jtpt;
    self.jtptContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.jtptContentTextView.text attributes:attributes];
}

@end