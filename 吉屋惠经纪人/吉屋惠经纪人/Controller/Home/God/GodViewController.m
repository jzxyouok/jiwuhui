//
//  GodViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/6/11.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "GodViewController.h"
#import "GodDetailViewController.h"

@interface GodViewController ()<GodDetailViewControllerDelegate>

@property (nonatomic, weak)UIImageView *shakingImageView;

@end

@implementation GodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (void)setupView{
    //  背景图片
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundImage.image = [UIImage imageNamed:@"bg_720"];
    [self.view addSubview:backgroundImage];
    
    //  返回按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 22, 20, 20)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    
    //  财神爷
    UIImageView *godImageView = [[UIImageView alloc] initWithFrame:(CGRect){(k_w - 170) / 2,k_h * 0.2,170,200}];
    [self.view addSubview:godImageView];
    
    NSArray *imageName = @[@"master_up_720",@"master_in_720",@"master_down_720"];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:imageName[i]];
        [images addObject:image];
    }
    
    godImageView.animationImages = images;
    godImageView.animationDuration = 1;
    godImageView.animationRepeatCount = 0;
    [godImageView startAnimating];
    
    //  竹签桶
    UIImageView *shakingImageView = [[UIImageView alloc] initWithFrame:(CGRect){0,k_h * 0.66,k_w,k_h * 0.34}];
    shakingImageView.image = [UIImage imageNamed:@"shaking_default_720"];
    [self.view addSubview:shakingImageView];
    self.shakingImageView = shakingImageView;
    
    NSArray *imageName1 = @[@"shaking_2_720",@"shaking_1_720",@"shaking_2_720",@"shaking_1_720",@"shaking_2_720",@"shaking_3_720"];
    NSMutableArray *images1 = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        UIImage *image1 = [UIImage imageNamed:imageName1[i]];
        [images1 addObject:image1];
    }
    
    shakingImageView.animationImages = images1;
    shakingImageView.animationDuration = 1;
    shakingImageView.animationRepeatCount = 0;
    shakingImageView.animationRepeatCount = 1;
    
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    //检测到摇动
    [self.shakingImageView startAnimating];
    [UIView animateWithDuration:1 animations:^{
        
    }completion:^(BOOL finished) {//  竹签桶
        UIImageView *crabstickImageView = [[UIImageView alloc] initWithFrame:(CGRect){k_w / 2 - 150,k_h * 0.6,12,100}];
        crabstickImageView.image = [UIImage imageNamed:@"prod_720"];
        [self.view addSubview:crabstickImageView];
        crabstickImageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        crabstickImageView.alpha = 0;
        
        [UIView animateWithDuration:2 animations:^{
            crabstickImageView.alpha = 1;
            crabstickImageView.transform = CGAffineTransformMakeRotation(0);
            crabstickImageView.transform = CGAffineTransformTranslate(crabstickImageView.transform, 150, -100);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                crabstickImageView.transform = CGAffineTransformTranslate(crabstickImageView.transform, 0, 50);
                crabstickImageView.alpha = 0;
                GodDetailViewController *godDetailViewController = [[GodDetailViewController alloc] init];
                godDetailViewController.delegate = self;
                godDetailViewController.homes = self.homes;
                [self presentViewController:godDetailViewController animated:YES completion:nil];
            }];
        }];
    }];
}

/**
 *  点击底部按钮
 *
 *  @param fid 楼盘的ID
 */
-(void)godDetailViewControllerButtonClick:(NSString *)fid{
    if ([self.delegate respondsToSelector:@selector(godDetailViewControllerFinishChoose:)]) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self.delegate godDetailViewControllerFinishChoose:fid];
        }];
    }
}

@end
