//
//  BFDSelectCarViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDSelectCarViewController.h"
#import "BFDSelectCarTableViewCell.h"
#import "BFDMyCollectionModel.h"
#import "CarModel.h"
#import "BFDPriceDetailViewController.h"
#import "BFDHomeTableViewCell.h"

static NSString *const cellID = @"BFDHomeTableViewCell";

@interface BFDSelectCarViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger _pageCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *collectionAry;
@property (nonatomic, strong) NSMutableArray *recommendAry;
@property (nonatomic, assign) BOOL showCollection;

@end

@implementation BFDSelectCarViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [BFDGifHeader headerWithRefreshingBlock:^{
            [self getData];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
    }
    return _tableView;
}

-(NSMutableArray *)collectionAry{
    if (!_collectionAry) {
        _collectionAry = [NSMutableArray array];
    }
    return _collectionAry;
}

-(NSMutableArray *)recommendAry{
    if (!_recommendAry) {
        _recommendAry = [NSMutableArray array];
    }
    return _recommendAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择车辆";
    _showCollection = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"CalculatorSelectCarView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CalculatorSelectCarView"];
}

-(void)loadData{
    _pageCount = 1;
    [self.collectionAry removeAllObjects];
    [self.recommendAry removeAllObjects];
    [self getData];
}

-(void)loadMoreData{
    _pageCount ++;
    [self.recommendAry removeAllObjects];
    [self getData];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (section == 0) {
        count = self.collectionAry.count;
    }else if (section == 1){
        count = self.recommendAry.count;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BFDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        BFDMyCollectionModel *model = self.collectionAry[indexPath.row];
        if (indexPath.row % 2 == 0) {
            model.isRight = NO;
        }else{
            model.isRight = YES;
        }
        cell.collectionModel = self.collectionAry[indexPath.row];
    }else if (indexPath.section == 1){
        BFDMyCollectionModel *model = self.recommendAry[indexPath.row];
        if (indexPath.row % 2 == 0) {
            model.isRight = NO;
        }else{
            model.isRight = YES;
        }
        cell.model = self.recommendAry[indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    
    NSArray *titleAry = @[@"我的收藏",@"其他推荐"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RSS(15), RSS(22), 100, RSS(16))];
    label.font = [UIFont boldSystemFontOfSize:RSS(16)];
    label.textColor = kFirstTextColor;
    label.text = titleAry[section];
    [view addSubview:label];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return RSS(60);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RSS(250);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDPriceDetailViewController *detailVC = [[BFDPriceDetailViewController alloc] init];
    if (indexPath.section == 0) {
        BFDMyCollectionModel *model = self.collectionAry[indexPath.row];
        detailVC.goods_id = model.carID;
    }else if (indexPath.section == 1){
        CarModel *model = self.recommendAry[indexPath.row];
        detailVC.goods_id = model.carID;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - 数据
-(void)getData{
    [self.recommendAry removeAllObjects];
    [self.collectionAry removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (kUserLogin) {
        [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"app_user_id"];
    }
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_pageCount] forKey:@"page"];
    
    [JKHttpRequestService POST:@"/Home/Goods/getFavorite" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (succe) {
            for (NSDictionary *dic in jsonDic[@"data"][@"goods"]) {
                BFDMyCollectionModel *model = [BFDMyCollectionModel mj_objectWithKeyValues:dic];
                if([self.collectionAry count]<= [jsonDic[@"data"][@"count"]integerValue]){
                  [self.collectionAry addObject:model];
                }
            }
            
            for (NSDictionary *dic in jsonDic[@"data"][@"optim"]) {
                CarModel *model = [CarModel mj_objectWithKeyValues:dic];
                [self.recommendAry addObject:model];
            }
            
            if (self.collectionAry.count < [jsonDic[@"data"][@"count"] integerValue]) {
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
