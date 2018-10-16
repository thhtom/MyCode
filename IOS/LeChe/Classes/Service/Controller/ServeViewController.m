//
//  ServeViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "ServeViewController.h"
#import "ServeCollectionViewCell.h"

static NSString *const cellID = @"ServeCellID";
static NSString *const headerID = @"ServeHeaderID";
static NSString *const footerID = @"ServeFooterID";
static NSInteger const count = 3;
static CGFloat const footerImgScale = 70 / 77.0;

@interface ServeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataAry;

@end

@implementation ServeViewController

#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kTabbarHeight) collectionViewLayout:layout];
//        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundView = [[UIView alloc] init];
        [_collectionView.backgroundView addGradientWithStartColor:RGBA(232, 202, 126, 1) endColor:RGBA(160, 123, 60, 1)];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ServeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"ServeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
    }
    return _collectionView;
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataAry = @[
        @{@"title":@"分期计算器",@"image":@"serve_calculator",@"controller":@"BFDCalculatorViewController"},
        @{@"title":@"汽车资讯",@"image":@"serve_carNews",@"controller":@"BFDCarNewsViewController"},
//        @{@"title":@"违章查询",@"image":@"serve_violation",@"controller":@""},
//        @{@"title":@"保险服务",@"image":@"serve_insurance",@"controller":@""},
//        @{@"title":@"保养维修",@"image":@"serve_maintenance",@"controller":@""},
        @{@"title":@"常见问题",@"image":@"serve_problem",@"controller":@"BFDCommonProblemViewController"}];
    [self.view addSubview:self.collectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ServeView"];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ServeView"];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ServeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.dataDic = self.dataAry[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, RSS(55), kUIScreenWidth, RSS(30))];
        label.font = [UIFont boldSystemFontOfSize:RSS(31)];
        label.text = @"车主服务";
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
        
        return view;
    }else{
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, kUIScreenWidth, 30)];
        bgImageView.image = [UIImage imageNamed:@"serve_section_bg"];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgImageView.width, 30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"购车流程";
        titleLabel.font = [UIFont systemFontOfSize:20];
        [bgImageView addSubview:titleLabel];
        [view addSubview:bgImageView];
        
        UIImageView *processImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(bgImageView.frame) + 20, kUIScreenWidth - 24, (kUIScreenWidth - 24) / footerImgScale + 20)];
        processImg.image = Img(@"serve_home");
        processImg.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:processImg];
    }
    return view;
}


#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataAry[indexPath.row];
    if ([dic[@"controller"] length] == 0) {
        [BOCProgressHUD boc_showText:@"敬请期待"];
        return;
    }
    Class class = NSClassFromString(dic[@"controller"]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kUIScreenWidth - (count + 1) * 11) / count , RSS(90));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kUIScreenWidth, RSS(120));
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kUIScreenWidth, (kUIScreenWidth - 24) / footerImgScale + 105);
}


@end
