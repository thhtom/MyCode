//
//  BFDPaperworkViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/4/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDPaperworkViewController.h"
#import "BFDPaperworkTableViewCell.h"

static CGFloat const aspectRatio = 658 / 362.0;
static CGFloat const statusH = 40;

@interface BFDPaperworkViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) NSArray *keyAry;
@property (nonatomic, strong) NSArray *promptAry; //提示数组
@property (nonatomic, assign) NSIndexPath *selectIndexPath;
@property (nonatomic, weak) UIButton *commitBtn;
@property (nonatomic, assign) BOOL isUploadImage;
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, assign) BOOL isReviewing; //是否是审核中
@property (nonatomic, strong) NSDictionary *imageDic;
@property (nonatomic, strong) NSDictionary *canalDic;
@property (nonatomic, copy) NSString *bulletStr; //提示文字
@property (nonatomic ,copy) NSString *reasonStr;//驳回信息

@end

@implementation BFDPaperworkViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, statusH, kUIScreenWidth, kUIScreenHeight - (kNavigationBarHeight + kTabbarHeight + statusH));
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyAry = @[@"positive_card",@"reverse_card",@"firest_license",@"vice_license",@"bank_code"];
    self.promptAry = @[@"请上传身份证正面",@"请上传身份证背面",@"请上传驾驶证主页",@"请上传驾驶证副页"];
    
    [self requestData];
    
    [self configUI];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PagerworkView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PagerworkView"];
}

-(void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的证件";
    
    [self createCommitBtn];
    [self createStatusView];
}

-(void)configData{
    
    NSMutableDictionary *mdic1 = [NSMutableDictionary dictionary];
    NSDictionary *dic1 = @{@"title":@"身份证正面",@"image":@"reserve_idcard_front"};
    mdic1 = [NSMutableDictionary dictionaryWithDictionary:dic1];
    
    
    NSDictionary *dic2 = @{@"title":@"身份证背面",@"image":@"reserve_idcard_back"};
    NSMutableDictionary *mdic2 = [NSMutableDictionary dictionaryWithDictionary:dic2];
    
    NSDictionary *dic3 = @{@"title":@"驾驶证主页",@"image":@"reserve_drivercard_front"};
    NSMutableDictionary *mdic3 = [NSMutableDictionary dictionaryWithDictionary:dic3];
    
    NSDictionary *dic4 = @{@"title":@"驾驶证副页",@"image":@"reserve_drivercard_back"};
    NSMutableDictionary *mdic4 = [NSMutableDictionary dictionaryWithDictionary:dic4];
    
    NSDictionary *dic5 = @{@"title":@"银行卡(选填)",@"image":@"reserve_bankcard"};
    NSMutableDictionary *mdic5 = [NSMutableDictionary dictionaryWithDictionary:dic5];
    
    self.dataAry = @[mdic1,mdic2,mdic3,mdic4,mdic5];
}

-(void)createStatusView{
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 40)];
    statusView.backgroundColor = RGBColor(255, 251, 242);
    [self.view addSubview:statusView];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, kUIScreenWidth - 50, 20)];
    statusLabel.textColor = RGBColor(255, 99, 42);
    [statusView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = @"了解详情";
    detailLabel.textColor = RGBColor(42, 172, 255);
    //审核失败详情
    [detailLabel addTapGesture:^{
        [self createDetailView];
    }];
    
    [statusView addSubview:detailLabel];
    self.detailLabel = detailLabel;
    
    if (IPHONE5) {
        statusLabel.font = [UIFont systemFontOfSize:11];
        detailLabel.font = [UIFont systemFontOfSize:11];
    }else{
        statusLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.font = [UIFont systemFontOfSize:13];
    }
}

-(void)createCommitBtn{
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, kUIScreenHeight - kNavigationBarHeight - kTabbarHeight, kUIScreenWidth, kTabbarHeight);
    commitBtn.backgroundColor = kGlobalTintColor;
    [commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //上传图片
    [commitBtn click:^(id value) {
        [self upLoadImage];
    }];
    [self.view addSubview:commitBtn];
    self.commitBtn = commitBtn;
}

-(void)createDetailView{
    
    UIView *bgView = [[UIView alloc] initWithFrame:kWindow.bounds];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth - 50, 150)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.center = bgView.center;
    [bgView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, view.width - 40, 70)];
    label.text = self.reasonStr;
    label.textColor = kFirstTextColor;
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    [label sizeToFit];
    [view addSubview:label];
    
    CGFloat btnH = 45;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, view.height - btnH, view.width, btnH);
    btn.backgroundColor = kGlobalTintColor;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
    [view addSubview:btn];
    //确定按钮
    [btn click:^(id value) {
        [bgView removeFromSuperview];
    }];
    
    [kWindow addSubview:bgView];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDPaperworkTableViewCell *cell = [BFDPaperworkTableViewCell cellWithTableView:tableView];
    //重新上传
    cell.reuploadBlock = ^(BFDPaperworkTableViewCell *cell) {
        NSIndexPath *index = [tableView indexPathForCell:cell];
        self.selectIndexPath = index;
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self loadImagePicker];
        }else{
            [BOCProgressHUD boc_ShowError:@"不能拍照"];
        }
    };
    
    if (self.isUploadImage) { //上传过证件
        
        NSString *key = self.keyAry[indexPath.section];
        NSMutableString *baseStr = [NSMutableString string];
        if ([self.canalDic[key] isEqualToString:@"1"]) {
            [baseStr appendString:kBaseUrl];
        }else{
            [baseStr appendString:kBaseImgUrl];
        }
        [baseStr appendString:self.imageDic[key]];
        cell.imageStr = baseStr;
        
        cell.userInteractionEnabled = NO;
        
        if (self.isReviewing) {
            cell.isReviewing = YES;
        }
        
    }else{ //没有上传过证件
        cell.originalDic = self.dataAry[indexPath.section];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] init];
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kUIScreenWidth - 45) / aspectRatio;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectIndexPath = indexPath;
    
    NSMutableDictionary *dic = self.dataAry[indexPath.section];
    if (!dic[@"iconImg"]) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self loadImagePicker];
        }else{
            [BOCProgressHUD boc_ShowError:@"不能拍照"];
        }
    }
}

