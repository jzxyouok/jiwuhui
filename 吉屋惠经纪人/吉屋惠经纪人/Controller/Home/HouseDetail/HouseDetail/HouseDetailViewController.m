//
//  HouseDetailViewController.m
//  吉屋惠经纪人
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "HouseDetailViewController.h"

#import "HouseDetailHeaderView.h"

#import "HouseParameterCell.h"
#import "Price_AddressCell.h"
#import "countCus_yxCusNumberCell.h"

#import "CommissionRewardCell.h"
#import "CommissionRuleCell.h"
#import "CommissionCompanyCell.h"

#import "PreferentialCell.h"
#import "ScenePreferentialCell.h"

#import "MainHuxingCell.h"
#import "HuxingCell.h"

#import "HouseSellingPointCell.h"
#import "SalePointCell.h"

#import "TargetCustomersCell.h"
#import "TargetCustomersDetailCell.h"

#import "ExtensionGuestSkillCell.h"
#import "ExtensionGuestSkillDetailCell.h"

#import "JiwuSupportCell.h"
#import "JiwuSupportDetailCell.h"

#import "ProjectContactCell.h"


#import "HouseParameterViewController.h"
#import "HouseLocationViewController.h"

#import "CommisionRuleViewController.h"
#import "HuxingtuViewController.h"

@interface HouseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HouseDetailHeaderView *headerView;
@property (nonatomic, strong)NSMutableDictionary *homes;

@end

@implementation HouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [MBProgressHUD showMessage:nil toView:self.view];
    [self getHouseDetailData];
}

- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,k_w,k_h - 25} style:UITableViewStylePlain];
    self.headerView = [[HouseDetailHeaderView alloc] init];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,130}];
    self.tableView.tableFooterView.backgroundColor = kColor(238, 238, 238);
    
    //  底部视图
    UIView *bottomView = [[UIView alloc] initWithFrame:(CGRect){0,k_h - 54 - 64,k_w,54}];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //  底部视图分割线
    UIView *separator = [[UIView alloc] initWithFrame:(CGRect){0,0,k_w,1}];
    [bottomView addSubview:separator];
    separator.backgroundColor = kColor(0, 179, 90);
    
    //  楼盘动态按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 76, 54)];
    [bottomView addSubview:button];
    [button setTitle:@"楼盘动态" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
    UIImage *image1 = [UIImage imageNamed:@"housedetails_dongtai_icon"];
    [button setImage:image1 forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(54/2, -40, 0, image1.size.width - 40);
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 27, 54/2, 27);
    
    //  我的客户按钮
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(76, 0, 76, 54)];
    [bottomView addSubview:button1];
    [button1 setTitle:@"我的客户" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
    UIImage *image2 = [UIImage imageNamed:@"housedetails_client"];
    [button1 setImage:image2 forState:UIControlStateNormal];
    button1.titleEdgeInsets = UIEdgeInsetsMake(54/2, -40, 0, image2.size.width - 40);
    button1.imageEdgeInsets = UIEdgeInsetsMake(5, 27, 54/2, 27);
    
    
    //  报备客户
    UIButton *reportBtn = [[UIButton alloc] initWithFrame:CGRectMake(k_w - 100, 10, 90, 33)];
    [bottomView addSubview:reportBtn];
    reportBtn.backgroundColor = kColor(255, 136, 56);
    [reportBtn setTitle:@"报备客户" forState:UIControlStateNormal];
    reportBtn.layer.cornerRadius = 3;
    reportBtn.layer.masksToBounds = YES;
    
    [self setNavTitle:@"楼盘详情" image:nil];
    [self setNavRightBtnWithTitle:nil OrImage:@[@"navigation_share"]];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) return 3;
    if (section == 2 || section == 4 || section == 5 || section == 6 || section == 7) return 2;
    if (section == 3) {
        NSArray *fname = self.homes[@"fname"];
        if (fname.count == 0) return 0;
        if (fname.count > 2) return 4;
        return fname.count + 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 48;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        NSString *saleAddress = self.homes[@"saleAddress"];
        CGRect saleAddressLabelFrame = [saleAddress boundingRectWithSize:(CGSize){k_w - 100,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        return saleAddressLabelFrame.size.height + 48;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        return 40;
    }
    
    if (indexPath.section == 8) {
        return 54;
    }
    
    if (indexPath.row == 0) {
        return 37;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSString *yjgzStr = [NSString stringWithFormat:@"           %@",self.homes[@"yjgz"]];
        CGRect yjgzLabelFrame = [yjgzStr boundingRectWithSize:(CGSize){k_w - 45 - 20,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        return yjgzLabelFrame.size.height + 62;
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        return 70;
    }
    if (indexPath.section == 3) {
        return 90;
    }
    
    if (indexPath.section == 4 && indexPath.row == 1) {
        CGRect jgysLabelFrame = [self.homes[@"jgys"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect shptLabelFrame = [self.homes[@"shpt"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect xqptLabelFrame = [self.homes[@"xqpt"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect jtptLabelFrame = [self.homes[@"jtpt"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGFloat cellH = jgysLabelFrame.size.height + shptLabelFrame.size.height + xqptLabelFrame.size.height + jtptLabelFrame.size.height + 130;
        return cellH;
    }
    
    if (indexPath.section == 5 && indexPath.row == 1) {
        CGRect khnlLabelFrame = [self.homes[@"khnl"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect gfmdLabelFrame = [self.homes[@"gfmd"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect gfysLabelFrame = [self.homes[@"gfys"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect kfzyLabelFrame = [self.homes[@"kfzy"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect gzqyLabelFrame = [self.homes[@"gzqy"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect jzqyLabelFrame = [self.homes[@"jzqy"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGFloat cellH = khnlLabelFrame.size.height + gfmdLabelFrame.size.height + gfysLabelFrame.size.height + kfzyLabelFrame.size.height + gzqyLabelFrame.size.height + jzqyLabelFrame.size.height + 160;
        return cellH;
    }
    
    if (indexPath.section == 6 && indexPath.row == 1) {
        CGRect tkjqLabelFrame = [self.homes[@"tkjq"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGFloat cellH = tkjqLabelFrame.size.height + 50;
        return cellH;
    }
    
    if (indexPath.section == 7 && indexPath.row == 1) {
        CGRect tkjqLabelFrame = [self.homes[@"jwzc"] boundingRectWithSize:(CGSize){k_w - 30,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGFloat cellH = tkjqLabelFrame.size.height + 50;
        return cellH;
    }
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 0;
    if (section == 8) return 15;
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //  bname
    if (indexPath.section == 0 && indexPath.row == 0) {
        HouseParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [HouseParameterCell cellWithTableView:tableView];
            cell.bname = self.homes[@"bname"];
            cell.salestatusText = self.homes[@"salestatusText"];
        }
        
        return cell;
    }
    
    //  均价、地址
    if (indexPath.section == 0 && indexPath.row == 1) {
        Price_AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [Price_AddressCell cellWithTableView:tableView];
            cell.averagePrice = self.homes[@"averagePrice"];
            cell.saleAddress = self.homes[@"saleAddress"];
        }
        
        return cell;
    }
    
    //  合作经纪人、意向客户
    if (indexPath.section == 0 && indexPath.row == 2) {
        countCus_yxCusNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [countCus_yxCusNumberCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.countCus = [NSString stringWithFormat:@"%@",[self.homes valueForKey:@"countCus"]];
            cell.yxCusNumber = [NSString stringWithFormat:@"%@",[self.homes valueForKey:@"yxCusNumber"]];
        }
        
        return cell;
    }
    
    //  佣金奖励
    if (indexPath.section == 1 && indexPath.row == 0) {
        CommissionRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [CommissionRewardCell cellWithTableView:tableView];
        }
        
        return cell;
    }
    
    //  佣金、规则
    if (indexPath.section == 1 && indexPath.row == 1) {
        CommissionRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [CommissionRuleCell cellWithTableView:tableView];
            cell.fxsyj = self.homes[@"fxsyj"];
            cell.yjgz = self.homes[@"yjgz"];
        }
        
        return cell;
    }
    
    //  结佣公司
    if (indexPath.section == 1 && indexPath.row == 2) {
        CommissionCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [CommissionCompanyCell cellWithTableView:tableView];
            cell.jygs = self.homes[@"jyCompany"];
        }
        return cell;
    }
    
    //  优惠活动
    if (indexPath.section == 2 && indexPath.row == 0) {
        PreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [PreferentialCell cellWithTableView:tableView];
        }
        
        return cell;
    }
    
    //  现场优惠
    if (indexPath.section == 2 && indexPath.row == 1) {
        ScenePreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [ScenePreferentialCell cellWithTableView:tableView];
            cell.xcyh = self.homes[@"xcyh"];
        }
        
        return cell;
    }
    
    //  主力户型
    if (indexPath.section == 3 && indexPath.row == 0) {
        MainHuxingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [MainHuxingCell cellWithTableView:tableView];
            NSArray *fname = self.homes[@"fname"];
            cell.huxing = [NSString stringWithFormat:@"%ld",fname.count];
        }
        
        return cell;
    }
    
    //  户型
    if (indexPath.section == 3) {
        HuxingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [HuxingCell cellWithTableView:tableView];
            NSArray *fname = self.homes[@"fname"];
            NSDictionary *dict = [fname objectAtIndex:indexPath.row - 1];
            cell.path = dict[@"path"];
            cell.name = dict[@"name"];
            cell.area = dict[@"area"];
        }
        return cell;
    }
    
    //  楼盘卖点
    if (indexPath.section == 4 && indexPath.row == 0) {
        HouseSellingPointCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [HouseSellingPointCell cellWithTableView:tableView];
        }
        
        return cell;
    }
    
    //  楼盘详细卖点
    if (indexPath.section == 4 && indexPath.row == 1) {
        SalePointCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [SalePointCell cellWithTableView:tableView];
            cell.jgys = self.homes[@"jgys"];
            cell.shpt = self.homes[@"shpt"];
            cell.xqpt = self.homes[@"xqpt"];
            cell.jtpt = self.homes[@"jtpt"];
        }
        
        return cell;
    }
    
    //  目标客户
    if (indexPath.section == 5 && indexPath.row == 0) {
        TargetCustomersCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [TargetCustomersCell cellWithTableView:tableView];
        }
        
        return cell;
    }
    
    //  目标客户详细
    if (indexPath.section == 5 && indexPath.row == 1) {
        TargetCustomersDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [TargetCustomersDetailCell cellWithTableView:tableView];
            cell.khnl = self.homes[@"khnl"];
            cell.gfmd = self.homes[@"gfmd"];
            cell.gfys = self.homes[@"gfys"];
            cell.kfzy = self.homes[@"kfzy"];
            cell.gzqy = self.homes[@"gzqy"];
            cell.jzqy = self.homes[@"jzqy"];
        }
        
        return cell;
    }
    
    //  拓客技巧
    if (indexPath.section == 6 && indexPath.row == 0) {
        ExtensionGuestSkillCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [ExtensionGuestSkillCell cellWithTableView:tableView];
        }
        
        return cell;
    }
    
    //  拓客技巧详细
    if (indexPath.section == 6 && indexPath.row == 1) {
        ExtensionGuestSkillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [ExtensionGuestSkillDetailCell cellWithTableView:tableView];
            cell.tkjq = self.homes[@"tkjq"];
        }
        
        return cell;
    }
    
    //  吉屋支持
    if (indexPath.section == 7 && indexPath.row == 0) {
        JiwuSupportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [JiwuSupportCell cellWithTableView:tableView];
        }
        
        return cell;
    }
    
    //  拓客技巧详细
    if (indexPath.section == 7 && indexPath.row == 1) {
        JiwuSupportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [JiwuSupportDetailCell cellWithTableView:tableView];
            cell.jwzc = self.homes[@"jwzc"];
        }
        
        return cell;
    }
    
    //  服务专员
    if (indexPath.section == 8) {
        ProjectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [ProjectContactCell cellWithTableView:tableView];
            cell.projectContact = self.homes[@"projectContact"];
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //  楼盘参数
    if (indexPath.section == 0 && indexPath.row == 0) {
        HouseParameterViewController *houseParameterViewController = [[HouseParameterViewController alloc] init];
        [houseParameterViewController.parameters addObject:self.homes[@"bstime"]];
        [houseParameterViewController.parameters addObject:self.homes[@"bftime"]];
        [houseParameterViewController.parameters addObject:self.homes[@"designHouseNum"]];
        [houseParameterViewController.parameters addObject:self.homes[@"bulkPercentage"]];
        [houseParameterViewController.parameters addObject:self.homes[@"parkingNum"]];
        [houseParameterViewController.parameters addObject:self.homes[@"decoration"]];
        [houseParameterViewController.parameters addObject:self.homes[@"totalArea"]];
        [houseParameterViewController.parameters addObject:self.homes[@"buildArea"]];
        [houseParameterViewController.parameters addObject:self.homes[@"buildType"]];
        [houseParameterViewController.parameters addObject:self.homes[@"developer"]];
        [houseParameterViewController.parameters addObject:self.homes[@"pname"]];
        [houseParameterViewController.parameters addObject:self.homes[@"propertyType"]];
        [houseParameterViewController.parameters addObject:self.homes[@"pmprice"]];
        
        [self.navigationController pushViewController:houseParameterViewController animated:YES];
    }
    
    //  地图定位视图
    if (indexPath.section == 0 && indexPath.row == 1) {
        HouseLocationViewController *houseLocationViewController = [[HouseLocationViewController alloc] init];
        houseLocationViewController.latitude = self.homes[@"latitude"];
        houseLocationViewController.longitude = self.homes[@"longitude"];
        houseLocationViewController.annoTitle = self.homes[@"bname"];
        [self.navigationController pushViewController:houseLocationViewController animated:YES];
    }
    
    //  佣金奖励
    if (indexPath.section == 1) {
        CommisionRuleViewController *commisionRuleViewController = [[CommisionRuleViewController alloc] init];
        
        commisionRuleViewController.fxsyj = self.homes[@"fxsyj"];
        commisionRuleViewController.yjgz = self.homes[@"yjgz"];
        commisionRuleViewController.hzksrq = self.homes[@"hzksrq"];
        commisionRuleViewController.hzjsrq = self.homes[@"hzjsrq"];
        commisionRuleViewController.hzfy = self.homes[@"hzfy"];
        commisionRuleViewController.ksts = self.homes[@"ksts"];
        commisionRuleViewController.kpsj = self.homes[@"kpsj"];
        commisionRuleViewController.jygs = self.homes[@"jygs"];
        commisionRuleViewController.jyTime = self.homes[@"jyTime"];
        commisionRuleViewController.fxjl = self.homes[@"fxjl"];
        [self.navigationController pushViewController:commisionRuleViewController animated:YES];
    }
    
    //  户型控制器
    if (indexPath.section == 3) {
        HuxingtuViewController *huxingtuViewController = [[HuxingtuViewController alloc] init];
        huxingtuViewController.index = indexPath.row == 0 ? 0 : (int)indexPath.row - 1;
        huxingtuViewController.fname = self.homes[@"fname"];
        [self.navigationController pushViewController:huxingtuViewController animated:YES];
        
        [UIView animateWithDuration:0.7 animations:^{
            self.navigationController.navigationBar.alpha = 0;
        }completion:^(BOOL finished) {
            self.navigationController.navigationBar.hidden = YES;
        }];
    }
    
    if (indexPath.section == 8) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:self.homes[@"linkMantel"] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alertview show];
    }
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.homes[@"linkMantel"]]]];
    }
}

/**
 *  获取楼盘数据
 */
-(void)getHouseDetailData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"fid"] = self.fid;
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [mgr POST:khomeNewDetailUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            self.homes = dict[@"Homes"];
            self.headerView.path = self.homes[@"path"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    });
    
    
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self hideTabBar:YES];
}

//  隐藏TabBar
- (void) hideTabBar:(BOOL) hidden{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    MyTabBarViewController *tabBarViewController = (MyTabBarViewController *)self.tabBarController;
    if (hidden) {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h + 10, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    } else {
        [tabBarViewController.myTabBar setFrame:CGRectMake(tabBarViewController.myTabBar.frame.origin.x, k_h - 49, tabBarViewController.myTabBar.frame.size.width, tabBarViewController.myTabBar.frame.size.height)];
    }
    [UIView commitAnimations];
}

@end
