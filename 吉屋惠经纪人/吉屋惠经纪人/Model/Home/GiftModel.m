//
//  GiftModel.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
