//
//  MyCell.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//


#import "HomeCell.h"

@implementation HomeCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"trendCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  图片
        self.buildPathImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 80)];
        [self addSubview:self.buildPathImageView];
        self.buildPathImageView.layer.cornerRadius = 3;
        self.buildPathImageView.layer.masksToBounds = YES;
        
        //  图片左边角标
        CGFloat cornermarkW = 30;
        CGFloat cornermarkX = -cornermarkW / 2;
        CGFloat cornermarkY = -cornermarkW / 2;
        CGFloat cornermarkH = cornermarkW;
        
        self.cornermarkView = [[UIView alloc] initWithFrame:(CGRect){cornermarkX,cornermarkY,cornermarkW,cornermarkH}];
        self.cornermarkView.layer.cornerRadius = cornermarkW/2;
        self.cornermarkView.layer.masksToBounds = YES;
        
        self.cornermarkLabel = [[UILabel alloc] initWithFrame:(CGRect){6,11,20,20}];
        self.cornermarkLabel.font = [UIFont systemFontOfSize:10];
        self.cornermarkLabel.textColor = kColor(255, 255, 255);
        self.cornermarkLabel.textAlignment = NSTextAlignmentRight;
        [self.cornermarkView addSubview:self.cornermarkLabel];
        
        //  图片底部黑框
        CGFloat priceRemarkX = self.buildPathImageView.frame.origin.x;
        CGFloat priceRemarkY = CGRectGetMaxY(self.buildPathImageView.frame) - 21;
        CGFloat priceRemarkW = self.buildPathImageView.frame.size.width;
        CGFloat priceRemarkH = 21;
        
        self.priceRemarkLabel = [[UILabel alloc] initWithFrame:(CGRect){priceRemarkX,priceRemarkY,priceRemarkW,priceRemarkH}];
        self.priceRemarkLabel.font = [UIFont systemFontOfSize:12];
        self.priceRemarkLabel.textColor = kColor(255, 255, 255);
        
        self.priceRemarkLabel.textAlignment = NSTextAlignmentCenter;
        self.priceRemarkLabel.backgroundColor = [UIColor blackColor];
        self.priceRemarkLabel.alpha = 0.7;
        [self addSubview:self.priceRemarkLabel];
        
        //  城市标题
        self.titleLabel = [[UILabel alloc] init];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = kColor(60, 60, 60);
        [self addSubview:self.titleLabel];
        
        //  副标题
        self.bnameBtn = [[UIButton alloc] init];
        
        self.bnameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.bnameBtn setTitleColor:kColor(60, 60, 60) forState:UIControlStateNormal];
        [self.bnameBtn setImage:[UIImage imageNamed:@"loupan_icon"] forState:UIControlStateNormal];
        self.bnameBtn.userInteractionEnabled = NO;
        [self addSubview:self.bnameBtn];
        
        //  合作经纪人
        self.countCusLabel = [[UILabel alloc] init];
        self.countCusLabel.font = [UIFont systemFontOfSize:13];
        self.countCusLabel.alpha = 0.5;
        [self addSubview:self.countCusLabel];
        
        //  意向客户
        self.yxCusNumberLabel = [[UILabel alloc] init];
        self.yxCusNumberLabel.font = [UIFont systemFontOfSize:13];
        self.yxCusNumberLabel.alpha = 0.5;
        [self addSubview:self.yxCusNumberLabel];
        
        //  佣金
        self.commissionBtn = [[UIButton alloc] init];
        self.commissionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.commissionBtn setTitleColor:kColor(255, 88, 0) forState:UIControlStateNormal];
        [self.commissionBtn setImage:[UIImage imageNamed:@"home_yongjin"] forState:UIControlStateNormal];
        self.commissionBtn.userInteractionEnabled = NO;
        [self addSubview:self.commissionBtn];
        
        //  报备客户
        CGFloat reportBtnW = 90;
        CGFloat reportBtnH = 30;
        CGFloat reportBtnX = k_w - 105;
        CGFloat reportBtnY = 100;
        
        UIButton *reportBtn = [[UIButton alloc] initWithFrame:CGRectMake(reportBtnX, reportBtnY, reportBtnW, reportBtnH)];
        [self addSubview:reportBtn];
        reportBtn.backgroundColor = kColor(255, 136, 56);
        [reportBtn setTitle:@"报备客户" forState:UIControlStateNormal];
        reportBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        reportBtn.layer.cornerRadius = 3;
        reportBtn.layer.masksToBounds = YES;
    }
    return self;
}

