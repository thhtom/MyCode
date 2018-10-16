//
//  BFDHomeDetailViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/15.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDHomeDetailViewController.h"
#import "BFDDeatilHeaderView.h"
#import "HomeCarTableViewCell.h"
#import "BFDDetailFirstTableViewCell.h"
#import "BFDDetailSecondTableViewCell.h"
#import "BFDCarDeployModel.h"
#import "CarModel.h"
#import "BFDCarDetailModel.h"
#import "BFDReserveViewController.h"
#import "BFDBrightModel.h"
#import "BFDMyReserveViewController.h"
#import "BFDDeployDetailViewController.h"
#import "BFDHomeTableViewCell.h"

static NSString *const homeCellID = @"BFDHomeTableViewCell";

@interface BFDHomeDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** 车辆配置 */
@property (nonatomic, strong) NSMutableArray *carDeployAry;
/** 推荐车辆 */
@property (nonatomic, strong) NSMutableArray *recommendAry;
/** 亮点推荐 */
@property (nonatomic, strong) NSMutableArray *brightAry;
/** banner */
@property (nonatomic, strong) NSMutableArray *bannerImgAry;
/** 车辆信息Model */
@property (nonatomic, strong) BFDCarDetailModel *detailModel;

/** bottomView */
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *collecBtn;
@property (weak, nonatomic) IBOutlet UIButton *yuyueBtn;

@property (nonatomic, assign) BOOL loadSuccess;
@property (nonatomic, weak) UIView *noNetworkView;

@end

@implementation BFDHomeDetailViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - (kNavigationBarHeight + kSafeBottomHeight + 50)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)carDeployAry{
    if (!_carDeployAry) {
        _carDeployAry = [NSMutableArray array];
    }
    return _carDeployAry;
}

-(NSMutableArray *)recommendAry{
    if (!_recommendAry) {
        _recommendAry = [NSMutableArray array];
    }
    return _recommendAry;
}

-(NSMutableArray *)brightAry{
    if (!_brightAry) {
        _brightAry = [NSMutableArray array];
    }
    return _brightAry;
}

-(NSMutableArray *)bannerImgAry{
    if (!_bannerImgAry) {
        _bannerImgAry = [NSMutableArray array];
    }
    return _bannerImgAry;
}


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"UMengTongJi"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车辆详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFailed) name:kCarDetailLaodFailed object:nil];
    
    //分享按钮
//    UIBarButtonItem *itembar = [[UIBarButtonItem alloc] initWithImage:Img(@"share") style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick)];
//    self.navigationItem.rightBarButtonItem = itembar;

    self.yuyueBtn.width = kUIScreenWidth / 2;
    [self.yuyueBtn addGradient];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:Img(@"navbar_back_white") style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.view addSubview:self.tableView];
    self.bottomView.frame = CGRectMake(0, kUIScreenHeight - 50 - kSafeBottomHeight - kNavigationBarHeight, kUIScreenWidth, 50);
    [self.view addSubview:self.bottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kUserLoginSuccessNotification object:nil];
    
    [self getData];
    
    [self initButton:self.phoneBtn];
    [self initButton:self.collecBtn];
    //收藏
    [self.collecBtn click:^(id value) {
        if (!kUserLogin) {
            [ShowLoginManager showLoginVcFrom:self isTokenFailed:NO];
            return ;
        }
        [self collection];
    }];
    //客服
    [self.phoneBtn click:^(id value) {
        [AppUtil dial:@"400-9696-726"];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"HomeDetailView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"HomeDetailView"];
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];

    // 开启返回手势
    self.fd_interactivePopDisabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // 禁用返回手势
    self.fd_interactivePopDisabled = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadFailed{
    if (!self.noNetworkView) {
        [self createNoNetworkView:1];
    }
}

-(void)initButton:(UIButton*)btn{
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -(btn.titleLabel.bounds.size.width))];
}

