//
//  BFDMyReserveViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyReserveViewController.h"
#import "BFDMyReserveTableViewCell.h"
#import "BFDMyReserveModel.h"
#import "BFDReserveViewController.h"
#import "BFDHomeDetailViewController.h"
#import "BFDPaperworkViewController.h"
#import "BFDReserveViewController.h"
#import "BFDPaperworkViewController.h"
#import "BFDMyOrderViewController.h"

static CGFloat const widthRatio = 270 / 750.0;
static CGFloat const statusViewH = 40;

@interface BFDMyReserveViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    NSInteger _pageCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, weak) UILabel *statusLabel;

@end

@implementation BFDMyReserveViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusViewH, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight - statusViewH) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.mj_header = [BFDGifHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
    }
    return _tableView;
}

-(NSMutableArray *)dataAry{
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的预约";
    
    self.fd_interactivePopDisabled = YES;
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:Img(@"back") style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self createStatusView];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MyReserveView"];
    
    [self loadData];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MyReserveView"];
}


-(void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)loadData{
    _pageCount = 1;
    [self.dataAry removeAllObjects];
    [self getData];
}

-(void)loadMoreData{
    _pageCount ++;
    [self getData];
}

-(void)createStatusView{
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 40)];
    statusView.backgroundColor = RGBA(250, 244, 229, 1);
    [self.view addSubview:statusView];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, kUIScreenWidth - 50, 20)];
    statusLabel.textColor = RGBA(51, 51, 51, 1);
    statusLabel.text = @"预约成功后，我们的工作人员将于48小时之内联系您";
    [statusView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kUIScreenWidth - 60, 0, 60, statusViewH);
    [cancelBtn setImage:Img(@"cancel_black") forState:UIControlStateNormal];
    [statusView addSubview:cancelBtn];
    [cancelBtn click:^(id value) {
        [statusView removeFromSuperview];
        self.tableView.frame = CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight);
    }];

    if (IPHONE5) {
        statusLabel.font = [UIFont systemFontOfSize:11];
    }else{
        statusLabel.font = [UIFont systemFontOfSize:13];
    }
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDMyReserveModel *model = self.dataAry[indexPath.section];
    
    BFDMyReserveTableViewCell *cell = [BFDMyReserveTableViewCell cellWithTableView:tableView];
    cell.model = model;

    //提交资料
    cell.uploadPaperworkBlock = ^{
        BFDPaperworkViewController *paperVC = [[BFDPaperworkViewController alloc] init];
        [self.navigationController pushViewController:paperVC animated:YES];
    };
    //取消预约
    cell.cancelReserveBlock = ^{
        [self cancelReseve:model];
    };
    //重新提交
    cell.reReserveBlock = ^{
        [self reReserve:model];
    };
    //查看原因
    cell.seeReasonBlock = ^{
        BFDPaperworkViewController *paperworkVC = [[BFDPaperworkViewController alloc] init];
        [self.navigationController pushViewController:paperworkVC animated:YES];
    };
    //删除
    cell.delegeBlock = ^{
        [self deleteReason:model];
    };
    //查看订单
    cell.seeOrderBlock = ^{
        BFDMyOrderViewController *myOrderVC = [[BFDMyOrderViewController alloc] init];
        [self.navigationController pushViewController:myOrderVC animated:YES];
    };
    
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFDMyReserveModel *model = self.dataAry[indexPath.section];
    if ([model.status isEqualToString:@"1"] || [model.status isEqualToString:@"2"]) {
        return widthRatio * kUIScreenWidth / kAspectRatio + 52;
    }else{
        return widthRatio * kUIScreenWidth / kAspectRatio + 102;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBA(245, 245, 245, 1);
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDMyReserveModel *model = self.dataAry[indexPath.section];
    if ([model.shelves isEqualToString:@"0"]) {
        [BOCProgressHUD boc_showText:@"商品已下架"];
        return;
    }
    
    BFDHomeDetailViewController *detailVC = [[BFDHomeDetailViewController alloc] init];
    detailVC.good_id = model.goods_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - DZNEmptyDataSetSource , DZNEmptyDataSetDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"\n\n这里空空如也...";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName: RGBColor(153, 153, 153)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"empty"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self.tableView.mj_header beginRefreshing];
}


- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50;
}


#pragma mark - 数据
-(void)getData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_pageCount] forKey:@"page"];
    
    [JKHttpRequestService POST:@"/Home/Reservation/getReservation" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (succe) {
            //保存用户资料状态
            Account *account = [AccountTool sharedAccountTool].account;
            account.is_authentication = jsonDic[@"data"][@"is_authentication"];
            [[AccountTool sharedAccountTool] saveAccount:account];
            
            for (NSDictionary *dic in jsonDic[@"data"][@"info"]) {
                BFDMyReserveModel *model = [BFDMyReserveModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
            if (self.dataAry.count >= [jsonDic[@"data"][@"count"] integerValue]) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            [self.tableView reloadData];
        }
    } failure:^(void) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } animated:NO];
}

//取消预约
-(void)cancelReseve:(BFDMyReserveModel *)model{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:model.reservation_number forKey:@"reservation_number"];
    
    [JKHttpRequestService POST:@"/Home/Reservation/delReservation" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [BOCProgressHUD boc_showSuccess:@"已取消预约"];
            [self loadData];
            [self.tableView.mj_header beginRefreshing];
        }
    } failure:^(void) {

    } animated:NO];
}

//重新预约
-(void)reReserve:(BFDMyReserveModel *)model{
    BFDReserveViewController *reserveVC = [[BFDReserveViewController alloc] init];
    reserveVC.model = model;
    [self.navigationController pushViewController:reserveVC animated:YES];
}

//删除预约
-(void)deleteReason:(BFDMyReserveModel *)model{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:model.reservation_number forKey:@"reservation_number"];
    
    [JKHttpRequestService POST:@"/Home/Reservation/destroyReservation" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
//            [BOCProgressHUD boc_showSuccess:@"已取消预约"];
            [self loadData];
            [self.tableView.mj_header beginRefreshing];
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
