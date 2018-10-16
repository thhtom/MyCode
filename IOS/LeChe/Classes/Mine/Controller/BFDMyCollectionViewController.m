//
//  BFDMyCollectionViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyCollectionViewController.h"
#import "BFDMyCollectionModel.h"
#import "BFDHomeDetailViewController.h"
#import "BFDHomeTableViewCell.h"

static NSString *const cellID = @"BFDHomeTableViewCell";

@interface BFDMyCollectionViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    NSInteger _pageCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation BFDMyCollectionViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self.view addSubview:self.tableView];
    [_tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MyCollectionView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MyCollectionView"];
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BFDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    BFDMyCollectionModel *model = self.dataAry[indexPath.row];
    if (indexPath.row % 2 == 0) {
        model.isRight = NO;
    }else{
        model.isRight = YES;
    }
    cell.collectionModel = self.dataAry[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RSS(250);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDMyCollectionModel *model = self.dataAry[indexPath.row];
    if ([model.shelves isEqualToString:@"0"]) {
        [BOCProgressHUD boc_showText:@"商品已下架"];
        return;
    }
    
    BFDHomeDetailViewController *detailVC = [[BFDHomeDetailViewController alloc] init];
    detailVC.good_id = model.carID;
    [self.navigationController pushViewController:detailVC animated:YES];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删 除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        BFDMyCollectionModel *model = self.dataAry[indexPath.row];
        [self delegateWithCid:model.cid];
    }];
    
    rowAction.backgroundColor = RGBA(102, 102, 102, 1);
    return @[rowAction];
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
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"app_user_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_pageCount] forKey:@"page"];
    
    [JKHttpRequestService POST:@"/Home/Goods/getFavorite" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (succe) {
            
            for (NSDictionary *dic in jsonDic[@"data"][@"goods"]) {
                BFDMyCollectionModel *model = [BFDMyCollectionModel mj_objectWithKeyValues:dic];
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


-(void)delegateWithCid:(NSString *)cid{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cid forKey:@"cid"];

    [JKHttpRequestService POST:@"/Home/Goods/delFavorite" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [self loadData];
            [self.tableView.mj_header beginRefreshing];
            [BOCProgressHUD boc_showSuccess:jsonDic[@"msg"]];
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
