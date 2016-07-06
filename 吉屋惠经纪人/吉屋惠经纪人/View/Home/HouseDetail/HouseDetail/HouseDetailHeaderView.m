//
//  HouseDetailHeaderView.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HouseDetailHeaderView.h"

@implementation HouseDetailHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, k_w, 126);
        
        //  背景图片按钮
        self.pathBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, k_w, 126)];
        [self addSubview:self.pathBtn];
//        [self.pathBtn addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
        
        //  右下角图标
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:(CGRect){k_w - 35,self.frame.size.height - 35,25,25}];
        imageview.image = [UIImage imageNamed:@"house_details_more"];
        [self addSubview:imageview];
    }
    return self;
}

-(void)setPath:(NSString *)path{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"楼盘默认图2"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.pathBtn setBackgroundImage:imageView.image forState:UIControlStateNormal];
    }];
}

@end
