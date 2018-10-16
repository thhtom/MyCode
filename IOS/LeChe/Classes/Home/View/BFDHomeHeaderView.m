//
//  BFDHomeHeaderView.m
//  LeChe
//
//  Created by yangxuran on 2018/9/17.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDHomeHeaderView.h"
#import "JYCarousel.h"
#import "BFDHomeBrandCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "HomeBannerModel.h"
#import "BFDBrandModel.h"

static NSString *const ID = @"BFDHomeBrandCollectionViewCell";

@interface BFDHomeHeaderView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *brandAry;

@end

@implementation BFDHomeHeaderView

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(RSS(74), RSS(90));
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(180)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BFDHomeBrandCollectionViewCell class] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
}

-(NSMutableArray *)brandAry{
    if (!_brandAry) {
        _brandAry = [NSMutableArray array];
    }
    return _brandAry;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(225)) delegate:self placeholderImage:[UIImage imageNamed:@"banner_placeholder"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.hidesForSinglePage = NO;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
    
    UIView *brandView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), kUIScreenWidth, RSS(239))];
    brandView.backgroundColor = [UIColor whiteColor];
    [self addSubview:brandView];
    
    UILabel *label = [QuickCreate createLabelWithFrame:CGRectMake(RSS(15), RSS(17), 100, RSS(16)) text:@"| 热门品类" textColor:RGBA(51, 51, 51, 1) fontSize:16 textAlignment:NSTextAlignmentLeft numberOfLines:1 isBold:YES];
    [brandView addSubview:label];
    
    self.collectionView.y = CGRectGetMaxY(label.frame) + RSS(17);
    [brandView addSubview:self.collectionView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, brandView.height - RSS(10), kUIScreenWidth, RSS(10))];
    lineView.backgroundColor = RGBA(245, 245, 245, 1);
    [brandView addSubview:lineView];
}

#pragma mark - 赋值
-(void)configDataWithBannerAry:(NSArray *)bannerAry brandAry:(NSArray *)brandAry{
    
    NSMutableArray *imgAry = [NSMutableArray array];
    for (HomeBannerModel *model in bannerAry) {
        [imgAry addObject:model.pic_url];
    }
    self.cycleScrollView.imageURLStringsGroup = imgAry;
    
    [self.brandAry removeAllObjects];
    [self.brandAry addObjectsFromArray:brandAry];
    BFDBrandModel *model = [[BFDBrandModel alloc] init];
    model.brand_logo = @"brand_more";
    model.brand_name = @"更多";
    model.isLast = YES;
    [self.brandAry addObject:model];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.brandAry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFDHomeBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.model = self.brandAry[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(brandClick:)]) {
        [self.delegate brandClick:indexPath.row];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

@end
