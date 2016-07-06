//
//  GiftModel.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/6/29.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftModel : NSObject

@property (nonatomic, copy) NSString *giftTag;
@property (nonatomic, copy) NSString *convertCondition;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *bigPath;
@property (nonatomic, copy) NSString *residueNumber;
@property (nonatomic, copy) NSString *isDraw;
@property (nonatomic, copy) NSString *convertetime;
@property (nonatomic, copy) NSString *isjfConvert;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *drawNumber;
@property (nonatomic, copy) NSString *convertstime;
@property (nonatomic, copy) NSString *convertDiscount;
@property (nonatomic, copy) NSString *drawJf;
@property (nonatomic, copy) NSString *convertprice;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *totalNumber;
@property (nonatomic, copy) NSString *discountprice;
@property (nonatomic, copy) NSString *tagColor;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
