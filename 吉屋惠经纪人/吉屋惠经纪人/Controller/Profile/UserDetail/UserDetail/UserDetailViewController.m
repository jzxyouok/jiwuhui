//
//  UserDetailViewController.m
//  吉屋惠经纪人
//
//  Created by zhangtao on 16/7/1.
//  Copyright © 2016年 zhangtao. All rights reserved.
//

#import "UserDetailViewController.h"
#import "MyActionSheet.h"
#import "DistrictNameViewController.h"

#define FileBoundary @"zhangtao"
#define NewLine @"\r\n"
#define Encode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface UserDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong)UITableView *tableView;    //  表视图
@property (nonatomic, strong)NSArray *array;            //  存放cell.textLabel.text数据
@property (nonatomic, weak)UIImageView *imageview;      //  头像
@property (nonatomic, copy) NSString *districtId;       //  区域ID
@property (nonatomic, copy) NSString *districtName;     //  区域名称
@property (nonatomic, copy) NSString *grade;            //  行业经验
@property (nonatomic, copy) NSString *personPath;       //  头像路径
@property (nonatomic, copy) NSString *cityName;         //  城市名
@property (nonatomic, copy) NSString *dtid;             //  城市ID
@property (nonatomic, strong) AgentModel *agentModel;   //  用户数据模型

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self getUserData];
}

/**
 *  创建视图
 */
- (void)setupView{
    //  初始化表视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, k_w, k_h - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kColor(238, 238, 238);
    self.view.backgroundColor = [UIColor whiteColor];
    
    //  设置导航栏数据
    [self setNavTitle:@"设置" image:nil];
    [self setNavLeftBtnWithTitle:nil OrImage:@[@"navigation_back"]];
    [self setNavRightBtnWithTitle:@[@"完成"] OrImage:nil];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    self.array = @[@"头        像",@"真实姓名",@"手机号码",@"所在城市",@"积        分",@"负责区域",@"公司认证",@"个人认证",@"行业经验"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardLocationChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  键盘位置发生变化，改变tableview坐标
 *
 *  @param noti
 */
- (void)keyboardLocationChange:(NSNotification *)noti{
    CGRect kbFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.tableView.frame;
    frame.origin.y = kbFrame.origin.y - k_h;
    
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.tableView.frame = frame;
    }];
}

/**
 *  滚动tableview结束编辑
 *
 *  @param scrollView 
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 5;
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) return 15;
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) return 88;
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    //  设置cell左边的数据
    cell.textLabel.text = [self.array objectAtIndex:indexPath.section * 5 + indexPath.row ];
    cell.textLabel.alpha = 0.8;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    //  设置cell的accessoryType和selectionStyle
    if (!(indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3))){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //  设置cell右边的数据
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //  初始化头像
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:(CGRect){ k_w - 68 - 35, 10, 68, 68}];
            [cell.contentView addSubview:imageview];
            imageview.layer.cornerRadius = imageview.frame.size.width / 2;
            imageview.layer.masksToBounds = YES;
            self.imageview = imageview;
            
            //  如果头像有数据
            NSString *personPath = self.agentModel.personPath;
            if (personPath.length == 0) {
                imageview.image = [UIImage imageNamed:@"讨论-默认头像"];
                cell.detailTextLabel.text = @"未认证                    .";
                
            //  如果头像没有数据，则显示默认头像
            }else{
                [imageview sd_setImageWithURL:[NSURL URLWithString:personPath] placeholderImage:[UIImage imageNamed:@"讨论-默认头像"]];
                cell.detailTextLabel.text = @"已认证                    .";
            }
        }else if (indexPath.row == 1){
            cell.detailTextLabel.text = self.agentModel.turename;     //  真实姓名
        }else if (indexPath.row == 2){
            cell.detailTextLabel.text = self.agentModel.mobile;       //  手机号码
        }else if (indexPath.row == 3){
            cell.detailTextLabel.text = self.agentModel.cityName;     //  所在城市
        }else if (indexPath.row == 4){
           cell.detailTextLabel.text = self.agentModel.integral;      //  积分
        }
    }else{
        if (indexPath.row == 0) {
           cell.detailTextLabel.text = self.agentModel.districtName;               //  负责区域
        }else if (indexPath.row == 1){
            //  判断是否认证公司
            if ([self.agentModel.companryInfoStatus.stringValue isEqualToString:@"0"]) {
                cell.detailTextLabel.text = @"未认证";
            }else{
                cell.detailTextLabel.text = @"已认证";
            }
        }else if (indexPath.row == 2){
            //  判断是否认证个人信息
            if ([self.agentModel.idcardNumberStatus.stringValue isEqualToString:@"0"]) {
                cell.detailTextLabel.text = @"未认证";
            }else{
                cell.detailTextLabel.text = @"已认证";
            }
        }else if (indexPath.row == 3){
            UITextField *textField = [[UITextField alloc] initWithFrame:(CGRect){0, 0, k_w - 35, 44}];
            [cell.contentView addSubview:textField];
            textField.text = self.agentModel.grade;                    //  行业经验
            textField.textAlignment = NSTextAlignmentRight;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.font = [UIFont systemFontOfSize:15];
            textField.alpha = 0.5;
            textField.delegate = self;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self pickeImage];          //  选取照片
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){
            
        }else if (indexPath.row == 4){
            
        }
    }else{
        if (indexPath.row == 0) {
            DistrictNameViewController *districtNameViewController = [[DistrictNameViewController alloc] init];
            districtNameViewController.cityName = self.cityName;
            districtNameViewController.dtid = self.dtid;
            districtNameViewController.finishChoose = ^(NSString *districtName){
                self.agentModel.districtName = districtName;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            };
            [self.navigationController pushViewController:districtNameViewController animated:YES];
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){
            
        }
    }
}

/**
 *  选取头像照片
 */