#pragma mark - 拍照相关
-(void)loadImagePicker{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
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
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self changePhotoImage:image];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


-(void)changePhotoImage:(UIImage *)image{
    
    NSIndexPath *indexPath = self.selectIndexPath;
    NSMutableDictionary *dic = self.dataAry[indexPath.section];
    [dic setObject:image forKey:@"iconImg"];
    [dic setObject:self.keyAry[indexPath.section] forKey:@"key"];
    
    [self.tableView reloadData];
}


#pragma mark - 网络请求
//上传证件
-(void)upLoadImage{

    NSMutableArray *imageAry = [NSMutableArray array];
    NSMutableArray *keyAry = [NSMutableArray array];
    NSMutableString *keyStr = [NSMutableString string];
    
    for (NSDictionary *dic in self.dataAry) {
        if (dic[@"iconImg"]) {
            NSData *imageData = UIImageJPEGRepresentation(dic[@"iconImg"], 0.3);
            [imageAry addObject:imageData];
            NSString *key = dic[@"key"];
            [keyAry addObject:key];
            [keyStr appendString:key];
        }
    }
    
    for (int i = 0; i < self.keyAry.count - 1; i ++) {
        NSString *key = self.keyAry[i];
        if (![keyStr containsString:key]) {
            [BOCProgressHUD boc_ShowError:self.promptAry[i]];
            return;
        }
    }
    
    [BOCProgressHUD boc_ShowHUD];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:@"1" forKey:@"type"];
    
    [JKHttpRequestService POST:@"/index.php/Home/UserData/uploadData" Params:params NSArray:imageAry key:keyAry success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        [BOCProgressHUD boc_showSuccess:jsonDic[@"msg"]];
        
        if (succe) {
            Account *account = [AccountTool sharedAccountTool].account;
            account.is_authentication = @"1";
            [[AccountTool sharedAccountTool] saveAccount:account];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^{
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}

//获取证件
-(void)requestData{
    
    [BOCProgressHUD boc_ShowHUD];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:@"2" forKey:@"type"];
    
    [JKHttpRequestService POST:@"/index.php/Home/UserData/uploadData" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        
        if (succe) {
            int value = [jsonDic[@"data"][@"condition"] intValue];
            
            Account *account = [AccountTool sharedAccountTool].account;
            account.is_authentication = jsonDic[@"data"][@"condition"];
            [[AccountTool sharedAccountTool] saveAccount:account];
        
            //0：未认证， 1:待审核， 2：审核失败， 3：审核成功
            switch (value) {
                case 0:{
                    self.isUploadImage = NO;
                    
                    self.statusLabel.text = @"完成认证需要核实您的身份信息，请拍摄上传您的证件";
                    self.detailLabel.hidden = YES;
                    
                    [self configData];
                }
                    break;
                    
                case 1:{
                    self.isUploadImage = YES;
                    self.isReviewing = YES;
                    self.imageDic = jsonDic[@"data"][@"info"];
                    self.canalDic = jsonDic[@"data"][@"canal"];
                    
                    self.statusLabel.text = @"您的证件正在审核中，请稍后查看";
                    self.statusLabel.textAlignment = NSTextAlignmentCenter;
                    self.detailLabel.hidden = YES;
                    self.commitBtn.hidden = YES;
                    self.tableView.frame = CGRectMake(0, statusH, kUIScreenWidth, kUIScreenHeight - (kNavigationBarHeight + statusH));
                }
                    break;
                
                case 2:{
                    self.isUploadImage = NO;
                    self.bulletStr = jsonDic[@"data"][@"reject_explain"];
                    
                    self.statusLabel.text = @"对不起，您的证件审核未通过，请重新上传，";
                    [self.statusLabel sizeToFit];
                    self.statusLabel.centerY = statusH / 2;
                    
                    self.detailLabel.frame = CGRectMake(CGRectGetMaxX(self.statusLabel.frame) + 5, 0, 20, 10);
                    [self.detailLabel sizeToFit];
                    self.detailLabel.centerY = statusH / 2;
                    self.detailLabel.hidden = NO;
                    self.reasonStr = jsonDic[@"data"][@"reject_explain"];
                    
                    [self configData];
                }
                    break;
                    
                case 3:{
                    self.isUploadImage = YES;
                    self.isReviewing = NO;
                    self.imageDic = jsonDic[@"data"][@"info"];
                    self.canalDic = jsonDic[@"data"][@"canal"];
                    
                    self.statusLabel.text = @"您的证件审核成功";
                    self.statusLabel.textAlignment = NSTextAlignmentCenter;
                    self.commitBtn.hidden = YES;
                    self.tableView.frame = CGRectMake(0, statusH, kUIScreenWidth, kUIScreenHeight - (kNavigationBarHeight + statusH));
                }
                    break;
            }

            [self.tableView reloadData];
        }
        
    } failure:^{
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}

@end
