//
//  NoDataView.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

-(instancetype)initWithFrame:(CGRect)frame message:(NSString *)message{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 112, 133)];
        imageView.center = CGPointMake(k_w / 2, k_h / 2 - 62);
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"exchange_noexchange"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){imageView.frame.origin.x,imageView.frame.origin.y + 163,112,21}];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kColor(168, 168, 168);
        label.font = [UIFont systemFontOfSize:14];
        label.text = message;
        [self addSubview:label];
    }
    return self;
}

@end
