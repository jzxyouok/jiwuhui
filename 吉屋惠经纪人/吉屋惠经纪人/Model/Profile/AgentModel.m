//
//  AgentModel.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "AgentModel.h"

@implementation AgentModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
