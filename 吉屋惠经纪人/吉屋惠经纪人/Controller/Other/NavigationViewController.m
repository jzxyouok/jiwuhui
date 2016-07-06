//
//  NavigationViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  设置titleView
 *
 *  @param title     标题
 *  @param imageName 图标
 */
-(void)setNavTitle:(NSString *)title image:(NSString *)imageName{
    if (title) {
        CGRect titleFrame = [title boundingRectWithSize:(CGSize){MAXFLOAT,44} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleFrame.size.width + 75, 44)];
        [button addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        
        if (imageName){
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
            button.imageEdgeInsets = UIEdgeInsetsMake(20, titleFrame.size.width + 75 - 25, 18, 15);
        }
        self.navigationItem.titleView = button;
    }
}

/**
 *  设置leftBarButtonItems
 *
 *  @param titles 文字
 *  @param images 图片
 */
-(void)setNavLeftBtnWithTitle:(NSArray *)titles OrImage:(NSArray *)images{
    int i = 0;
    if (titles) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *title in titles) {
            CGRect titleFrame = [title boundingRectWithSize:(CGSize){MAXFLOAT,44} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            UIButton *btn = [[UIButton alloc] initWithFrame:titleFrame];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.tag = i++;
            [btn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
            [arr addObject:barBtn];
            [btn setTitleColor:kColor(255, 255, 255) forState:UIControlStateNormal];
            [btn setTitleColor:kColor(0, 179, 90) forState:UIControlStateHighlighted];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        self.navigationItem.leftBarButtonItems = arr;
    }
    
    if(images){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *imagename in images) {
            UIImage *image = [UIImage imageNamed:imagename];
            UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){0,0,20,20}];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = i++;
            [btn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
            [arr addObject:barBtn];
        }
        self.navigationItem.leftBarButtonItems = arr;
    }
    
    
}

/**
 *  设置rightBarButtonItems
 *
 *  @param titles 文字
 *  @param images 图片
 */
-(void)setNavRightBtnWithTitle:(NSArray *)titles OrImage:(NSArray *)images{
    int i = 0;
    if (titles) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *title in titles) {
            CGRect titleFrame = [title boundingRectWithSize:(CGSize){MAXFLOAT,44} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            UIButton *btn = [[UIButton alloc] initWithFrame:titleFrame];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.tag = i++;
            [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
            [arr addObject:barBtn];
            [btn setTitleColor:kColor(255, 255, 255) forState:UIControlStateNormal];
            [btn setTitleColor:kColor(0, 179, 90) forState:UIControlStateHighlighted];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        self.navigationItem.rightBarButtonItems = arr;
    }
    
    if(images){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *imagename in images) {
            UIImage *image = [UIImage imageNamed:imagename];
            UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){0,0,20,20}];
            [btn setImage:image forState:UIControlStateNormal];
            
            btn.tag = i++;
            [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
            [arr addObject:barBtn];
        }
        self.navigationItem.rightBarButtonItems = arr;
    }
    
    
}

-(void)leftBtnClick{
    
}

-(void)rightBtnClick{
    
}

- (void)titleBtnClick{
    
}

@end
