//
//  HuxingCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HuxingCell.h"

@implementation HuxingCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell31";
    HuxingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[HuxingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.pathImageView = [[UIImageView alloc] initWithFrame:(CGRect){18,18,90,62}];
        [self addSubview:self.pathImageView];
        
        //  名字标签
        self.nameLabel = [[UILabel alloc] initWithFrame:(CGRect){120,18,k_w - 120,21}];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.alpha = 0.9;
        [self addSubview:self.nameLabel];
        
        //  面积标签
        self.areaLabel = [[UILabel alloc] initWithFrame:(CGRect){120,48,k_w - 120,21}];
        self.areaLabel.font = [UIFont systemFontOfSize:12];
        self.areaLabel.textColor = [UIColor blackColor];
        self.areaLabel.alpha = 0.6;
        [self addSubview:self.areaLabel];
        
    }
    
    return self;
}

-(void)setPath:(NSString *)path{
    [self.pathImageView sd_setImageWithURL:[NSURL URLWithString:path]];
}

-(void)setName:(NSString *)name{
    self.nameLabel.text = name;
}

-(void)setArea:(NSString *)area{
    self.areaLabel.text = [NSString stringWithFormat:@"%@ m²",area];
}

@end
