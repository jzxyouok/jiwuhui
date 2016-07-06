//
//  Trend.m
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "TrendModel.h"

@implementation TrendModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)trendWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
