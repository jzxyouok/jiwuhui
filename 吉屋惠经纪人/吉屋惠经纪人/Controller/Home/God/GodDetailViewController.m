//
//  GodDetailViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/11.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "GodDetailViewController.h"

@interface GodDetailViewController ()

@property (nonatomic, weak)UILabel *priceRemarkLabel;
@property (nonatomic, weak)UILabel *bnameLabel;
@property (nonatomic, assign) int houseIndex;

@end

@implementation GodDetailViewController- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //  背景图片
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 91}];
        backgroundImage.image = [UIImage imageNamed:@"solution_720"];
        [self.view addSubview:backgroundImage];
        
        //  返回按钮
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 22, 20, 20)];
        [self.view addSubview:backBtn];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
        
        //  封建迷信的内容（请勿相信）
        CGFloat scrollViewW = k_w - k_w * 0.2;
        CGFloat scrollViewH = (k_h - 91) * 0.5;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){k_w * 0.1,(k_h - 91) * 0.38,scrollViewW,scrollViewH}];
        [self.view addSubview:scrollView];
        scrollView.showsVerticalScrollIndicator = NO;
        
        //  签等级
        NSArray *signArray = @[@"上上签",@"上签",@"中签",@"下签",@"下下签"];
        UILabel *signLabel = [[UILabel alloc] initWithFrame:(CGRect){0,0,scrollViewW,21}];
        int i = arc4random_uniform((int)signArray.count);
        signLabel.text = [signArray objectAtIndex:i];
        signLabel.font = [UIFont systemFontOfSize:19];
        signLabel.textColor = kColor(255, 93, 10);
        signLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:signLabel];
        
        //  【今日财运】标题
        UILabel *fortuneLabel = [[UILabel alloc] initWithFrame:(CGRect){0,31,scrollViewW,21}];
        fortuneLabel.text = @"【今日财运】";
        fortuneLabel.font = [UIFont systemFontOfSize:16];
        fortuneLabel.textColor = kColor(255, 93, 10);
        [scrollView addSubview:fortuneLabel];
        
        //  【今日财运】内容
        NSArray *fortuneArray = @[@"今日赚钱不费力，宜带看，巧用智慧很容易成交！今日报备质量高，成交率高",@"今日报备易得到一些小利！不过，切勿贪心，见好就收，不然小财很容易散去！",@"今日财运平平！但若能果断报备/约客看房，细心跟进，会有不错的收益！",@"财气呈现混乱迹象，虽然很想开单，但客户问题多多，容易被客户发鸽子，今日做好客户关系维护，今日只能做报备/约看，不宜带看",@"今日财运不行，报备带看就有可能失败，今天的小人也很厉害，所以要小心谨慎，否则有血光之灾"];
        UILabel *fortuneContentLabel = [[UILabel alloc] init];
        CGRect fortuneFrame = [[fortuneArray objectAtIndex:i] boundingRectWithSize:(CGSize){scrollViewW,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        fortuneFrame.origin.y = 55;
        fortuneContentLabel.frame = fortuneFrame;
        
        fortuneContentLabel.text = [fortuneArray objectAtIndex:i];
        fortuneContentLabel.font = [UIFont systemFontOfSize:14];
        fortuneContentLabel.textColor = kColor(0, 0, 0);
        fortuneContentLabel.numberOfLines = 0;
        [scrollView addSubview:fortuneContentLabel];
        
        //  【今日财位】标题
        UILabel *directionLabel = [[UILabel alloc] initWithFrame:(CGRect){0,CGRectGetMaxY(fortuneContentLabel.frame) + 10,scrollViewW,21}];
        directionLabel.text = @"【今日财位】";
        directionLabel.font = [UIFont systemFontOfSize:16];
        directionLabel.textColor = kColor(255, 93, 10);
        [scrollView addSubview:directionLabel];
        
        //  【今日财位】内容
        NSArray *directionArray = @[@"正东",@"正南",@"正西",@"正北",@"东南",@"东北",@"西南",@"西北"];
        UILabel *directionContentLabel = [[UILabel alloc] init];
        CGRect directionFrame = [[directionArray objectAtIndex:arc4random_uniform((int)directionArray.count)] boundingRectWithSize:(CGSize){scrollViewW,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        directionFrame.origin.y = CGRectGetMaxY(directionLabel.frame) + 5;
        directionContentLabel.frame = directionFrame;
        
        directionContentLabel.text = [directionArray objectAtIndex:arc4random_uniform((int)directionArray.count)];
        directionContentLabel.font = [UIFont systemFontOfSize:14];
        directionContentLabel.textColor = kColor(0, 0, 0);
        directionContentLabel.numberOfLines = 0;
        [scrollView addSubview:directionContentLabel];
        
        //  【宜】标题
        UILabel * fittingLabel = [[UILabel alloc] initWithFrame:(CGRect){0,CGRectGetMaxY(directionContentLabel.frame) + 10,scrollViewW,21}];
        fittingLabel.text = @"【宜】";
        fittingLabel.font = [UIFont systemFontOfSize:16];
        fittingLabel.textColor = kColor(255, 93, 10);
        [scrollView addSubview: fittingLabel];
        
        //  【宜】内容
        NSArray * fittingArray = @[@"收定",@"报备",@"带看",@"约看",@"发盘源",@"刷新",@"发房源",@"让利",@"合作",@"会友",@"发网盘",@"博彩",@"房源刷新",@"签约",@"放贷"];
        NSString *fittingStr = [[NSString alloc] init];
        for (int i = 0; i < 5; i++) {
            NSString *tempStr = [fittingArray objectAtIndex:arc4random_uniform((int)fittingArray.count)];
            if (![fittingStr containsString:tempStr]) {
                if (i != 0) {
                    fittingStr = [fittingStr stringByAppendingString:[NSString stringWithFormat:@"、%@",tempStr]];
                }else{
                    fittingStr = [fittingStr stringByAppendingString:[NSString stringWithFormat:@"%@",tempStr]];
                }
            }
        }
        
        UILabel * fittingContentLabel = [[UILabel alloc] init];
        CGRect  fittingFrame = [fittingStr boundingRectWithSize:(CGSize){scrollViewW,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        fittingFrame.origin.y = CGRectGetMaxY( fittingLabel.frame) + 5;
        
        fittingContentLabel.frame =  fittingFrame;
        fittingContentLabel.text = fittingStr;
        fittingContentLabel.font = [UIFont systemFontOfSize:14];
        fittingContentLabel.textColor = kColor(0, 0, 0);
        fittingContentLabel.numberOfLines = 0;
        [scrollView addSubview: fittingContentLabel];
        
        //  【忌】标题
        UILabel * avoidLabel = [[UILabel alloc] initWithFrame:(CGRect){0,CGRectGetMaxY(fittingContentLabel.frame) + 10,scrollViewW,21}];
        avoidLabel.text = @"【忌】";
        avoidLabel.font = [UIFont systemFontOfSize:16];
        avoidLabel.textColor = kColor(255, 93, 10);
        [scrollView addSubview: avoidLabel];
        
        //  【忌】内容
        NSArray * avoidArray = @[@"收定",@"报备",@"带看",@"约看",@"发盘源",@"刷新",@"发房源",@"让利",@"合作",@"会友",@"发网盘",@"博彩",@"房源刷新",@"签约",@"放贷",@"洗客（多小人）",@"罚款",@"讨债",@"贪心",@"谋利",@"欺骗",@"风险投资"];
        NSString *avoidStr = [[NSString alloc] init];
        
        BOOL flag = YES;
        for (int i = 0; i < 5; i++) {
            NSString *tempStr = [avoidArray objectAtIndex:arc4random_uniform((int)avoidArray.count)];
            if (![avoidStr containsString:tempStr] && ![fittingStr containsString:tempStr]) {
                if (flag == YES) {
                    avoidStr = [avoidStr stringByAppendingString:[NSString stringWithFormat:@"%@",tempStr]];
                    flag = NO;
                }else{
                    avoidStr = [avoidStr stringByAppendingString:[NSString stringWithFormat:@"、%@",tempStr]];
                }
            }
        }
        
        UILabel * avoidContentLabel = [[UILabel alloc] init];
        CGRect  avoidFrame = [avoidStr boundingRectWithSize:(CGSize){scrollViewW,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        avoidFrame.origin.y = CGRectGetMaxY( avoidLabel.frame) + 5;
        
        avoidContentLabel.frame =  avoidFrame;
        avoidContentLabel.text = avoidStr;
        avoidContentLabel.font = [UIFont systemFontOfSize:14];
        avoidContentLabel.textColor = kColor(0, 0, 0);
        avoidContentLabel.numberOfLines = 0;
        [scrollView addSubview: avoidContentLabel];
        
        //  设置scrollView内容大小
        scrollView.contentSize = CGSizeMake(k_w - k_w * 0.2, CGRectGetMaxY(avoidContentLabel.frame) + 20);
        
        
        //  底部视图
        UIButton *bottomView = [[UIButton alloc] initWithFrame:CGRectMake(0, k_h - 91, k_w, 91)];
        [self.view addSubview:bottomView];
        [bottomView addTarget:self action:@selector(houseDetail) forControlEvents:UIControlEventTouchUpInside];
        bottomView.backgroundColor = [UIColor whiteColor];
        
        //  底部视图分割线
        UIView *separator = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,1}];
        [bottomView addSubview:separator];
        separator.backgroundColor = kColor(253, 220, 202);
        
        //  底部左边图标
        UIImageView *ImageView1 = [[UIImageView alloc] initWithFrame:(CGRect){0,14,155,35}];
        ImageView1.image = [UIImage imageNamed:@"small_bg_720"];
        [bottomView addSubview:ImageView1];
        
        //  今日宜成交楼盘标签
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){2,21,k_w,21}];
        label.text = @"今日宜成交楼盘";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        [bottomView addSubview:label];
        
        //  楼盘标签
        UILabel *bnameLabel = [[UILabel alloc] initWithFrame:(CGRect){20,58,k_w,21}];
        bnameLabel.font = [UIFont systemFontOfSize:16];
        bnameLabel.textColor = [UIColor blackColor];
        [bottomView addSubview:bnameLabel];
        bnameLabel.text = @"暂无数据";
        self.bnameLabel = bnameLabel;
        
        //  价格标签
        UILabel *priceRemarkLabel = [[UILabel alloc] init];
        self.priceRemarkLabel = priceRemarkLabel;
        priceRemarkLabel.font = [UIFont systemFontOfSize:15];
        priceRemarkLabel.textColor = kColor(255, 93, 10);
        [bottomView addSubview:priceRemarkLabel];
        
        //  箭头图标
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){k_w - 28,37,8,15}];
        imageView.image = [UIImage imageNamed:@"arrow"];
        [bottomView addSubview:imageView];
    }
    return self;
}

- (void)setHomes:(NSMutableArray *)homes{
    if (homes.count == 0) return;
    _homes = homes;
    self.houseIndex = arc4random_uniform((int)homes.count);
    NSDictionary *dict = [homes objectAtIndex:self.houseIndex];
    
    //  设置楼盘地址标签内容
    self.bnameLabel.text = dict[@"bname"];
    
    //  设置价格标签位置和内容
    CGRect labelFrame = [dict[@"priceRemark"] boundingRectWithSize:(CGSize){MAXFLOAT,21} options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    labelFrame.origin.x = k_w - labelFrame.size.width - 33;
    labelFrame.origin.y = 35;
    self.priceRemarkLabel.frame = labelFrame;
    self.priceRemarkLabel.text = dict[@"priceRemark"];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)houseDetail{
    if (self.homes.count == 0) return;
    
    NSDictionary *dict = [self.homes objectAtIndex:self.houseIndex];
    if ([self.delegate respondsToSelector:@selector(godDetailViewControllerButtonClick:)]) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self.delegate godDetailViewControllerButtonClick:dict[@"fid"]];
        }];
    }
}

@end
