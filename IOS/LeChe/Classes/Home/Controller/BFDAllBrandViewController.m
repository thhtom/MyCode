//
//  BFDAllBrandViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/9/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDAllBrandViewController.h"
#import "BFDAllBrandCollectionViewCell.h"
#import "BFDConfigModel.h"
#import "BFDMoreCarViewController.h"

static NSString *const ID = @"BFDAllBrandCollectionViewCell";

@interface BFDAllBrandViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation BFDAllBrandViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(RSS(93), RSS(100));
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.emptyDataSetSource = self;
        [_collectionView registerClass:[BFDAllBrandCollectionViewCell class] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
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
    self.title = @"所有品牌";
    
    [self.view addSubview:self.collectionView];
    
    [self getConfig];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFDAllBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.model = self.dataAry[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BFDMoreCarViewController *moreVC = [[BFDMoreCarViewController alloc] init];
    BFDConfigModel *model = self.dataAry[indexPath.row];
    moreVC.brandID = model.brand_id;
    moreVC.classID = @"";
    moreVC.title = model.brand_name;
    moreVC.classType = ClassTypeBrand;
    [self.navigationController pushViewController:moreVC animated:YES];
}


#pragma mark - 配置
-(void)getConfig{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type"];
    
    [JKHttpRequestService POST:@"/Home/Goods/selectGoodsBrand" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
        if (succe) {
            
            for (NSDictionary *dic in jsonDic[@"data"][@"brand"]) {
                BFDConfigModel *model = [BFDConfigModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
            
            [self.collectionView reloadData];
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