- (void)pickeImage{
    [MyActionSheet ShowActionSheetWithTitles:@[@"拍照",@"选择照片"] finishChoose:^(NSInteger tag) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.view.backgroundColor = kColor(0, 179, 90);
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        
        if (tag == 1) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }else if (tag == 2){
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
    }];
}

#pragma makr - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.agentModel.grade = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.imageview.image = info[@"UIImagePickerControllerEditedImage"];
    self.personPath = @"";
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  获取用户数据
 */
-(void)getUserData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"deviceNumber"] = @"CDED4FEEFBF04B9780464FA4BF7C0C27";
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    [mgr POST:kuserDetailUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSNumber *result = dict[@"result"];
        NSDictionary *dict1 = dict[@"Agent"];
        NNLog(@"%@",dict1);
        
        if ([result.stringValue isEqualToString:@"0"]) {
            self.agentModel = [[AgentModel alloc] initWithDict:dict[@"Agent"]];
            NNLog(@"%@",self.agentModel.personPath);
            
            self.districtId = self.agentModel.DistrictID.stringValue;
            self.districtName = self.agentModel.districtName;
            
            self.grade = self.agentModel.grade;
            self.personPath = self.agentModel.personPath;
            self.cityName = self.agentModel.cityName;
            self.dtid = self.agentModel.cityId.stringValue;
            
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
            
            //  如果result值为-2，说明账号已经在其他设备登录，要重新登录
        }else if ([result.stringValue isEqualToString:@"-2"]){
            NoDataView *noDataView = [[NoDataView alloc] initWithFrame:[UIScreen mainScreen].bounds message:@"暂无数据"];
            [self.view addSubview:noDataView];
            
            [ZTShowMessage showMessage:@"您的账号已经在其他设备登录，请重新登录" Title:nil LeftButton:@"取消" RightButton:@"确定" leftBtnClick:^{
                [self.navigationController popViewControllerAnimated:YES];
            } rightBtnClick:^{
                LoginViewController *loginViewController = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginViewController animated:YES];
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

/**
 *  上传照片
 */
- (void)uploadPhoto{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kuploadlUrl]];
    request.HTTPMethod = @"POST";
    
    //  设置请求体
    NSMutableData *body = [NSMutableData data];
    
    //  文件参数
    [body appendData:Encode(@"--")];
    [body appendData:Encode(FileBoundary)];
    [body appendData:Encode(NewLine)];
    NSString *dataStr = @"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"";
    
    [body appendData:Encode(dataStr)];
    [body appendData:Encode(NewLine)];
    dataStr = @"Content-Type: image/jpeg";
    [body appendData:Encode(dataStr)];
    
    [body appendData:Encode(NewLine)];
    [body appendData:Encode(NewLine)];
    [body appendData:UIImagePNGRepresentation(self.imageview.image)];
    [body appendData:Encode(NewLine)];
    
    //  非文件参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fileFileName"] = @"image.jpg";
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"type"] = @"1";
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        [body appendData:Encode(@"--")];
        [body appendData:Encode(FileBoundary)];
        [body appendData:Encode(NewLine)];
        NSString *dataStr = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
        
        [body appendData:Encode(dataStr)];
        [body appendData:Encode(NewLine)];
        [body appendData:Encode(NewLine)];
        [body appendData:Encode(obj)];
        
        [body appendData:Encode(NewLine)];
    }];
    
    
    //  结束标记
    [body appendData:Encode(@"--")];
    [body appendData:Encode(FileBoundary)];
    [body appendData:Encode(@"--")];
    [body appendData:Encode(NewLine)];
    
    request.HTTPBody = body;
    
    
    //  设置请求头(告诉服务器这次传给你的是文件数据，告诉服务器现在发送的是一个文件上传请求)
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",FileBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    //  发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.agentModel.personPath = dict[@"path"];
        [self updateBaseInfo];
    }];
}

/**
 *  上传修改后的信息
 */
- (void)updateBaseInfo{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"districtId"] = self.agentModel.DistrictID;
    params[@"districtName"] = self.agentModel.districtName;
    params[@"grade"] = self.agentModel.grade;
    params[@"key"] = [UserInfo sharedUserInfo].key;
    params[@"personPath"] = self.agentModel.personPath;
    params[@"version"] = @"50";
    params[@"versionCode"] = @"50";
    
    [mgr POST:kupdateBaseInfoUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - NavigationBtnClick

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick{
    [self.view endEditing:YES];
    
    //  判断头像信息是否发生变化
    if (![self.personPath isEqualToString:self.agentModel.personPath] || self.agentModel.personPath.length == 0){
        [self uploadPhoto];
        
    //  判断负责区域 和 行业经验是否发生变化
    }else if(![self.districtName isEqualToString:self.agentModel.districtName] || ![self.grade isEqualToString:self.agentModel.grade]) {
        [self updateBaseInfo];
    }else{
        [ZTShowMessage showMessage:@"当前没有任何修改"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self hideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideTabBar:NO];
}

/**
 *  隐藏TabBar
 *
 *  @return void
 */
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