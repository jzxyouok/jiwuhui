//
//  HuxingtuViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HuxingtuViewController.h"

@interface HuxingtuViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong)UIScrollView *scrolView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *remarkLabel;
@property (nonatomic, strong)UIImageView *imageview;
@property (nonatomic, weak)UIView *huxingBackgroundView;

@property CGFloat scale;

@end

@implementation HuxingtuViewController

//  顶部视图
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,64}];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.userInteractionEnabled = YES;
        [self.view addSubview:_topView];
        
        //  返回按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
        [_topView addSubview:button];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"icon_arrow_before"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 78);
        
        //  标题
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,20,k_w,44}];
        label.text = @"户型图";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:label];
    }
    return _topView;
}

//  底部视图
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:(CGRect){0,k_h - 150,k_w,150}];
        _bottomView.backgroundColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:0.8];
        _topView.userInteractionEnabled = YES;
        [self.view addSubview:_bottomView];
        
        //  上下移动视图的按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, k_w, 44)];
        [button addTarget:self action:@selector(moveBottomView) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
        
        //  小图标
        self.imageview = [[UIImageView alloc] initWithFrame:(CGRect){k_w - 30,20,10,10}];
        self.imageview.image = [UIImage imageNamed:@"icon_arrow_down"];
        [self.bottomView addSubview:self.imageview];
        
        //  name标签
        self.nameLabel = [[UILabel alloc] initWithFrame:(CGRect){10,15,k_w,21}];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:self.nameLabel];
        
        //  remark标签
        self.remarkLabel = [[UILabel alloc] initWithFrame:(CGRect){10,44,k_w,21}];
        self.remarkLabel.font = [UIFont systemFontOfSize:12];
        self.remarkLabel.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:self.remarkLabel];
    }
    return _bottomView;
}

//  图片索引标签
-(UILabel *)indexLabel{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:(CGRect){k_w - 50,20,50,44}];
        _indexLabel.font = [UIFont systemFontOfSize:14];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:_indexLabel];
    }
    return _indexLabel;
}

//  滚动视图
-(UIScrollView *)scrolView{
    if (_scrolView == nil) {
        _scrolView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_scrolView];
        
        _scrolView.pagingEnabled = YES;
        _scrolView.showsHorizontalScrollIndicator = NO;
        _scrolView.showsVerticalScrollIndicator = NO;
        
        _scrolView.delegate = self;
    }
    return _scrolView;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageview.transform = CGAffineTransformMakeRotation(M_PI);
        CGRect frame = self.bottomView.frame;
        frame.origin.y = k_h - 44;
        self.bottomView.frame = frame;
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrolView != scrollView) return;
        
    int page = _scrolView.contentOffset.x / _scrolView.bounds.size.width;
    self.indexLabel.text = [NSString stringWithFormat:@"%d/%ld",page + 1,_fname.count];
    NSDictionary *dict = [self.fname objectAtIndex:page];
    self.nameLabel.text = dict[@"name"];
    self.remarkLabel.text = dict[@"remark"];
    
    UIScrollView *scrollView1 = scrollView.subviews[page];
    self.huxingBackgroundView = scrollView1.subviews[0];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView == self.scrolView) {
        return nil;
    }
    return self.huxingBackgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

//  初始化视图
- (void)setupView{
    self.view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    [self scrolView];
    [self bottomView];
}

//  点击后隐藏显示topView和bottomView
- (void)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.topView.alpha = 1 - self.topView.alpha;
        self.bottomView.alpha = 1 - self.bottomView.alpha;
    }];
}

//  返回上一个视图
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//  上下移动bottomView
- (void)moveBottomView{
    NSLog(@"move");
    [UIView animateWithDuration:0.5 animations:^{
        self.imageview.transform = CGAffineTransformRotate(self.imageview.transform, M_PI);
        CGRect frame = self.bottomView.frame;
        frame.origin.y = frame.origin.y == k_h - 44 ? k_h - frame.size.height : k_h - 44;
        self.bottomView.frame = frame;
    }];
}

//  显示导航栏
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.hidden = NO;
}


-(void)setFname:(NSMutableArray *)fname{
    _fname = fname;
    
    NSDictionary *dict = [fname objectAtIndex:self.index];
    
    //  设置右上角图片索引标签内容
    self.indexLabel.text = [NSString stringWithFormat:@"%d/%ld",self.index + 1,_fname.count];
    
    //  设置户型名字标签
    self.nameLabel.text = dict[@"name"];
    
    //  设置户型remark标签
    self.remarkLabel.text = dict[@"remark"];
    
    CGFloat scrollViewW = k_w;
    CGFloat scrollViewH = 206;
    self.scrolView.contentSize = CGSizeMake((fname.count) * scrollViewW, scrollViewH);
    self.scrolView.contentOffset = CGPointMake(scrollViewW * self.index, 0);
    
    for (int i = 0; i < fname.count ; i++) {
        NSDictionary *dict = [fname objectAtIndex:i];
        
        //  大滚动视图里面放小的滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(k_w * i, 0, k_w, k_h)];
        scrollView.contentSize = CGSizeMake(k_w, k_h);
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 2;
        scrollView.minimumZoomScale = 1;
        [self.scrolView addSubview:scrollView];
        
        //  小滚动视图里面放一个背景视图
        UIView *huxingBackgroundView = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,k_h}];
        huxingBackgroundView.backgroundColor = [UIColor blackColor];
        [scrollView addSubview:huxingBackgroundView];
        
        //  显示图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (k_h - scrollViewH) / 2 - 15, scrollViewW, scrollViewH)];
        if (i == self.index) {
            self.huxingBackgroundView = huxingBackgroundView;
        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"path"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //  在背景视图添加ImageView
            [huxingBackgroundView addSubview:imageView];
        }];
    }
}

@end
