//
//  JiwuSupportDetailCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "JiwuSupportDetailCell.h"

@implementation JiwuSupportDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell71";
    JiwuSupportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[JiwuSupportDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  支持说明标题
        self.jwzcLabel = [[UILabel alloc] initWithFrame:(CGRect){15,15,k_w,21}];
        self.jwzcLabel.text = @"支持说明：";
        self.jwzcLabel.font = [UIFont systemFontOfSize:13];
        self.jwzcLabel.textColor = [UIColor blackColor];
        self.jwzcLabel.alpha = 0.5;
        [self addSubview:self.jwzcLabel];
        
        //  支持说明内容
        self.jwzcContentTextView = [[UITextView alloc] init];
        self.jwzcContentTextView.font = [UIFont systemFontOfSize:13];
        self.jwzcContentTextView.textColor = [UIColor blackColor];
        self.jwzcContentTextView.alpha = 0.9;
        self.jwzcContentTextView.userInteractionEnabled = NO;
        [self addSubview:self.jwzcContentTextView];
        
        
        
    }
    
    return self;
}

-(void)setJwzc:(NSString *)jwzc{
    if (jwzc == nil) return;
    
    self.jwzcContentTextView.text = jwzc;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    self.jwzcContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.jwzcContentTextView.text attributes:attributes];
    
    CGRect jwzcLabelFrame = [jwzc boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    jwzcLabelFrame.origin.x = 10;
    jwzcLabelFrame.origin.y = 32;
    jwzcLabelFrame.size.height += 10;
    jwzcLabelFrame.size.width += 10;
    
    self.jwzcContentTextView.frame = jwzcLabelFrame;
}

@end