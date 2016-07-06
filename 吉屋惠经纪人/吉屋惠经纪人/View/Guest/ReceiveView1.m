//
//  ReceiveView1.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/28.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "ReceiveView1.h"

@implementation ReceiveView1

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        //  您可领取标签
        UILabel *label = [[UILabel alloc]initWithFrame:(CGRect){10,12,80,21}];
        label.text = @"您可领取";
        label.textColor = [UIColor blackColor];
        label.alpha = 0.9;
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        
        
        //  认证客户个数默认0个
        UILabel *label2 = [[UILabel alloc]initWithFrame:(CGRect){70,12,10,21}];
        label2.text = @"0";
        label2.textColor = kColor(255, 88, 0);
        label2.alpha = 1;
        label2.font = [UIFont systemFontOfSize:15];
        [self addSubview:label2];
        
        //  个认证客户或标签
        UILabel *label3 = [[UILabel alloc]initWithFrame:(CGRect){80,12,100,21}];
        label3.text = @"个认证客户或";
        label3.textColor = [UIColor blackColor];
        label3.alpha = 0.9;
        label3.font = [UIFont systemFontOfSize:15];
        [self addSubview:label3];
        
        //  普通客户个数默认0个
        UILabel *label4 = [[UILabel alloc]initWithFrame:(CGRect){170,12,10,21}];
        label4.text = @"0";
        label4.textColor = kColor(255, 88, 0);
        label4.alpha = 1;
        label4.font = [UIFont systemFontOfSize:15];
        [self addSubview:label4];
        
        //  个普通客户或标签
        UILabel *label5 = [[UILabel alloc]initWithFrame:(CGRect){180,12,100,21}];
        label5.text = @"个普通客户";
        label5.textColor = [UIColor blackColor];
        label5.alpha = 0.9;
        label5.font = [UIFont systemFontOfSize:15];
        [self addSubview:label5];
    }
    return self;
}

@end
