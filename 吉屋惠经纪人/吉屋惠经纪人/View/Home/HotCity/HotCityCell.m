//
//  HotCityCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HotCityCell.h"

@implementation HotCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *hotCityArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HotCity.plist" ofType:nil]];
        for (int i = 0; i < hotCityArr.count; i++) {
            CGFloat buttonW = 97;
            CGFloat buttonH = 30;
            CGFloat marginX = (k_w - 3 * buttonW) / 4;
            CGFloat marginY = 10;
            
            CGFloat buttonX = marginX + (buttonW + marginX) * (i % 3);
            CGFloat buttonY = marginY + (marginY + buttonH) * (i/3);
            UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){buttonX,buttonY,buttonW,buttonH}];
            [self addSubview:button];
            
            [button setTitle:[hotCityArr objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            button.alpha = 0.8;
            
            button.tag = i;
            [button addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = kColor(240, 240, 240);
        }
    }
    return self;
}

- (void)cityButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(hotCityCellCityButtonClick:)]) {
        NSArray *hotCityArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HotCity.plist" ofType:nil]];
        [self.delegate hotCityCellCityButtonClick:[hotCityArr objectAtIndex:sender.tag]];
    }
}

@end
