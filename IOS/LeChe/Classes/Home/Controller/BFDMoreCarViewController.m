//
//  BFDMoreCarViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMoreCarViewController.h"
#import "BFDConfigSelectView.h"
#import "BFDHomeTableViewCell.h"
#import "BFDConfigModel.h"
#import "CarModel.h"

static CGFloat const titleH = 44;
static NSString *const ID = @"BFDHomeTableViewCell";

@interface BFDMoreCarViewController ()<UITableViewDelegate, UITableViewDataSource, BFDConfigSelectViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    NSInteger _pageCount;
}

@property (nonatomic, weak) BFDConfigSelectView *configView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSMutableArray *brandAry;
@property (nonatomic, strong) NSMutableArray *priceAry;

@property (nonatomic, copy) NSString *price;

@end

@implementation BFDMoreCarViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, RSS(titleH), kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight - titleH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        
        _tableView.mj_header = [BFDGifHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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

-(NSMutableArray *)brandAry{
    if (!_brandAry) {
        _brandAry = [NSMutableArray array];
    }
    return _brandAry;
}

-(NSMutableArray *)priceAry{
    if (!_priceAry) {
        _priceAry = [NSMutableArray array];
    }
    return _priceAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.price = @"";
    
    NSString *leftTitle = @"";
    NSString *rightTitle = @"";
    if (self.classType == ClassTypeBrand) {
        leftTitle = @"类型";
        rightTitle = @"价格";
    }else if (self.classType == ClassTypeCLass){
        leftTitle = @"价格";
        rightTitle = @"品牌";
    }
    
    BFDConfigSelectView *configView = [[BFDConfigSelectView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(44)) leftTitle:leftTitle rightTitle:rightTitle];
    configView.delegate = self;
    self.configView = configView;
    [self.view addSubview:configView];
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    [self getConfig];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"CarListView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CarListView"];
    
    [self.configView hiddenView];
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
    
    BFDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CarModel *model = self.dataAry[indexPath.row];
    if (indexPath.row % 2 == 0) {
        model.isRight = NO;
    }else{
        model.isRight = YES;
    }
    cell.model = model;
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RSS(250);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MobClick event:@"selectCar"];
    
}

#pragma mark - DZNEmptyDataSetSource , DZNEmptyDataSetDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"\n这里空空如也...";
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

#pragma mrak - BFDConfigSelectViewDelegate
-(void)selectConfigWithModel:(BFDConfigModel *)model{
    if (model.isClass) {
        self.brandID = model.brand_id;
    }else if (model.isBrand){
        self.classID = model.class_id;
    }else if (model.isPrice){
        self.price = model.price;
    }
    
    [self loadData];
}

-(void)getData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_pageCount] forKey:@"page"];
    
    [params setObject:self.brandID forKey:@"brand_id"];
    [params setObject:self.classID forKey:@"class_id"];
    [params setObject:self.price forKey:@"price"];
    
    [JKHttpRequestService POST:@"/Home/Class/getListByBrandAndPrice" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (succe) {
            for (NSDictionary *dic in responseObject[@"data"][@"car_list"]) {
                CarModel *model = [CarModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
            [self.tableView reloadData];

            if (self.dataAry.count >= [responseObject[@"data"][@"count"] intValue]) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
        }
    } failure:^(void) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } animated:NO];
}

#pragma mark - 配置
-(void)getConfig{
    
    NSString *type = @"";
    if (self.classType == ClassTypeBrand) {
        type = @"2";
    }else if (self.classType == ClassTypeCLass){
        type = @"3";
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:type forKey:@"type"];
    
    [JKHttpRequestService POST:@"/Home/Goods/selectGoodsBrand" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
        if (succe) {
            
            if (self.classType == ClassTypeBrand) {
                for (NSDictionary *dic in jsonDic[@"data"][@"category_name"]) {
                    BFDConfigModel *model = [BFDConfigModel mj_objectWithKeyValues:dic];
                    model.isBrand = YES;
                    [self.brandAry addObject:model];
                }
            }else if (self.classType == ClassTypeCLass){
                for (NSDictionary *dic in jsonDic[@"data"][@"brand"]) {
                    BFDConfigModel *model = [BFDConfigModel mj_objectWithKeyValues:dic];
                    model.isClass = YES;
                    [self.brandAry addObject:model];
                }
            }
            
            for (NSString *price in jsonDic[@"data"][@"price_range"]) {
                BFDConfigModel *model = [[BFDConfigModel alloc] init];
                model.price = price;
                model.isPrice = YES;
                [self.priceAry addObject:model];
            }
            
            if (self.classType == ClassTypeBrand) {
                [self.configView setDataWithLeftAry:self.brandAry rightAry:self.priceAry];
            }else if (self.classType == ClassTypeCLass){
                [self.configView setDataWithLeftAry:self.priceAry rightAry:self.brandAry];
            }
            
        }
    } failure:^(void) {
        
    } animated:NO];
}


@end
