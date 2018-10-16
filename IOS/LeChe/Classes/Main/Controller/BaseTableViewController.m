//
//  BaseTableViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BaseTableViewController.h"

static CGFloat const kCellHeight = 45.0;

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        [self configureTableView:style];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self configureTableView: UITableViewStylePlain];
    }
    return self;
}

- (void)configureTableView:(UITableViewStyle)style
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight - kSafeBottomHeight) style: style];
    tableView.backgroundColor = kGlobalBg;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentPage = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self baseSetupSubviews];
}

- (void)baseSetupSubviews
{
    self.tableView.rowHeight = kCellHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 10.0;
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.view addSubview: self.tableView];
}

#pragma mark - 下拉刷新与下拉加载更多
/** 同时集成上拉刷新与下拉加载更多*/
- (void)addRefreshControl
{
    [self addHeaderRefreshControl];
    [self addFooterRefreshControl];
}

- (void)addHeaderRefreshControl
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataList)];
}

- (void)addFooterRefreshControl
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataList)];
    [footer setTitle:@"别拉啦，到底了~" forState:MJRefreshStateNoMoreData];
//    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
}

- (void)loadNewDataList
{
    _currentPage = 1;
    [self loadDataListWithPage:_currentPage];
}

- (void)loadMoreDataList
{
    _currentPage += 1;
    [self loadDataListWithPage:_currentPage];
}

- (void)loadDataListWithPage: (NSInteger)page{
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointZero;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"common_empty"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"暂无内容" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor grayColor]}];
    return title;
}

#pragma mark - lazy loading
- (NSMutableArray *)dataSourceList
{
    if (!_dataSourceList) {
        _dataSourceList = [NSMutableArray array];
    }
    return _dataSourceList;
}

@end
