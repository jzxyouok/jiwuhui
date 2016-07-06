//
//  TrendFrameModel.h
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TrendModel;

@interface TrendFrameModel : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect positionF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect fromF;
@property (nonatomic, assign, readonly) CGRect callF;
@property (nonatomic, assign, readonly) CGRect textViewF;
@property (nonatomic, assign, readonly) CGRect imageF;
@property (nonatomic, assign, readonly) CGRect praiseCountF;
@property (nonatomic, assign, readonly) CGRect commentCountF;
@property (nonatomic, assign, readonly) CGRect transmitCountF;
@property (nonatomic, assign, readonly) CGRect praiseF;
@property (nonatomic, assign, readonly) CGRect commentF;
@property (nonatomic, assign, readonly) CGRect remarkViewF;

@property (nonatomic, assign) CGFloat cellH;
@property (nonatomic, strong) TrendModel *trend;

@property (nonatomic, strong)NSMutableDictionary *bbsData;

@end
