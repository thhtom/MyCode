//
//  BFDHomeViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/9/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDHomeViewController.h"
#import "BFDHomeHeaderView.h"
#import "HomeCarTableViewCell.h"
#import "BFDHomeTableViewCell.h"
#import "HomeBannerModel.h"
#import "HomeListModel.h"
#import "CarModel.h"
#import "BFDBrandModel.h"
#import "BFDAllBrandViewController.h"
#import "BFDMoreCarViewController.h"
#import "BFDHomeDetailViewController.h"

static NSString *const ID = @"BFDHomeTableViewCell";

@interface BFDHomeViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, BFDHomeHeaderViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) BFDHomeHeaderView *headerView;
@property (nonatomic, strong) UIScrollView *subScrollerView;

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, strong) NSMutableArray *btnAry;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *lastSelectedBtn;

@property (nonatomic, strong) NSMutableArray *tableAry;
@property (nonatomic, strong) NSMutableArray *carAry;
@property (nonatomic, strong) UITableView *currentTableView;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, weak) UIView *footerView;

@property (nonatomic, strong) NSMutableArray *bannerAry;
@property (nonatomic, strong) NSMutableArray *brandAry;

@end

@implementation BFDHomeViewController

-(UIScrollView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kTabbarHeight)];
        _scrollerView.backgroundColor = RGBA(245, 245, 245, 1);
        _scrollerView.mj_header = [BFDGifHeader headerWithRefreshingBlock:^{
            [self getData];
        }];
    }
    return _scrollerView;
}

-(BFDHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[BFDHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(464))];
        _headerView.delegate = self;
    }
    return _headerView;
}

-(UIScrollView *)subScrollerView{
    if (!_subScrollerView) {
        _subScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), kUIScreenWidth, RSS(750))];
        _subScrollerView.backgroundColor = [UIColor whiteColor];
        _subScrollerView.contentSize = CGSizeMake(kUIScreenWidth * 3, RSS(750));
        _subScrollerView.bounces = NO;
        _subScrollerView.showsHorizontalScrollIndicator = NO;
        _subScrollerView.delegate = self;
        _subScrollerView.pagingEnabled = YES;
    }
    return _subScrollerView;
}

-(NSMutableArray *)btnAry{
    if (!_btnAry) {
        _btnAry = [NSMutableArray array];
    }
    return _btnAry;
}

-(NSMutableArray *)carAry{
    if (!_carAry) {
        _carAry = [NSMutableArray array];
    }
    return _carAry;
}

-(NSMutableArray *)tableAry{
    if (!_tableAry) {
        _tableAry = [NSMutableArray array];
    }
    return _tableAry;
}

-(NSMutableArray *)bannerAry{
    if (!_bannerAry) {
        _bannerAry = [NSMutableArray array];
    }
    return _bannerAry;
}

-(NSMutableArray *)brandAry{
    if (!_brandAry) {
        _brandAry = [NSMutableArray array];
    }
    return _brandAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUI];
    
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"HomeView"];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"HomeView"];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)createUI{
    
    [self.view addSubview:self.scrollerView];
    
    [self.scrollerView addSubview:self.headerView];
    
    [self createTitleView];
    
    [self.scrollerView addSubview:self.subScrollerView];
    
    UIView *footerView = [self createFooterViewWithFram:CGRectMake(0, CGRectGetMaxY(self.subScrollerView.frame), kUIScreenWidth, 143)];
    [self.scrollerView addSubview:footerView];
    
    self.scrollerView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(footerView.frame));
}

#pragma mark - titleView
-(void)createTitleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kUIScreenWidth, RSS(49))];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.scrollerView addSubview:titleView];
    self.titleView = titleView;
}