-(void)setHomeData:(NSMutableDictionary *)homeData{
    NSString *buildPath = homeData[@"buildPath"];
    NSString *cityName = homeData[@"cityName"];
    NSString *districtName = homeData[@"districtName"];
    NSString *buildType = homeData[@"buildType"];
    NSString *bname = homeData[@"bname"];
    NSString *countCus = homeData[@"countCus"];
    NSString *yxCusNumber = homeData[@"yxCusNumber"];
    NSString *commission = homeData[@"commission"];
    NSString *priceRemark = homeData[@"priceRemark"];
    NSNumber *isNew = homeData[@"isNew"];
    NSNumber *isHot = homeData[@"isHot"];
    
    //  图片
    NSURL *url = [NSURL URLWithString:buildPath];
    SDWebImageOptions webImageOptions = SDWebImageRetryFailed | SDWebImageLowPriority;
    [self.buildPathImageView sd_setImageWithURL:url placeholderImage:nil options:webImageOptions completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    //  图片左边角标
    if ([isNew isEqualToNumber:[NSNumber numberWithInt:1]]) {
        self.cornermarkLabel.text = @"新";
        self.cornermarkView.backgroundColor = kColor(0, 179, 90);
        [self.buildPathImageView addSubview:self.cornermarkView];
    }else if ([isHot isEqualToNumber:[NSNumber numberWithInt:1]]) {
        self.cornermarkLabel.text = @"热";
        self.cornermarkView.backgroundColor = kColor(255, 136, 56);
        [self.buildPathImageView addSubview:self.cornermarkView];
    }
    
    //  图片底部黑框
    self.priceRemarkLabel.text = priceRemark;
    
    //  城市标题
    NSString *titleName = [NSString stringWithFormat:@"%@-%@",cityName,districtName];
    CGRect titleFrame = [titleName boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    titleFrame.origin.x = CGRectGetMaxX(self.buildPathImageView.frame) + 10;
    titleFrame.origin.y = 15;
    self.titleLabel.frame = titleFrame;
    self.titleLabel.text = titleName;
    
    //  标题右边的图标
    NSArray *buildTypeArr = [buildType componentsSeparatedByString:@", "];
    int i = 0;
    for (NSString *str in buildTypeArr) {
        UILabel *buildTypeLabel = [[UILabel alloc] initWithFrame:(CGRect){CGRectGetMaxX(self.titleLabel.frame) + 14 + i * 17,self.titleLabel.frame.origin.y,14,14}];
        buildTypeLabel.textColor = kColor(255, 255, 255);
        buildTypeLabel.font = [UIFont systemFontOfSize:12];
        
        buildTypeLabel.layer.cornerRadius = 2;
        buildTypeLabel.layer.masksToBounds = YES;
        buildTypeLabel.textAlignment = NSTextAlignmentCenter;
        
        if ([str isEqualToString:@"住宅"]) {
            buildTypeLabel.text = @"住";
            buildTypeLabel.backgroundColor = kColor(255, 188, 147);
        }else if ([str isEqualToString:@"公寓"]) {
            buildTypeLabel.text = @"寓";
            buildTypeLabel.backgroundColor = kColor(0, 203, 189);
        }else if ([str isEqualToString:@"商铺"]) {
            buildTypeLabel.text = @"商";
            buildTypeLabel.backgroundColor = kColor(144, 234, 148);
        }
        [self addSubview:buildTypeLabel];
        i++;
    }
    
    //  副标题
    CGRect bnameFrame = [bname boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    bnameFrame.origin.x = CGRectGetMaxX(self.buildPathImageView.frame) + 10;
    bnameFrame.origin.y = CGRectGetMaxY(self.titleLabel.frame);
    bnameFrame.size.width += 30;
    self.bnameBtn.frame = bnameFrame;
    
    self.bnameBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, self.bnameBtn.frame.size.width - 16);
    self.bnameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.bnameBtn setTitle:bname forState:UIControlStateNormal];
    
    //  合作经纪人
    NSString *countCusStr = [NSString stringWithFormat:@"合作经纪人：%@",countCus];
    CGRect countCusFrame = [countCusStr boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    countCusFrame.origin.x = CGRectGetMaxX(self.buildPathImageView.frame) + 10;
    countCusFrame.origin.y = CGRectGetMaxY(self.bnameBtn.frame) + 8;
    self.countCusLabel.frame = countCusFrame;
    self.countCusLabel.text = countCusStr;
    
    //  意向客户
    NSString *yxCusNumberStr = [NSString stringWithFormat:@"意向客户：%@",yxCusNumber];
    CGRect yxCusNumberFrame = [yxCusNumberStr boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    yxCusNumberFrame.origin.x = CGRectGetMaxX(self.buildPathImageView.frame) + 10;
    yxCusNumberFrame.origin.y = CGRectGetMaxY(self.countCusLabel.frame) + 8;
    self.yxCusNumberLabel.frame = yxCusNumberFrame;
    self.yxCusNumberLabel.text = yxCusNumberStr;
    
    //  佣金(6000元/套)
    NSString *commissionStr = [NSString stringWithFormat:@"佣金:%@",commission];
    CGRect commissionFrame = [commissionStr boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    commissionFrame.origin.x = 15;
    
    commissionFrame.origin.y = CGRectGetMaxY(self.buildPathImageView.frame) + 10;
    commissionFrame.size.width += 30;
    self.commissionBtn.frame = commissionFrame;
    [self.commissionBtn setTitle:commissionStr forState:UIControlStateNormal];
    
    self.commissionBtn.imageEdgeInsets = UIEdgeInsetsMake(1, 1, 1, commissionFrame.size.width - 15);
    self.commissionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
}

@end
