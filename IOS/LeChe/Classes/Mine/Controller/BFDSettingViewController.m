//
//  BFDSettingViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDSettingViewController.h"
#import "BFDEditTableViewCell.h"

static CGFloat const bottomHeight = 49;

@interface BFDSettingViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_dataAry;
}

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation BFDSettingViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight - bottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self createBottomView];
    
    [self configureUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"SettingView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"SettingView"];
}

-(void)configureUI{
    self.view.backgroundColor = RGBA(245, 245, 245, 1);
    self.title = @"设置";
    
    self.tableView.tableHeaderView = self.headerView;
    
    NSString *cachSize = [NSString stringWithFormat:@"%.2fM",[AppUtil getCacheSize]];
    _dataAry = @[@{@"title":@"清除缓存",@"status":@0,@"content":cachSize},
                 @{@"title":@"检查更新",@"status":@0,@"content":@""}];
    
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本V%@",[AppUtil getAPPVersion]];
}

-(void)createBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kUIScreenHeight - kNavigationBarHeight - bottomHeight - kSafeBottomHeight , kUIScreenWidth, bottomHeight)];
    
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutBtn.frame = bottomView.bounds;
    [logOutBtn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOutBtn addGradient];
    logOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //退出登录
    [logOutBtn click:^(id value) {
        [[AccountTool sharedAccountTool] removeAccount];
        Account *account = nil;
        [[AccountTool sharedAccountTool] saveAccount:account];
        [BOCProgressHUD boc_showSuccess:@"退出登录"];
        self.navigationController.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kUserLoginStateKey];
    }];
    [bottomView addSubview:logOutBtn];
    
    [self.view addSubview:bottomView];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFDEditTableViewCell *cell = [BFDEditTableViewCell cellWithTableView:tableView];
    cell.dataDic = _dataAry[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [AppUtil clearCache];
        [BOCProgressHUD boc_showSuccess:@"缓存清除成功"];
        _dataAry = @[@{@"title":@"清除缓存",@"status":@0,@"content":@"0M"},
                     @{@"title":@"检查更新",@"status":@0,@"content":@""}];
        [self.tableView reloadData];
    }else if (indexPath.row == 1){
        [self CheckForUpdates];
    }
}

-(void)CheckForUpdates{
        
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"2" forKey:@"type"];
    [params setObject:[AppUtil getAPPVersion] forKey:@"version"];
    
    [JKHttpRequestService POST:@"/Home/Common/getVersion" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            
            int value = [jsonDic[@"data"][@"status"] intValue];
            
            if (value == 0) { //最新版本
                [BOCProgressHUD boc_showSuccess:@"当前是最新版本"];
            }else{ //不是最新版本
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"发现新版本" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *appstoreUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", kAppID];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl] options:@{} completionHandler:nil];
                    if (value == 2) {
                        exit(0);
                    }
                }]];
                if (value == 1) { //非强制更新
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                }
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