-(void)setupTitles{
    
    [self.btnAry removeAllObjects];
    for (UIView *subView in self.titleView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:self.titleView.bounds];
    CGFloat btnW = RSS(50);
    for (int i = 0; i < self.carAry.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0, btnW, view.height);
        HomeListModel *model = self.carAry[i];
        [btn setTitle:model.class_name forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:RSS(14)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [self.btnAry addObject:btn];
        [view addSubview:btn];
        if (i == 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, RSS(41), RSS(26), RSS(2))];
            lineView.backgroundColor = RGBA(51, 51, 51, 1);
            [view addSubview:lineView];
            self.lineView = lineView;
            lineView.centerX = btn.centerX;
            [self setSelectBtn:btn];
            self.lastSelectedBtn = btn;
            self.subScrollerView.contentOffset = CGPointMake(i * kUIScreenWidth, 0);
            self.selectIndex = i;
        }
    }
    view.width = btnW * self.carAry.count;
    view.center = CGPointMake(self.titleView.width / 2, self.titleView.height / 2);
    
    [self.titleView addSubview:view];
}

#pragma mark - 跑车 轿车 SUV 点击事件
-(void)btnClick:(UIButton *)btn{
    
    [self.lastSelectedBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    self.lastSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:RSS(14)];
    
    [self setSelectBtn:btn];
    self.lineView.centerX = btn.centerX;
    self.lastSelectedBtn = btn;
    
    NSInteger index = [self.btnAry indexOfObject:btn];
    self.subScrollerView.contentOffset = CGPointMake(index * kUIScreenWidth, 0);
    
    self.selectIndex = btn.tag - 100;
    self.currentTableView = (UITableView *)[self.subScrollerView viewWithTag:self.selectIndex + 200];

    if (self.carAry.count > 0) {
        HomeListModel *listModel = self.carAry[self.selectIndex];
        self.subScrollerView.contentSize = CGSizeMake(kUIScreenWidth * 3, RSS(250) * listModel.car_list.count);
        self.subScrollerView.height = RSS(250) * listModel.car_list.count;
        
        self.footerView.frame = CGRectMake(0, CGRectGetMaxY(self.subScrollerView.frame), kUIScreenWidth, 143);
        self.scrollerView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(self.footerView.frame));
    }
    [self.currentTableView reloadData];
}

-(void)setSelectBtn:(UIButton *)btn{
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
}

#pragma mark - FooterView
-(UIView *)createFooterViewWithFram:(CGRect)frame{
    
    UIView *footerView = [[UIView alloc] initWithFrame:frame];
    self.footerView = footerView;
    
    UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 49)];
    moreView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:moreView];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBtn sizeToFit];
    moreBtn.center = moreView.center;
    [moreBtn click:^(id value) {
        BFDMoreCarViewController *moreVC = [[BFDMoreCarViewController alloc] init];
        moreVC.classType = ClassTypeCLass;
        HomeListModel *model = self.carAry[self.selectIndex];
        moreVC.title = [NSString stringWithFormat:@"%@专区",model.class_name];
        moreVC.classID = model.class_id;
        moreVC.brandID = @"";
        [self.navigationController pushViewController:moreVC animated:YES];
    }];
    [moreView addSubview:moreBtn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moreView.frame), kUIScreenWidth, 94)];
    bottomView.backgroundColor = RGBA(245, 245, 245, 1);
    [footerView addSubview:bottomView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18, 22, 22)];
    iconImageView.centerX = footerView.centerX;
    iconImageView.image = [UIImage imageNamed:@"logo"];
    [bottomView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImageView.frame) + 7, kUIScreenWidth, 11)];
    titleLabel.text = @"如鲸，高端购车平台";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.textColor = RGBA(204, 204, 204, 1);
    [bottomView addSubview:titleLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 5, kUIScreenWidth, 11)];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.text = @"联系我们: 400-9696-726";
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.textColor = RGBA(204, 204, 204, 1);
    [bottomView addSubview:phoneLabel];
    
    return footerView;
}


