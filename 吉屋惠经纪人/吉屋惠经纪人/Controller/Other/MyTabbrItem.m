//
//  MyTabbrItem.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "MyTabbrItem.h"

@implementation MyTabbrItem

/**
 *  初始化
 *
 *  @param frame      frame
 *  @param title      文字
 *  @param image      图片
 *  @param titleColor 文字颜色
 *  @param titleFont  文字字体
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andImage:(UIImage *)image andTitleColor:(UIColor *)titleColor andTitleFont:(UIFont *)titleFont{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = titleFont;
        CGRect frame1 = [title boundingRectWithSize:(CGSize){MAXFLOAT,49} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:titleFont} context:nil];
        [self setTitleEdgeInsets:(UIEdgeInsets){49/2,0,0,image.size.width}];
        [self setImageEdgeInsets:(UIEdgeInsets){5,frame1.size.width,49/2,0}];
    }
    return self;
}

@end
