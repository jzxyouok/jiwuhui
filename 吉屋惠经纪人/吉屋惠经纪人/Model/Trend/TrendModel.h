//
//  Trend.h
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *praise;
@property (nonatomic, strong) NSArray *commentPeople;
@property (nonatomic, strong) NSArray *comment;
@property (nonatomic, copy) NSString *transmit;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)trendWithDict:(NSDictionary *)dict;

@end
