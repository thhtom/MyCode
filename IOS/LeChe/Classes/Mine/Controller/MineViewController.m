//
//  MineViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "BFDEditViewController.h"
#import "BFDSettingViewController.h"
#import "BFDBrowsingHistoryViewController.h"
#import "BFDMyCollectionViewController.h"
#import "BFDCollectionViewController.h"
#import "BFDMyReserveViewController.h"
#import "BFDFeedbackView.h"
#import "BFDPaperworkViewController.h"
#import "BaseWebViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nickNameLabel;
@property (nonatomic, weak) UILabel *phoneLabel;
@property (nonatomic, weak) UIView *coverView;

@end

@implementation MineViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kTabbarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBA(245, 245, 245, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBA(51, 51, 51, 1);
    
    [self configureUI];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MineView"];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    Account *account = [AccountTool sharedAccountTool].account;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,account.user_header]] placeholderImage:Img(@"mine_head")];
    self.nickNameLabel.text = account.nick_name;
    self.phoneLabel.text = [account.mobile phoneFormat];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MineView"];
    
    //解决跳转登录页，页面闪动问题
    if (kUserLogin) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

-(UIView *)headerView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(140))];
    [headerView addGradientWithStartColor:RGBA(57, 57, 57, 1) endColor:RGBA(38, 38, 38, 1)];
    //个人信息编辑
    [headerView addTapGesture:^{
        if (!kUserLogin) {
            [ShowLoginManager showLoginVcFrom:self isTokenFailed:NO];
            return ;
        }
        BFDEditViewController *editVC = [[BFDEditViewController alloc] init];
        [self.navigationController pushViewController:editVC animated:YES];
    }];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(RSS(22), RSS(64), RSS(55), RSS(55))];
    imgView.layer.cornerRadius = imgView.height / 2;
    imgView.layer.masksToBounds = YES;
    imgView.image = Img(@"mine_head");
    [headerView addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *nickName = [QuickCreate createLabelWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + RSS(10), RSS(74), RSS(150), RSS(16)) text:@"rujing-2134" textColor:[UIColor whiteColor] fontSize:RSS(16) textAlignment:NSTextAlignmentLeft numberOfLines:1 isBold:YES];
    [headerView addSubview:nickName];
    self.nickNameLabel = nickName;
    
    UILabel *phone = [QuickCreate createLabelWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + RSS(10), CGRectGetMaxY(nickName.frame) + RSS(10), RSS(150), RSS(11)) text:@"137****8888" textColor:RGBA(204, 204, 204, 1) fontSize:RSS(14) textAlignment:NSTextAlignmentLeft numberOfLines:1 isBold:NO];
    [headerView addSubview:phone];
    self.phoneLabel = phone;
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat h = 85;
    if (kStatusBarHeight > 20) {
        h = 115;
    }
    settingBtn.frame = CGRectMake(kUIScreenWidth - 50, 0, 50, h);
    [settingBtn setImage:Img(@"mine_set") forState:UIControlStateNormal];
    //设置
    [settingBtn click:^(id value) {
        if (!kUserLogin) {
            [ShowLoginManager showLoginVcFrom:self isTokenFailed:NO];
            return ;
        }
        BFDSettingViewController *editVC = [[BFDSettingViewController alloc] init];
        [self.navigationController pushViewController:editVC animated:YES];
    }];
    [headerView addSubview:settingBtn];
    
    return headerView;
}

-(void)configureUI{
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self headerView];

    self.dataAry = @[
                     @[@{@"title":@"浏览记录",@"image":@"mine_record",@"controller":@"BFDBrowsingHistoryViewController"},
                       @{@"title":@"我的收藏",@"image":@"mine_collection",@"controller":@"BFDMyCollectionViewController"},
                       @{@"title":@"我的预约",@"image":@"mine_appointment",@"controller":@"BFDMyReserveViewController"},
                       @{@"title":@"我的订单",@"image":@"mine_order",@"controller":@"BFDMyOrderViewController"},
                       @{@"title":@"我的证件",@"image":@"mine_paperwork",@"controller":@"BFDPaperworkViewController"}],
                     @[@{@"title":@"关于我们",@"image":@"mine_aboutus",@"controller":@""},
                       @{@"title":@"意见反馈",@"image":@"mine_feedback",@"controller":@""}]];
}

-(UIView *)successView{
    
    UIView *coverView = [[UIView alloc] initWithFrame:kWindow.bounds];
    coverView.backgroundColor = RGBA(0, 0, 0, 0.7);
    self.coverView = coverView;
    [coverView addTapGesture:^{
        [self.coverView removeFromSuperview];
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(RSS(55), RSS(216), RSS(265), RSS(250))];
    view.backgroundColor = [UIColor whiteColor];
    [coverView addSubview:view];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(RSS(74), RSS(39), RSS(117), RSS(117))];
    imgView.image = Img(@"success");
    [view addSubview:imgView];
    
    UILabel *label = [QuickCreate createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + RSS(51), view.width, RSS(14)) text:@"感谢您提交的宝贵意见！" textColor:(UIColor *)RGBA(51, 51, 51, 1) fontSize:RSS(14) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    [view addSubview:label];
    
    return coverView;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataAry[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [MineTableViewCell cellWithTableView:tableView];
    NSArray *ary = self.dataAry[indexPath.section];
    cell.dataDic = ary[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!(indexPath.section == 1 && indexPath.row == 0)) {
        if (!kUserLogin) {
            [ShowLoginManager showLoginVcFrom:self isTokenFailed:NO];
            return ;
        }
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        BFDCollectionViewController *collectVC = [[BFDCollectionViewController alloc] init];
        collectVC.index = 0;
        [self.navigationController pushViewController:collectVC animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        BFDCollectionViewController *collectVC = [[BFDCollectionViewController alloc] init];
        collectVC.index = 1;
        [self.navigationController pushViewController:collectVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        BFDFeedbackView *feedbackView = [BFDFeedbackView createFeedBackView];
        feedbackView.frame = kWindow.frame;
        //提交意见反馈
        feedbackView.commitBlock = ^(NSString *feedback) {
            [self commitFeedback:feedback];
        };
        [kWindow addSubview:feedbackView];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        BaseWebViewController *webView = [[BaseWebViewController alloc] init];
        webView.urlString = @"http://testwww.rujcar.com/appAboutUs.html";
        webView.enableWebBack = YES;
        [self.navigationController pushViewController:webView animated:YES];
    }else{
        NSDictionary *dic = self.dataAry[indexPath.section][indexPath.row];
        Class  class = NSClassFromString(dic[@"controller"]);
        UIViewController *vc = [[class alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - 提交反馈
-(void)commitFeedback:(NSString *) feedback{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:feedback forKey:@"content"];

    [JKHttpRequestService POST:@"/Home/Pcenter/addFeedback" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [kWindow addSubview:[self successView]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.coverView removeFromSuperview];
            });
        }
    } failure:^(void) {
        
    } animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

@end
