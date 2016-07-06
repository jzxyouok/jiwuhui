//
//  AgentModel.h
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/2.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentModel : NSObject

@property (nonatomic, copy) NSString *personPath;
@property (nonatomic, copy) NSNumber *cstatus;
@property (nonatomic, copy) NSNumber *cityId;
@property (nonatomic, copy) NSNumber *companryInfoStatus;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *idcardFailedInfo;
@property (nonatomic, copy) NSNumber *fynum;
@property (nonatomic, copy) NSNumber *pflush;
@property (nonatomic, copy) NSNumber *psign;
@property (nonatomic, copy) NSString *fwname;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, copy) NSString *agentmname;
@property (nonatomic, copy) NSNumber *checkStatus;
@property (nonatomic, copy) NSNumber *idcardNumberStatus;
@property (nonatomic, copy) NSString *dpUrl;
@property (nonatomic, copy) NSNumber *refTotal;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSNumber *jid;
@property (nonatomic, copy) NSNumber *pflushNum;
@property (nonatomic, copy) NSString *linkName;
@property (nonatomic, copy) NSString *companryFailedInfo;
@property (nonatomic, copy) NSString *shopNotice;
@property (nonatomic, copy) NSString *serviceDeclaration;
@property (nonatomic, copy) NSNumber *sflush;
@property (nonatomic, copy) NSString *linkMobile;
@property (nonatomic, copy) NSNumber *personInfoStatus;
@property (nonatomic, copy) NSNumber *isshareRed;
@property (nonatomic, copy) NSNumber *DistrictID;
@property (nonatomic, copy) NSNumber *agentId;
@property (nonatomic, copy) NSString *evaluateGrade;
@property (nonatomic, copy) NSString *weixi;
@property (nonatomic, copy) NSString *ccmc;
@property (nonatomic, copy) NSNumber *phomesNum;
@property (nonatomic, copy) NSString *wdPath;
@property (nonatomic, copy) NSNumber *tagType;
@property (nonatomic, copy) NSNumber *issign;
@property (nonatomic, copy) NSString *districtName;
@property (nonatomic, copy) NSString *shopPathShare;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phoneBookLimit;
@property (nonatomic, copy) NSString *shopPath;
@property (nonatomic, copy) NSNumber *agentmid;
@property (nonatomic, copy) NSNumber *showcaseNumber;
@property (nonatomic, copy) NSString *turename;
@property (nonatomic, copy) NSString *shopPathUrl;
@property (nonatomic, copy) NSString *mobile;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
