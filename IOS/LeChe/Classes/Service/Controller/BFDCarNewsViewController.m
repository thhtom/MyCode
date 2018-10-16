//
//  BFDCarNewsViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/29.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCarNewsViewController.h"
#import "BFDCarNewsTableViewCell.h"
#import "BFDCarNewsModel.h"
#import "BFDNewsDetailViewController.h"

static CGFloat const widthRatio = 280 / 735.0;

@interface BFDCarNewsViewController ()<UITableViewDelegate, UITableViewDataSource>{
    int _pageCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation BFDCarNewsViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    self.title = @"汽车资讯";
    
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"CarNewsView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CarNewsView"];
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
    
    BFDCarNewsTableViewCell * cell = [BFDCarNewsTableViewCell cellWithTableView:tableView];
    cell.model = self.dataAry[indexPath.section];
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return widthRatio * kUIScreenWidth / 1.5 + 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
        
    BFDCarNewsModel *model = self.dataAry[indexPath.section];
    BFDNewsDetailViewController *newsDetailVC = [[BFDNewsDetailViewController alloc] init];
    newsDetailVC.a_id = model.ID;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}


#pragma mark - 数据
-(void)getData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%d",_pageCount] forKey:@"page"];
    
    [JKHttpRequestService POST:@"/Home/Article/articleList" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (succe) {
            for (NSDictionary *dic in jsonDic[@"data"][@"data"]) {
                BFDCarNewsModel *model = [BFDCarNewsModel mj_objectWithKeyValues:dic];
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
