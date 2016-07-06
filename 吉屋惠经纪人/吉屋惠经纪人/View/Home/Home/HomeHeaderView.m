//
//  HeaderView.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()

@property (nonatomic, strong)UIScrollView *scrolView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;

@end


@implementation HomeHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,k_w,120}];
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"active_head_banner"];
        
        [self scrolView];
        self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(next) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        CGFloat maxBtnY = 0;
        for (int i = 0; i < 5; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * k_w / 5 + 5, 120, k_w/5, k_w/5)];
            [self addSubview:button];
            NSString *imageName = [NSString stringWithFormat:@"格子铺ico_%d_",i+1];
            button.tag = i;
            [button addTarget:self action:@selector(icoClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button setTitleColor:kColor(80, 80, 80) forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(70, -50, 0, 0);
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            
            switch (i) {
                case 0:
                    [button setTitle:@"消息盒子" forState:UIControlStateNormal];
                    break;
                case 1:
                    [button setTitle:@"钱包" forState:UIControlStateNormal];
                    break;
                case 2:
                    [button setTitle:@"积分商城" forState:UIControlStateNormal];
                    break;
                case 3:
                    [button setTitle:@"优选经纪" forState:UIControlStateNormal];
                    break;
                case 4:
                    [button setTitle:@"微店" forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            
            maxBtnY = CGRectGetMaxY(button.frame);
        }
        
        self.frame = CGRectMake(0, 0, k_w, maxBtnY + 25);
        
        //  分割线
        UIView *separationline = [[UIView alloc] initWithFrame:(CGRect){0, CGRectGetMaxY(self.frame) - 10, k_w, 10}];
        separationline.backgroundColor = kColor(230, 230, 230);
        [self addSubview:separationline];
    }
    return self;
}

/**
 *  懒加载scrolView
 *
 *  @return _scrolView
 */
-(UIScrollView *)scrolView{
    if (_scrolView == nil) {
        CGFloat scrollViewW = k_w;
        CGFloat scrollViewH = 120;
        _scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake((k_w - scrollViewW) / 2, 0, scrollViewW, scrollViewH)];
        [self addSubview:_scrolView];
        
        _scrolView.pagingEnabled = YES;
        _scrolView.showsHorizontalScrollIndicator = NO;
        _scrolView.showsVerticalScrollIndicator = NO;
        
        _scrolView.delegate = self;
        [self pageControl];
    }
    return _scrolView;
}

/**
 *  懒加载pageControl
 *
 *  @return _pageControl
 */
-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:(CGRect){0,0,100,30}];
        [self addSubview:_pageControl];
        _pageControl.center = CGPointMake(0, 120 - 12);
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    }
    return _pageControl;
}

#pragma mark - scrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = _scrolView.contentOffset.x / _scrolView.bounds.size.width;
    if(page == _poster.count + 1){
        _scrolView.contentOffset = CGPointMake(_scrolView.bounds.size.width, 0);
        _pageControl.currentPage = 0;
    }
    else if (page == 0) {
        _scrolView.contentOffset = CGPointMake(_scrolView.bounds.size.width * _poster.count, 0);
        _pageControl.currentPage = _poster.count - 1;
    }else
        _pageControl.currentPage = page-1;
    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  下一张广告图片
 */
-(void)next{
    [UIView animateWithDuration:0.5 animations:^{
        _scrolView.contentOffset = CGPointMake(_scrolView.contentOffset.x + k_w, 0);
    }];
    int page = _scrolView.contentOffset.x / _scrolView.bounds.size.width;
    if(page == _poster.count + 1){
        _scrolView.contentOffset = CGPointMake(_scrolView.bounds.size.width, 0);
        _pageControl.currentPage = 0;
    }
    else if (page == 0) {
        _scrolView.contentOffset = CGPointMake(_scrolView.bounds.size.width * _poster.count, 0);
        _pageControl.currentPage = _poster.count - 1;
    }else
        _pageControl.currentPage = page-1;
}

/**
 *  获得广告数据
 *
 *  @param poster
 */
-(void)setPoster:(NSMutableArray *)poster{
    _poster = poster;
    _pageControl.numberOfPages = poster.count;
    
    CGFloat scrollViewW = k_w;
    CGFloat scrollViewH = 120;
    _scrolView.contentSize = CGSizeMake((poster.count + 2) * scrollViewW, scrollViewH);
    _scrolView.contentOffset = CGPointMake(scrollViewW, 0);
    
    
    for (int i = 0; i < poster.count + 2; i++) {
        NSDictionary *dict = [poster objectAtIndex:(i + poster.count - 1) % poster.count];
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"indexBanner"]] placeholderImage:[UIImage imageNamed:@"active_head_banner"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH)];
            [_scrolView addSubview:button];
            button.tag = (i + poster.count - 1) % poster.count;
            [button addTarget:self action:@selector(posterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:imageView.image forState:UIControlStateNormal];
        }];
    }
}

//  点击广告按钮
- (void)posterButtonClick:(UIButton *)button{
    NSDictionary *dict = [self.poster objectAtIndex:button.tag];
    
    if ([self.delegate respondsToSelector:@selector(homeHeaderViewPosterClick:)]) {
        [self.delegate homeHeaderViewPosterClick:[NSURLRequest requestWithURL:[NSURL URLWithString:dict[@"bannerUrl"]]]];
    }
}

- (void)icoClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(homeHeaderViewIconClick:)]) {
        [self.delegate homeHeaderViewIconClick:button.tag];
    }
}

@end