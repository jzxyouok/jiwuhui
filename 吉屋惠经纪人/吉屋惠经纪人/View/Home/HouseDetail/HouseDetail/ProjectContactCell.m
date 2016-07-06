//
//  ProjectContactCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ProjectContactCell.h"

@implementation ProjectContactCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell81";
    ProjectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[ProjectContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  服务专员标题
        self.projectContactLabel = [[UILabel alloc] initWithFrame:(CGRect){15,15,k_w,21}];
        self.projectContactLabel.font = [UIFont systemFontOfSize:16];
        self.projectContactLabel.textColor = [UIColor blackColor];
        self.projectContactLabel.alpha = 0.8;
        [self addSubview:self.projectContactLabel];
        
        //  电话图标
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){k_w - 50,9,35,35}];
        imageView.image = [UIImage imageNamed:@"call"];
        [self addSubview:imageView];
    }
    
    return self;
}

-(void)setProjectContact:(NSString *)projectContact{
    if (projectContact == nil) return;
    
    self.projectContactLabel.text = [NSString stringWithFormat:@"服务专员（%@）",projectContact];
}

@end