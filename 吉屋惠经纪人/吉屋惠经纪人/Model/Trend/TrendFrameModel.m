//
//  TrendFrameModel.m
//  动态
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "TrendFrameModel.h"
#import "TrendModel.h"
#define kpadding 10
#define kNameFont [UIFont systemFontOfSize:17.0f]
#define kTextFont [UIFont systemFontOfSize:15.0f]
#define kotherFont [UIFont systemFontOfSize:15.0f]

@implementation TrendFrameModel

-(void)setBbsData:(NSMutableDictionary *)bbsData{
    _bbsData = bbsData;
    //    NNLog(@"%@",bbsData);
//    NNLog(@"%@",bbsData[@"remark"]);
    //1.头像
    _iconF = CGRectMake(kpadding, kpadding, 50, 50);
    
    //2.名字
    CGRect nameFrame = [@"吉屋小二" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:kNameFont} context:nil];
    nameFrame.origin.x = kpadding + CGRectGetMaxX(_iconF);
    nameFrame.origin.y = kpadding;
    _nameF = nameFrame;
    
    //3.职称
    CGRect positionFrame = [@"管理员" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:kotherFont} context:nil];
    positionFrame.origin.x = kpadding + CGRectGetMaxX(_iconF);
    positionFrame.origin.y = kpadding + CGRectGetMaxY(_nameF);
    _positionF = positionFrame;
    
    //6.正文
    NSString *content = bbsData[@"content"];
    CGFloat textViewW = k_w - (kpadding + CGRectGetMaxX(_iconF)) - 2 * kpadding;
    CGRect textViewFrame = [content boundingRectWithSize:CGSizeMake(textViewW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kTextFont} context:nil];
    textViewFrame.origin.x = kpadding + CGRectGetMaxX(_iconF);
    textViewFrame.origin.y = kpadding + CGRectGetMaxY(_iconF);
    textViewFrame.size.width = textViewW;
    _textViewF = textViewFrame;
    
    //4.图片
    CGFloat imageX = kpadding + CGRectGetMaxX(_iconF);
    CGFloat imageY = CGRectGetMaxY(_textViewF) + kpadding;
    CGFloat imageW = k_w - (kpadding + CGRectGetMaxX(_iconF)) - 2 * kpadding;
    CGFloat imageH = 0;
    
    NSString *paths = bbsData[@"paths"];
    NSArray *imageNames = [paths componentsSeparatedByString:@","];
    
    switch (imageNames.count) {
        case 0:
            imageH = 0;
            break;
        case 1:
            imageW /= 2;
            imageH = imageW;
            break;
        case 4:
            imageW /= 2;
            imageH = imageW;
            break;
        case 7:
        case 8:
        case 9:
            imageH = imageW;
            break;
        case 2:
            imageW = 2.0 / 3 * imageW;
            imageH = imageW / 2;
            break;
        case 3:
            imageH = imageW / 3;
            break;
        case 5:
        case 6:
            imageH = 2.0 / 3 * imageW;
            break;
            
        default:
            break;
    }
    if (imageNames.count > 9) {
        imageH = imageW;
    }
    
    //  由于第一张图片地址不是http开头，则为空
    NSString *str = [imageNames objectAtIndex:0];
    if (![str hasPrefix:@"http"]) {
        imageH = 0;
    }
    _imageF = CGRectMake(imageX, imageY, imageW, imageH);
    
    //4.时间
    CGRect timeFrame = [bbsData[@"ctime"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:kotherFont} context:nil];
    timeFrame.origin.x = kpadding + CGRectGetMaxX(_iconF);
    timeFrame.origin.y = kpadding + CGRectGetMaxY(_imageF);
    _timeF = timeFrame;
    
    //7.赞个数
    CGFloat praiseCountX = k_w - 100;
    CGFloat praiseCountY = CGRectGetMaxY(_timeF);
    CGFloat praiseCountW = 50;
    _praiseCountF = CGRectMake(praiseCountX, praiseCountY, praiseCountW, 30);
    
    
    //8.评论数
    CGFloat commentCountX = k_w - 50;
    CGFloat commentCountY = CGRectGetMaxY(_timeF);
    CGFloat commentCountW = 50;
    _commentCountF = CGRectMake(commentCountX, commentCountY, commentCountW, 30);
    
    //  9.评论内容
    CGFloat remarkViewX = kpadding + CGRectGetMaxX(_iconF);
    CGFloat remarkViewY = CGRectGetMaxY(_commentCountF) + kpadding;
    CGFloat remarkViewW = k_w - (kpadding + CGRectGetMaxX(_iconF)) - 2 * kpadding;
    CGFloat remarkViewH = 0;
    CGFloat truenameY = 0;
    CGFloat huifuContentX = 0;
    
    NSDictionary *remark = bbsData[@"remark"];
    NSString *rmStr = [NSString stringWithFormat:@"%@",bbsData[@"remark"]];
    if (rmStr.length > 0) {
        NSNumber *number = remark[@"number"];
        NSArray *Agentbbs = remark[@"Agentbbs"];
        
        
        for (NSDictionary *agentbbsDict in Agentbbs) {
            NSMutableString *remarkStr = [NSMutableString stringWithFormat:@"%@",agentbbsDict[@"truename"]];
            CGRect truenameFrame = [remarkStr boundingRectWithSize:(CGSize){MAXFLOAT,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil];
            truenameFrame.origin.y = truenameY + 5;
            
            NSString *beReplyJnameStr = [NSString stringWithFormat:@"%@",agentbbsDict[@"beReplyJname"]];
            if (beReplyJnameStr.length >0) {
                //  被回复的人
                remarkStr = agentbbsDict[@"beReplyJname"];
                CGRect beReplyJnameFrame = [remarkStr boundingRectWithSize:(CGSize){MAXFLOAT,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil];
                beReplyJnameFrame.origin.x = CGRectGetMaxX(truenameFrame) + 40;
                huifuContentX = CGRectGetMaxX(beReplyJnameFrame);
            }
            
            
            //  回复内容
            NSString *huifuContentStr = [[NSMutableString alloc] init];
            for (int i = 0; i < (int)(huifuContentX / 3.2); i++) {
                huifuContentStr = [huifuContentStr stringByAppendingString:@" "];
            }
            
            huifuContentStr = [huifuContentStr stringByAppendingString:@"："];
            huifuContentStr = [huifuContentStr stringByAppendingString:agentbbsDict[@"content"]];
            CGRect frame = [huifuContentStr boundingRectWithSize:(CGSize){remarkViewW,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil];
            
            
            remarkViewH += frame.size.height + 8;
        }
        
        if (number.intValue > 3){
            remarkViewH += 30;
        }
    }
    _remarkViewF = CGRectMake(remarkViewX, remarkViewY, remarkViewW, remarkViewH);
    
    
    //12.行高
    _cellH = CGRectGetMaxY(_remarkViewF);
}

@end
