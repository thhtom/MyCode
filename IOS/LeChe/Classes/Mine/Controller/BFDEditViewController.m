//
//  BFDSettionViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDEditViewController.h"
#import "BFDEditTableViewCell.h"
#import "BFDNickNameViewController.h"
#import "BFDSexViewController.h"
#import "TimePickerView.h"
#import "CityPickerView.h"
#import "EditPhotoView.h"

@interface BFDEditViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSArray *_dataAry;
}

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;

@end

@implementation BFDEditViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBA(245, 245, 245, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces=NO;
    }
    return _tableView;
}


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"EditView"];
     
     [self initData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"EditView"];
}

-(void)configureUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    
    self.headerView.height = RSS(76);
    self.headerView.backgroundColor = RGBA(51, 51, 51, 1);
    
    self.photoImgView.width = self.photoImgView.height = RSS(55);
    self.photoImgView.layer.cornerRadius = self.photoImgView.height / 2;
    self.photoImgView.layer.masksToBounds = YES;

    //头像编辑
    [self.photoImgView addTapGesture:^{
        [self showPhotoView];
    }];
}

-(void)initData{
    
    Account *account = [AccountTool sharedAccountTool].account;
    NSString *sex = account.sex.length > 0 ? account.sex : @"未设置";
    NSString *birthday = account.birthday.length > 0 ? account.birthday : @"未设置";
    NSString *area = account.area.length > 0 ? account.area : @"选择";
    NSString *mobile = [account.mobile phoneFormat];
    _dataAry = @[
                 @[@{@"title":@"手机号",@"status":@1,@"content":mobile,@"controller":@""}],
                 @[@{@"title":@"昵称",@"status":@0,@"content":account.nick_name,@"controller":@"BFDNickNameViewController"},
                   @{@"title":@"性别",@"status":@0,@"content":sex,@"controller":@"BFDSexViewController"},
                   @{@"title":@"生日",@"status":@0,@"content":birthday,@"controller":@""},
                   @{@"title":@"所在地",@"status":@0,@"content":area,@"controller":@""}]
                 ];
    
    NSString *imgStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,account.user_header];
    [self.photoImgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:Img(@"mine_head")];
    
    [self.tableView reloadData];
}

#pragma mark - 城市选择
-(void)showCityView:(NSIndexPath *) indexPath{
    
    CityPickerView *cityView = [[CityPickerView alloc] initWithFrame:kWindow.bounds];
    [cityView showView];
    cityView.action = ^(NSString *city) {
        [self changeCity:city];
    };
}

#pragma mark - 图片选择
-(void)showPhotoView{
    
    EditPhotoView *photoView = [[EditPhotoView alloc] initWithFrame:kWindow.bounds];
    photoView.action = ^(NSInteger index) {
        if (index == 0) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
            }else{
                [BOCProgressHUD boc_ShowError:@"不能拍照"];
            }
        }else{
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }else{
               [BOCProgressHUD boc_ShowError:@"不能选取图片"];
            }
        }
    };
    [photoView showView];
}

- (void)loadImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    if(sourceType == UIImagePickerControllerSourceTypeCamera){
    }
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary||picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self changePhoto:image];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//裁剪图片尺寸
- (UIImage *)scaleFromImage:(UIImage *) image toSize: (CGSize) size{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataAry[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDEditTableViewCell *cell = [BFDEditTableViewCell cellWithTableView:tableView];
    NSArray *ary = _dataAry[indexPath.section];
    cell.dataDic = ary[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RSS(55);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBA(245, 245, 245, 1);
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *ary = _dataAry[indexPath.section];
    NSDictionary *dic = ary[indexPath.row];

    Class  class = NSClassFromString(dic[@"controller"]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    switch (indexPath.row) {
        case 2:{
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            TimePickerView *datePicker = [[TimePickerView alloc]initWithDateFormatter:formatter pickerMode:UIDatePickerModeDate delegate:nil];
            datePicker.disableMaximumDate = YES;
            [datePicker showView];
            
            datePicker.dateStrBlock = ^(NSString *dateStr){
                [self changeBirthday:dateStr];
            };
        }
            break;
            
        case 3:{
            [self showCityView:indexPath];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 生日修改
-(void)changeBirthday:(NSString *)birthday{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:birthday forKey:@"birthday"];
    
    [JKHttpRequestService POST:@"/Home/Pcenter/pictureUpload" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [BOCProgressHUD boc_showSuccess:responseObject[@"msg"]];
            
            Account *account = [AccountTool sharedAccountTool].account;
            account.birthday = birthday;
            [[AccountTool sharedAccountTool] saveAccount:account];
            
            [self initData];
        }
    } failure:^(void) {
        
    } animated:NO];
}

#pragma mark - 地区修改
-(void)changeCity:(NSString *)city{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:city forKey:@"city"];
    
    [JKHttpRequestService POST:@"/Home/Pcenter/pictureUpload" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [BOCProgressHUD boc_showSuccess:responseObject[@"msg"]];
            
            Account *account = [AccountTool sharedAccountTool].account;
            account.area = city;
            [[AccountTool sharedAccountTool] saveAccount:account];
            
            [self initData];
        }
    } failure:^(void) {
        
    } animated:NO];
}

#pragma mark - 修改头像
-(void)changePhoto:(UIImage *)image{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    
    [JKHttpRequestService POST:@"/Home/Pcenter/pictureUpload" Params:params NSData:imageData key:@"user_header" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            self.photoImgView.image = image;
            Account *account = [AccountTool sharedAccountTool].account;
            account.user_header = jsonDic[@"data"][@"user_header"];
            [[AccountTool sharedAccountTool] saveAccount:account];
            [BOCProgressHUD boc_showSuccess:jsonDic[@"msg"]];
        }
    } failure:^(void) {
        MyLog(@"");
    } animated:NO];
}


@end
