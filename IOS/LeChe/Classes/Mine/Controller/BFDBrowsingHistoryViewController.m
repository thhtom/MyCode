//
//  BFDBrowsingHistoryViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDBrowsingHistoryViewController.h"
#import "BFDBrowsingModel.h"
#import "BFDHomeDetailViewController.h"
#import "BFDHomeTableViewCell.h"

static NSString *const ID = @"BFDHomeTableViewCell";

@interface BFDBrowsingHistoryViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    NSInteger _pageCount;
}

@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BFDBrowsingHistoryViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain];
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
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.view addSubview:self.tableView];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"BrowHistoryView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"BrowHistoryView"];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDBrowsingModel *model = self.dataAry[indexPath.row];
    if (indexPath.row % 2 == 0) {
        model.isRight = NO;
    }else{
        model.isRight = YES;
    }
    
    BFDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.browsModel = model;
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RSS(250);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDBrowsingModel *model = self.dataAry[indexPath.section];
    if ([model.shelves isEqualToString:@"0"]) {
        [BOCProgressHUD boc_showText:@"商品已下架"];
        return;
    }
    
    BFDHomeDetailViewController *detailVC = [[BFDHomeDetailViewController alloc] init];
    detailVC.good_id = model.gid;
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
    
    [JKHttpRequestService POST:@"/Home/Pcenter/selectBrowseRecords" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (succe) {
            for (NSDictionary *dic in responseObject[@"data"][@"array"]) {
                BFDBrowsingModel *model = [BFDBrowsingModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
            
            if (self.dataAry.count >= [responseObject[@"data"][@"count"] intValue]) {
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

@end
