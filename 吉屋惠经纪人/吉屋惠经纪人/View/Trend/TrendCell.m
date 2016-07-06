//
//  TrendCell.m
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "TrendCell.h"
#import "TrendFrameModel.h"
#import "TrendModel.h"
#define kNameFont [UIFont systemFontOfSize:17.0f]
#define kTextFont [UIFont systemFontOfSize:15.0f]
#define kotherFont [UIFont systemFontOfSize:15.0f]

@interface TrendCell()

@property (nonatomic, weak)UIImageView *icon;
@property (nonatomic, weak)UILabel *name;
@property (nonatomic, weak)UILabel *position;
@property (nonatomic, weak)UILabel *time;
@property (nonatomic, weak)UILabel *from;
@property (nonatomic, weak)UILabel *textView;
@property (nonatomic, weak)UIView *imageView1;
@property (nonatomic, weak)UIButton *praiseCount;
@property (nonatomic, weak)UIButton *commentCount;
@property (nonatomic, weak)UIButton *transmitCount;
@property (nonatomic, weak)UIButton *praise;
@property (nonatomic, weak)UIView *comment;
@property (nonatomic, weak)UIButton *allComment;
@property (nonatomic, weak)UIView *remarkView;


@end

@implementation TrendCell

+(instancetype)trendCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"trendCell";
    TrendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[TrendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //1.头像
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        //2.名称
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.backgroundColor = [UIColor clearColor];
        self.name = name;
        
        //3.职称
        UILabel *position = [[UILabel alloc] init];
        [self.contentView addSubview:position];
        position.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        position.backgroundColor = [UIColor clearColor];
        self.position = position;
        
        //4.时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        time.backgroundColor = [UIColor clearColor];
        self.time = time;
        
        //6.正文
        UILabel *textView = [[UILabel alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //4.图片
        UIView *imageView = [[UIView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView1 = imageView;
        
        //7.赞个数
        UIButton *praiseCount = [[UIButton alloc] init];
        [self.contentView addSubview:praiseCount];
        self.praiseCount = praiseCount;
        
        //8.评论数
        UIButton *commentCount = [[UIButton alloc] init];
        [self.contentView addSubview:commentCount];
        self.commentCount = commentCount;
        
        //9.转发数
        UIButton *transmitCount = [[UIButton alloc] init];
        [self.contentView addSubview:transmitCount];
        self.transmitCount = transmitCount;
        
        //10.赞
        UIButton *praise = [[UIButton alloc] init];
        [self.contentView addSubview:praise];
        self.praise = praise;
        
        //  评论内容
        UIView *remarkView = [[UIView alloc] init];
        self.remarkView = remarkView;
        [self addSubview:remarkView];
     }
    return self;
}

-(void)setFrameTrend:(TrendFrameModel *)frameTrend{
    _frameTrend = frameTrend;
    NSMutableDictionary *bbsData = frameTrend.bbsData;
    
    
    //1.头像
    self.icon.frame = _frameTrend.iconF;
    self.icon.image = [UIImage imageNamed:@"zhangmeier"];
    
    //2.名称
    self.name.frame = _frameTrend.nameF;
    self.name.font = kNameFont;
    self.name.text = @"吉屋小二";
    
    //3.职称
    self.position.frame = _frameTrend.positionF;
    self.position.font = kotherFont;
    self.position.text = @"管理员";
    
    //6.正文
    self.textView.frame = _frameTrend.textViewF;
    self.textView.font = kTextFont;
    self.textView.numberOfLines = 0;
    NSString *content = bbsData[@"content"];
    self.textView.textColor = [UIColor blackColor];
    self.textView.text = content;
    
    //4.图片
    self.imageView1.frame = _frameTrend.imageF;
    [self setupImageWithModel:bbsData];
    
    //4.时间
    self.time.frame = _frameTrend.timeF;
    self.time.font = kotherFont;
    self.time.text = bbsData[@"ctime"];
    
    //7.赞个数
    self.praiseCount.frame = _frameTrend.praiseCountF;
    [self.praiseCount setImage:[UIImage imageNamed:@"没赞"] forState:UIControlStateNormal];
    [self.praiseCount setImage:[UIImage imageNamed:@"没赞2_"] forState:UIControlStateHighlighted];
    
    [self.praiseCount setTitle:[NSString stringWithFormat:@"%@",bbsData[@"praiseNumber"]] forState:UIControlStateNormal];
    [self.praiseCount setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    self.praiseCount.titleEdgeInsets = UIEdgeInsetsMake(0, 
10, 0, 0);
    
    
    
    //8.评论数
    self.commentCount.frame = _frameTrend.commentCountF;
    [self.commentCount setImage:[UIImage imageNamed:@"评论1_"] forState:UIControlStateNormal];
    [self.commentCount setImage:[UIImage imageNamed:@"评论2_"] forState:UIControlStateHighlighted];
    
    [self.commentCount setTitle:[NSString stringWithFormat:@"%@",bbsData[@"replynum"]] forState:UIControlStateNormal];
    [self.commentCount setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    self.commentCount.titleEdgeInsets = UIEdgeInsetsMake(0, 
10, 0, 0);
    
    
    //  评论内容
    self.remarkView.frame = _frameTrend.remarkViewF;
//    self.remarkView.backgroundColor = [UIColor redColor];
    NSDictionary *remark = bbsData[@"remark"];
    NSString *rmStr = [NSString stringWithFormat:@"%@",bbsData[@"remark"]];
    
    if (rmStr.length > 0) {
        NSNumber *number = remark[@"number"];
        NSArray *Agentbbs = remark[@"Agentbbs"];
        
        CGFloat remarkViewW = k_w - (10 + CGRectGetMaxX(self.icon.frame)) - 2 * 10;
        CGFloat truenameY = 0;
        CGFloat huifuContentX = 0;
        
        for (NSDictionary *agentbbsDict in Agentbbs) {
            
            //  回复人
            NSMutableString *remarkStr = [NSMutableString stringWithFormat:@"%@",agentbbsDict[@"truename"]];
            CGRect truenameFrame = [remarkStr boundingRectWithSize:(CGSize){MAXFLOAT,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil];
            truenameFrame.origin.y = truenameY + 5;
            UIButton *truenameBtn = [[UIButton alloc] initWithFrame:truenameFrame];
            [truenameBtn setTitle:remarkStr forState:UIControlStateNormal];
            [truenameBtn setTitleColor:kColor(0, 179, 90) forState:UIControlStateNormal];
            truenameBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
            [self.remarkView addSubview:truenameBtn];
            huifuContentX = CGRectGetMaxX(truenameBtn.frame);
            
            //  被回复的人
            NSString *beReplyJnameStr = [NSString stringWithFormat:@"%@",agentbbsDict[@"beReplyJname"]];
            if (beReplyJnameStr.length > 0) {
                //  回复标签
                CGFloat huifuX = CGRectGetMaxX(truenameBtn.frame);
                CGFloat huifuY = truenameBtn.frame.origin.y - 3;
                UILabel *huifuLabel = [[UILabel alloc] initWithFrame:(CGRect){huifuX,huifuY,40,21}];
                huifuLabel.text = @"  回复";
                huifuLabel.font = [UIFont boldSystemFontOfSize:13];
                huifuLabel.alpha = 0.6;
                [self.remarkView addSubview:huifuLabel];
                
                //  被回复的人按钮
                remarkStr = agentbbsDict[@"beReplyJname"];
                CGRect beReplyJnameFrame = [remarkStr boundingRectWithSize:(CGSize){MAXFLOAT,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil];
                beReplyJnameFrame.origin.x = CGRectGetMaxX(huifuLabel.frame);
                beReplyJnameFrame.origin.y = truenameBtn.origin.y;
                UIButton *beReplyJnameBtn = [[UIButton alloc] initWithFrame:beReplyJnameFrame];
                [beReplyJnameBtn setTitle:remarkStr forState:UIControlStateNormal];
                [beReplyJnameBtn setTitleColor:kColor(0, 179, 90) forState:UIControlStateNormal];
                beReplyJnameBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
                [self.remarkView addSubview:beReplyJnameBtn];
                huifuContentX = CGRectGetMaxX(beReplyJnameBtn.frame);
            }
            
            //  回复内容
            NSString *huifuContentStr = [[NSMutableString alloc] init];
            for (int i = 0; i < (int)(huifuContentX / 3.2); i++) {
                huifuContentStr = [huifuContentStr stringByAppendingString:@" "];
            }
            
            huifuContentStr = [huifuContentStr stringByAppendingString:@"："];
            huifuContentStr = [huifuContentStr stringByAppendingString:agentbbsDict[@"content"]];
            CGRect frame = [huifuContentStr boundingRectWithSize:(CGSize){remarkViewW,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil];
            frame.origin.y = truenameBtn.frame.origin.y;
            
            UILabel *huifuContentLabel = [[UILabel alloc] initWithFrame:frame];
            huifuContentLabel.text = huifuContentStr;
            huifuContentLabel.font = [UIFont boldSystemFontOfSize:13];
            huifuContentLabel.alpha = 0.6;
            huifuContentLabel.numberOfLines = 0;
            [self.remarkView addSubview:huifuContentLabel];
            truenameY = CGRectGetMaxY(huifuContentLabel.frame);
            huifuContentX = 0;
        }
        //  如果评论数 大于3 显示更多评论按钮
        if (number.intValue > 3) {
            UIButton *moreRemarkBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.remarkView.frame.size.width - 60, self.remarkView.frame.size.height - 30, 80, 30)];
            [moreRemarkBtn setTitle:@"更多评论" forState:UIControlStateNormal];
            [moreRemarkBtn setTitleColor:kColor_alpha(0, 0, 0, 0.5) forState:UIControlStateNormal];
            moreRemarkBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [moreRemarkBtn addTarget:self action:@selector(moreRemarkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            moreRemarkBtn.tag = self.btnTag;
            [self.remarkView addSubview:moreRemarkBtn];
        }
    }
    
}

//  点击更多评论按钮
- (void)moreRemarkBtnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(trendFrameMoreRemarkClick:)]) {
        [self.delegate trendFrameMoreRemarkClick:button];
    }
}

//  根据数据设置图片
-(void)setupImageWithModel:(NSMutableDictionary *)bbsData{
    NSString *paths = bbsData[@"paths"];
    NSArray *imageNames = [paths componentsSeparatedByString:@","];
    NSInteger count = imageNames.count;
    CGFloat buttonW = self.imageView1.frame.size.width / 3;
    
    
    if(count == 1){
        buttonW = self.imageView1.frame.size.width;
    }else if(count == 2 || count == 4){
        buttonW = self.imageView1.frame.size.width / 2;
    }
    
    for (UIView *view in self.imageView1.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < count && i < 9; i++) {
        CGFloat buttonX = buttonW * (i % 3);
        CGFloat buttonY = buttonW * (i / 3);
        if (count == 4) {
            buttonX = buttonW * (i % 2);
            buttonY = buttonW * (i / 2);
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX + 10 /2, buttonY + 10/2, buttonW - 10, buttonW - 10)];
        [self.contentView addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //  给按钮设置图片
        UIImageView *imageview = [[UIImageView alloc]init];
        NSURL *url = [NSURL URLWithString:imageNames[i]];
        SDWebImageOptions webImageOptions = SDWebImageRetryFailed | SDWebImageLowPriority;
        [imageview sd_setImageWithURL:url placeholderImage:nil options:webImageOptions completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [button setImage:imageview.image forState:UIControlStateNormal];
        }];
        [self.imageView1 addSubview:button];
    }
}

- (void)imageClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(trendFrameModelImageClick:)]) {
        [self.delegate trendFrameModelImageClick:button];
    }
}

@end
