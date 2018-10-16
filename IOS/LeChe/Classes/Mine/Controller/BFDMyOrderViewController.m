//
//  BFDMyOrderViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyOrderViewController.h"
#import "BFDMyorderTableViewCell.h"
#import "BFDMyOrderModel.h"
#import "BFDOrderDetailViewController.h"

static CGFloat const widthRatio = 270 / 750.0;

@interface BFDMyOrderViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>{
    NSInteger _pageCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation BFDMyOrderViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBA(245, 245, 245, 1);
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
    self.title = @"我的订单";
    
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MyOrderView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MyOrderView"];
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

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDMyorderTableViewCell *cell = [BFDMyorderTableViewCell cellWithTableView:tableView];
    cell.model = self.dataAry[indexPath.section];
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
    return widthRatio * kUIScreenWidth / kAspectRatio + 59;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDMyOrderModel *model = self.dataAry[indexPath.section];
    if ([model.shelves isEqualToString:@"0"]) {
        [BOCProgressHUD boc_showText:@"商品已下架"];
        return;
    }
    
    BFDOrderDetailViewController *orderDetailVC = [[BFDOrderDetailViewController alloc] init];
    orderDetailVC.order_id = model.order_id;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
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
    
    [JKHttpRequestService POST:@"/Home/Orders/ordersList" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (succe) {
            for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
                BFDMyOrderModel *model = [BFDMyOrderModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
            if (self.dataAry.count < [jsonDic[@"data"][@"count"] integerValue]) {
                self.tableView.mj_footer.hidden = NO;
            }else{
                self.tableView.mj_footer.hidden = YES;
            }
            [self.tableView reloadData];
        }
    } failure:^(void) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } animated:NO];
}


@end
