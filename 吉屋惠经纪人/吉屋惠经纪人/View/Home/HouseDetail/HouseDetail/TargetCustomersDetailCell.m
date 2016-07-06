//
//  TargetCustomersDetailCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "TargetCustomersDetailCell.h"

@implementation TargetCustomersDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell51";
    TargetCustomersDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[TargetCustomersDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  客户年龄标题
        self.khnlLabel = [[UILabel alloc] initWithFrame:(CGRect){15,15,k_w,21}];
        self.khnlLabel.text = @"客户年龄：";
        self.khnlLabel.font = [UIFont systemFontOfSize:13];
        self.khnlLabel.textColor = [UIColor blackColor];
        self.khnlLabel.alpha = 0.5;
        [self addSubview:self.khnlLabel];
        
        //  客户年龄内容
        self.khnlContentTextView = [[UITextView alloc] init];
        self.khnlContentTextView.font = [UIFont systemFontOfSize:13];
        self.khnlContentTextView.textColor = [UIColor blackColor];
        self.khnlContentTextView.alpha = 0.9;
        self.khnlContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.khnlContentTextView];
        
        //  购房目的标题
        self.gfmdLabel = [[UILabel alloc] init];
        self.gfmdLabel.text = @"购房目的：";
        self.gfmdLabel.font = [UIFont systemFontOfSize:13];
        self.gfmdLabel.textColor = [UIColor blackColor];
        self.gfmdLabel.alpha = 0.5;
        [self addSubview:self.gfmdLabel];
        
        //  购房目的内容
        self.gfmdContentTextView = [[UITextView alloc] init];
        self.gfmdContentTextView.font = [UIFont systemFontOfSize:13];
        self.gfmdContentTextView.textColor = [UIColor blackColor];
        self.gfmdContentTextView.alpha = 0.9;
        self.gfmdContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.gfmdContentTextView];
        
        //  购房预算标题
        self.gfysLabel = [[UILabel alloc] init];
        self.gfysLabel.text = @"购房预算：";
        self.gfysLabel.font = [UIFont systemFontOfSize:13];
        self.gfysLabel.textColor = [UIColor blackColor];
        self.gfysLabel.alpha = 0.5;
        [self addSubview:self.gfysLabel];
        
        //  购房预算内容
        self.gfysContentTextView = [[UITextView alloc] init];
        self.gfysContentTextView.font = [UIFont systemFontOfSize:13];
        self.gfysContentTextView.textColor = [UIColor blackColor];
        self.gfysContentTextView.alpha = 0.9;
        self.gfysContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.gfysContentTextView];
        
        //  客户职业标题
        self.kfzyLabel = [[UILabel alloc] init];
        self.kfzyLabel.text = @"客户职业：";
        self.kfzyLabel.font = [UIFont systemFontOfSize:13];
        self.kfzyLabel.textColor = [UIColor blackColor];
        self.kfzyLabel.alpha = 0.5;
        [self addSubview:self.kfzyLabel];
        
        //  客户职业内容
        self.kfzyContentTextView = [[UITextView alloc] init];
        self.kfzyContentTextView.font = [UIFont systemFontOfSize:13];
        self.kfzyContentTextView.textColor = [UIColor blackColor];
        self.kfzyContentTextView.alpha = 0.9;
        self.kfzyContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.kfzyContentTextView];
        
        //  工作区域标题
        self.gzqyLabel = [[UILabel alloc] init];
        self.gzqyLabel.text = @"工作区域：";
        self.gzqyLabel.font = [UIFont systemFontOfSize:13];
        self.gzqyLabel.textColor = [UIColor blackColor];
        self.gzqyLabel.alpha = 0.5;
        [self addSubview:self.gzqyLabel];
        
        //  工作区域内容
        self.gzqyContentTextView = [[UITextView alloc] init];
        self.gzqyContentTextView.font = [UIFont systemFontOfSize:13];
        self.gzqyContentTextView.textColor = [UIColor blackColor];
        self.gzqyContentTextView.alpha = 0.9;
        self.gzqyContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.gzqyContentTextView];
        
        //  居住区域标题
        self.jzqyLabel = [[UILabel alloc] init];
        self.jzqyLabel.text = @"居住区域：";
        self.jzqyLabel.font = [UIFont systemFontOfSize:13];
        self.jzqyLabel.textColor = [UIColor blackColor];
        self.jzqyLabel.alpha = 0.5;
        [self addSubview:self.jzqyLabel];
        
        //  居住区域内容
        self.jzqyContentTextView = [[UITextView alloc] init];
        self.jzqyContentTextView.font = [UIFont systemFontOfSize:13];
        self.jzqyContentTextView.textColor = [UIColor blackColor];
        self.jzqyContentTextView.alpha = 0.9;
        self.jzqyContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.jzqyContentTextView];
        
        
        
    }
    
    return self;
}