-(void)changeReserveBtnStatus:(BOOL)status{
    
    if (status) { //未预约
        [MobClick event:@"subscribe"];
        
        self.yuyueBtn.backgroundColor = kGlobalTintColor;
        [self.yuyueBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    }else{ //已预约
        self.yuyueBtn.backgroundColor = RGBColor(204, 204, 204);
        [self.yuyueBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    }
    
    [self.yuyueBtn click:^(id value) {
        if (!kUserLogin) {
            [ShowLoginManager showLoginVcFrom:self isTokenFailed:NO];
            return ;
        }else{
            if (status) {
                BFDReserveViewController *reserveVC = [[BFDReserveViewController alloc] init];
                reserveVC.good_id = self.good_id;
                [self.navigationController pushViewController:reserveVC animated:YES];
            }else{
                BFDMyReserveViewController *myReserveVC = [[BFDMyReserveViewController alloc] init];
                [self.navigationController pushViewController:myReserveVC animated:YES];
            }
        }
    }];
}

#pragma mark - 敬请期待
-(void)stayTuned{
    self.yuyueBtn.backgroundColor = RGBColor(204, 204, 204);
    [self.yuyueBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
}


#pragma mark - 后退按钮
-(void)backBtnClick{
    if (self.isFromList) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - 登录成功通知
-(void)loginSuccess{
    
    [self.carDeployAry removeAllObjects];
    [self.recommendAry removeAllObjects];
    [self.brightAry removeAllObjects];
    [self.bannerImgAry removeAllObjects];
    
    [self getData];
}

#pragma mark - 分享
-(void)shareBtnClick{
    
    ShareModel *sm = [ShareModel shareModelWithTitle:@"如鲸购车" content:@"如鲸购车" url:@"www.baidu.com" img:@"empty"];
    [self umShare:sm];
}

#pragma mark - 网络不给力展示页面
-(void)createNoNetworkView:(int)type{
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.noNetworkView = view;
    
    NSString *msg;
    UIImage *image;
    if (type == 0) {
        msg = @"网络不给力哦...";
        image = Img(@"noNetwork");
    }else{
        msg = @"呜~加载出错了";
        image = Img(@"loadFailed");
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.centerX = kUIScreenWidth / 2;
    imageView.y = 100;
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 20, kUIScreenWidth, 20)];
    
    label.text = msg;
    label.textColor = RGBColor(153, 153, 153);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = Font(12);
    [view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, CGRectGetMaxY(label.frame), kUIScreenWidth - 200, 50);
    [btn setTitle:@"重新加载" forState:UIControlStateNormal];
    [btn setTitleColor:RGBColor(97, 190, 255) forState:UIControlStateNormal];
    btn.titleLabel.font = Font(12);
    [btn click:^(id value) {
        [self getData];
    }];
    [view addSubview:btn];
    
    [self.view addSubview:view];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (section == 0) {
        count = self.brightAry.count;
    }else if (section == 1){
        count = self.carDeployAry.count;
    }else if (section == 2){
        count = self.recommendAry.count;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BFDDetailSecondTableViewCell * cell = [BFDDetailSecondTableViewCell cellWithTableView:tableView];
        cell.model = self.brightAry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        BFDDetailFirstTableViewCell *cell = [BFDDetailFirstTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.carDeployAry[indexPath.row];
        return cell;
    }else {
        BFDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID];
        if (!cell) {
            cell = [[BFDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeCellID];
        }
        CarModel *model = self.recommendAry[indexPath.row];
        if (indexPath.row % 2 == 0) {
            model.isRight = NO;
        }else{
            model.isRight = YES;
        }
        cell.model = model;
        return cell;
    }
}


#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *titleAry = @[@"亮点推荐",@"车辆配置",@"其他推荐"];
    UIView *view = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RSS(23), RSS(23), RSS(100), RSS(16))];
    label.font = [UIFont boldSystemFontOfSize:RSS(16)];
    label.textColor = kFirstTextColor;
    label.text = titleAry[section];
    [view addSubview:label];
    
    return self.loadSuccess ? view : nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    
    if (section == 1) {
        UIButton *allDeployBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allDeployBtn.frame = CGRectMake(0, 0, 100, 40);
        allDeployBtn.titleLabel.font = Font(14);
        [allDeployBtn setTitle:@"查看全部配置>" forState:UIControlStateNormal];
        [allDeployBtn setTitleColor:RGBA(204, 204, 204, 1) forState:UIControlStateNormal];
        allDeployBtn.center = CGPointMake(kUIScreenWidth / 2, 40);
        //全部配置
        [allDeployBtn click:^(id value) {
            BFDDeployDetailViewController *deployVC = [[BFDDeployDetailViewController alloc] init];
            deployVC.g_id = self.detailModel.carID;
            [self.navigationController pushViewController:deployVC animated:YES];
        }];
        [footerView addSubview:allDeployBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(allDeployBtn.frame) + 20, kUIScreenWidth, 10)];
        lineView.backgroundColor = RGBA(245, 245, 245, 1);
        [footerView addSubview:lineView];
    }
    return self.loadSuccess ? footerView : nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return RSS(62);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0;
    if (section == 0) {
        height = 5;
    }else if (section == 1){
        height = 95;
    }else if (section == 2){
        height = 40;
    }
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0;
    
    if (indexPath.section == 0) {
        CGFloat imgH = (kUIScreenWidth - 30) / kAspectRatio;
        NSString *str = [self.brightAry[indexPath.row] word];
        if (str.length > 0) {
            rowHeight = imgH + 58;
        }else{
            rowHeight = imgH + 20;
        }
    }else if (indexPath.section == 1){
        rowHeight = 50;
    }else if (indexPath.section == 2){
        rowHeight = RSS(250);
    }
    return rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        CarModel *model = self.recommendAry[indexPath.row];
        BFDHomeDetailViewController *detailVC = [[BFDHomeDetailViewController alloc] init];
        detailVC.good_id = model.carID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


#pragma mark - 数据
-(void)getData{
    
    [BOCProgressHUD boc_ShowHUD];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.good_id forKey:@"g_id"];
    NSString *user_id = kUserLogin ? [AccountTool sharedAccountTool].account.user_id : @"";
    [params setObject:user_id forKey:@"u_id"];
    
    [JKHttpRequestService POST:@"/Home/Goods/getDetail" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        if (succe) {
            if (self.noNetworkView) {
                [self.noNetworkView removeFromSuperview];
            }
            self.loadSuccess = YES;
            
            NSDictionary *dataDic = jsonDic[@"data"];
            //车辆配置
            for (NSDictionary *dic in dataDic[@"car_attr"]) {
                BFDCarDeployModel *model = [BFDCarDeployModel mj_objectWithKeyValues:dic];
                [self.carDeployAry addObject:model];
            }
            //推荐车辆
            for (NSDictionary *dic in dataDic[@"recommend"]) {
                CarModel *model = [CarModel mj_objectWithKeyValues:dic];
                [self.recommendAry addObject:model];
            }
            //车详情
            self.detailModel = [BFDCarDetailModel mj_objectWithKeyValues:dataDic[@"car_detail"]];
            
            BFDDeatilHeaderView *headerView = [BFDDeatilHeaderView createHeaderView];
    
            headerView.model = self.detailModel;
            headerView.frame = CGRectMake(0, 0, kUIScreenWidth, 464 + kUIScreenWidth / kAspectRatio);
            //banner
            for (NSString *str in dataDic[@"car_detail"][@"pic_url"]) {
                [self.bannerImgAry addObject:str];
            }
            headerView.imageAry = self.bannerImgAry;
            
            self.tableView.tableHeaderView = headerView;
            //亮点推荐
            for (NSDictionary *dic in dataDic[@"sheen"]) {
                BFDBrightModel *model = [BFDBrightModel mj_objectWithKeyValues:dic];
                [self.brightAry addObject:model];
            }
            //是否收藏
            self.collecBtn.selected = [dataDic[@"collection"] boolValue];
            //敬请期待
            if ([dataDic[@"car_detail"][@"status"] isEqualToString:@"8"]) {
                [self stayTuned];
            }else{
                //是否可以预约
                if ([jsonDic[@"data"][@"appointment"] boolValue]) {
                    [self changeReserveBtnStatus:NO];
                }else{
                    [self changeReserveBtnStatus:YES];
                }
            }
            [self.tableView reloadData];
        }
        
    } failure:^(void) {
        [BOCProgressHUD boc_hiddenHUD];
        if (!self.noNetworkView) {
            [self createNoNetworkView:0];
        }
    } animated:NO];
}

//收藏
-(void)collection{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.good_id forKey:@"goods_id"];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [JKHttpRequestService POST:@"/Home/Goods/addFavorite" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [BOCProgressHUD boc_showSuccess:responseObject[@"msg"]];
            self.collecBtn.selected = !self.collecBtn.selected;
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