-(void)createClass{
    
    [self setupTitles];
    
    for (int i = 0; i < 3; i ++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * kUIScreenWidth, 0, kUIScreenWidth, _subScrollerView.height) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.tag = i + 200;
        [self.tableAry addObject:tableView];
        [self.subScrollerView addSubview:tableView];
        if (i == 0) {
            self.currentTableView = tableView;
        }
    }
    
    [self.currentTableView reloadData];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.carAry.count > 0) {
        HomeListModel *listModel = self.carAry[self.selectIndex];
        return [listModel.car_list count];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFDHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HomeListModel *listModel = self.carAry[self.selectIndex];
    cell.model = listModel.car_list[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RSS(250);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MobClick event:@"selectCar"];
    
    BFDHomeDetailViewController *detailVC = [[BFDHomeDetailViewController alloc] init];
    HomeListModel *model = self.carAry[self.selectIndex];
    detailVC.good_id = [model.car_list[indexPath.row] carID];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetX  = scrollView.contentOffset.x;
    NSInteger index = offsetX / kUIScreenWidth;
    UIButton *selectBtn = self.btnAry[index];
    [self btnClick:selectBtn];
}

#pragma mark - BFDHomeHeaderViewDelegate
-(void)brandClick:(NSInteger)index{
    
    if (index == self.brandAry.count) {
        BFDAllBrandViewController *allBrandVC = [[BFDAllBrandViewController alloc] init];
        [self.navigationController pushViewController:allBrandVC animated:YES];
    }else{
        BFDMoreCarViewController *moreVC = [[BFDMoreCarViewController alloc] init];
        moreVC.classType = ClassTypeBrand;
        BFDBrandModel *model = self.brandAry[index];
        moreVC.title = model.brand_name;
        moreVC.brandID = model.brand_id;
        moreVC.classID = @"";
        [self.navigationController pushViewController:moreVC animated:YES];
    }
}

#pragma mark - 网络请求
-(void)getData{

    [BOCProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [JKHttpRequestService POST:@"/Home/Index/appHome" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
        [self.scrollerView.mj_header endRefreshing];
        [BOCProgressHUD boc_hiddenHUD];
        
        if (succe) {
            
            [self.bannerAry removeAllObjects];
            [self.brandAry removeAllObjects];
            [self.carAry removeAllObjects];
            
            for (UITableView *tableView in self.tableAry) {
                [tableView removeFromSuperview];
            }
            [self.tableAry removeAllObjects];
            
            //banner
            for (NSDictionary *dic in jsonDic[@"data"][@"bananer"]) {
                HomeBannerModel *model = [HomeBannerModel mj_objectWithKeyValues:dic];
                [self.bannerAry addObject:model];
            }
            
            //brand
            for (NSDictionary *dic in jsonDic[@"data"][@"brand"]) {
                BFDBrandModel *model = [BFDBrandModel mj_objectWithKeyValues:dic];
                [self.brandAry addObject:model];
            }
            
            //car
            for (NSDictionary *dic in responseObject[@"data"][@"category_list"]) {
                HomeListModel *model = [HomeListModel mj_objectWithKeyValues:dic];
                [self.carAry addObject:model];
            }
            
            //banner  brand赋值
            [self.headerView configDataWithBannerAry:self.bannerAry brandAry:self.brandAry];
            
            [self createClass];
            
            HomeListModel *listModel = self.carAry[self.selectIndex];
            self.subScrollerView.contentSize = CGSizeMake(kUIScreenWidth * self.carAry.count, RSS(250) * listModel.car_list.count);
            self.subScrollerView.height = RSS(250) * listModel.car_list.count;
            
            self.footerView.frame = CGRectMake(0, CGRectGetMaxY(self.subScrollerView.frame), kUIScreenWidth, 143);
            self.scrollerView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(self.footerView.frame));
        }
    } failure:^(void) {
        [self.scrollerView.mj_header endRefreshing];
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}



@end
