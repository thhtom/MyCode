//
//  BFDDeployDetailViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/4/17.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDDeployDetailViewController.h"
#import "BFDDeployDetailTableViewCell.h"
#import "BFDDeployModel.h"
#import "BFDDeployDetailModel.h"

@interface BFDDeployDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation BFDDeployDetailViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [BFDGifHeader headerWithRefreshingBlock:^{
            [self requestData];
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
    self.title = @"配置信息";
    
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    [self createFooterView];
    
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"DeployView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"DeployView"];
}

-(void)createFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 60)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, kUIScreenWidth - 60, 20)];
    lable.text = @"以上参数配置信息仅供参考，具体参数配置信息以店内销售车辆为准，最终解释权归如鲸购车所有。";
    lable.textColor = RGBColor(153, 153, 153);
    lable.font = [UIFont systemFontOfSize:11];
    lable.numberOfLines = 0;
    [lable sizeToFit];
    lable.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:lable];
    
    self.tableView.tableFooterView = footerView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFDDeployModel *model = self.dataAry[section];
    return model.isHidden ? 0 : model.group_list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDDeployDetailTableViewCell *cell = [BFDDeployDetailTableViewCell cellWithTableView:tableView];
    BFDDeployModel *model = self.dataAry[indexPath.section];
    cell.model = model.group_list[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BFDDeployModel *model = self.dataAry[section];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = RGBA(153, 153, 153, 1);
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 100, 34)];
    sectionLabel.textColor = [UIColor whiteColor];
    sectionLabel.font = [UIFont systemFontOfSize:11];
    sectionLabel.text = [self.dataAry[section] group_name];
    [headerView addSubview:sectionLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUIScreenWidth - 166, 0, 100, 34)];
    detailLabel.textColor = RGBA(204, 204, 204, 1);
    detailLabel.font = [UIFont systemFontOfSize:11];
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.text = @"⊙ 标配       - 无";
    [headerView addSubview:detailLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(RSS(335), 0, RSS(17), 34);
    [btn setImage:Img(@"arrow_down_white") forState:UIControlStateNormal];
    if (model.isHidden) {
         btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else{
        btn.imageView.transform = CGAffineTransformIdentity;
    }
    [headerView addSubview:btn];
    //header点击
    [headerView addTapGesture:^{
        model.isHidden = !model.isHidden;
        [self.tableView reloadData];
    }];

    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


#pragma mark - 数据
-(void)requestData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.g_id forKey:@"g_id"];
    
    [JKHttpRequestService POST:@"/Home/Goods/getConfDetail" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [self.tableView.mj_header endRefreshing];
        if (succe) {
            [self.dataAry removeAllObjects];
            for (NSDictionary *dic in jsonDic[@"data"]) {
                BFDDeployModel *model = [BFDDeployModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
            [self.tableView reloadData];
        }
    } failure:^{
        [self.tableView.mj_header endRefreshing];
    } animated:NO];
    
}

@end