-(void)setKhnl:(NSString *)khnl{
    if (khnl == nil) return;
    
    self.khnlContentTextView.text = khnl;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    self.khnlContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.khnlContentTextView.text attributes:attributes];
    
    CGRect jgysLabelFrame = [khnl boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    jgysLabelFrame.origin.x = 10;
    jgysLabelFrame.origin.y = 32;
    jgysLabelFrame.size.height += 10;
    jgysLabelFrame.size.width += 10;
    
    self.khnlContentTextView.frame = jgysLabelFrame;
    
    if (self.khnlContentTextView.frame.size.height < 40) {
        self.gfmdLabel.frame = CGRectMake(15, CGRectGetMaxY(self.khnlContentTextView.frame) - 5, k_w, 21);
    }else{
        self.gfmdLabel.frame = CGRectMake(15, CGRectGetMaxY(self.khnlContentTextView.frame), k_w, 21);
    }
}

-(void)setGfmd:(NSString *)gfmd{
    if (gfmd == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect shptLabelFrame = [gfmd boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    shptLabelFrame.origin.x = 10;
    shptLabelFrame.origin.y = CGRectGetMaxY(self.gfmdLabel.frame) - 4;
    shptLabelFrame.size.height += 10;
    shptLabelFrame.size.width += 10;
    
    self.gfmdContentTextView.frame = shptLabelFrame;
    self.gfmdContentTextView.text = gfmd;
    self.gfmdContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.gfmdContentTextView.text attributes:attributes];
    
    if (self.gfmdContentTextView.frame.size.height < 40) {
        self.gfysLabel.frame = CGRectMake(15, CGRectGetMaxY(self.gfmdContentTextView.frame) - 5, k_w, 21);
    }else{
        self.gfysLabel.frame = CGRectMake(15, CGRectGetMaxY(self.gfmdContentTextView.frame), k_w, 21);
    }
}

-(void)setGfys:(NSString *)gfys{
    if (gfys == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect gfysContentTextViewFrame = [gfys boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    gfysContentTextViewFrame.origin.x = 10;
    gfysContentTextViewFrame.origin.y = CGRectGetMaxY(self.gfysLabel.frame) - 4;
    gfysContentTextViewFrame.size.height += 10;
    gfysContentTextViewFrame.size.width += 10;
    
    self.gfysContentTextView.frame = gfysContentTextViewFrame;
    self.gfysContentTextView.text = gfys;
    self.gfysContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.gfysContentTextView.text attributes:attributes];
    
    if (self.gfysContentTextView.frame.size.height < 40) {
        self.kfzyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.gfysContentTextView.frame) - 5, k_w, 21);
    }else{
        self.kfzyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.gfysContentTextView.frame), k_w, 21);
    }
}

-(void)setKfzy:(NSString *)kfzy{
    if (kfzy == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect kfzyContentTextViewFrame = [kfzy boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    kfzyContentTextViewFrame.origin.x = 10;
    kfzyContentTextViewFrame.origin.y = CGRectGetMaxY(self.kfzyLabel.frame) - 4;
    kfzyContentTextViewFrame.size.height += 10;
    kfzyContentTextViewFrame.size.width += 10;
    
    self.kfzyContentTextView.frame = kfzyContentTextViewFrame;
    self.kfzyContentTextView.text = kfzy;
    self.kfzyContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.kfzyContentTextView.text attributes:attributes];
    
    if (self.kfzyContentTextView.frame.size.height < 40) {
        self.gzqyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.kfzyContentTextView.frame) - 5, k_w, 21);
    }else{
        self.gzqyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.kfzyContentTextView.frame), k_w, 21);
    }
}

-(void)setGzqy:(NSString *)gzqy{
    if (gzqy == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect gzqyContentTextViewFrame = [gzqy boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    gzqyContentTextViewFrame.origin.x = 10;
    gzqyContentTextViewFrame.origin.y = CGRectGetMaxY(self.gzqyLabel.frame) - 4;
    gzqyContentTextViewFrame.size.height += 10;
    gzqyContentTextViewFrame.size.width += 10;
    
    self.gzqyContentTextView.frame = gzqyContentTextViewFrame;
    self.gzqyContentTextView.text = gzqy;
    self.gzqyContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.gzqyContentTextView.text attributes:attributes];
    
    if (self.gzqyContentTextView.frame.size.height < 40) {
        self.jzqyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.gzqyContentTextView.frame) - 5, k_w, 21);
    }else{
        self.jzqyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.gzqyContentTextView.frame), k_w, 21);
    }
}

-(void)setJzqy:(NSString *)jzqy{
    if (jzqy == nil) return;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect jzqyContentTextViewFrame = [jzqy boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    jzqyContentTextViewFrame.origin.x = 10;
    jzqyContentTextViewFrame.origin.y = CGRectGetMaxY(self.jzqyLabel.frame) - 4;
    jzqyContentTextViewFrame.size.height += 10;
    jzqyContentTextViewFrame.size.width += 10;
    
    self.jzqyContentTextView.frame = jzqyContentTextViewFrame;
    self.jzqyContentTextView.text = jzqy;
    self.jzqyContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.jzqyContentTextView.text attributes:attributes];
}

@end