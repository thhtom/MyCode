//
//  BFDConfigSelectView.m
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDConfigSelectView.h"
#import "BFDConfigCollectionViewCell.h"
#import "BFDConfigModel.h"

static CGFloat const titleH = 44;
static NSString *const ID = @"BFDConfigCollectionViewCell";

@interface BFDConfigSelectView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, copy) NSArray *leftDataAry;
@property (nonatomic, copy) NSArray *rightDataAry;
@property (nonatomic, copy) NSArray *currentDataAry;
@property (nonatomic, copy) NSString *leftStr;
@property (nonatomic, copy) NSString *rightStr;

@property (nonatomic, strong) BFDConfigModel *lastSelectedModel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UIView *coverView;

@end

@implementation BFDConfigSelectView

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(RSS(100), RSS(30));
        layout.minimumInteritemSpacing = RSS(18);
        layout.minimumLineSpacing = RSS(15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + RSS(titleH), kUIScreenWidth, RSS(110)) collectionViewLayout:layout];
        _collectionView.backgroundColor = RGBA(102, 102, 102, 1);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BFDConfigCollectionViewCell class] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    if (self = [super initWithFrame:frame]) {
        [self createUIWithLeftTitle:leftTitle rightTitle:rightTitle];
    }
    return self;
}

-(void)createUIWithLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    
    self.backgroundColor = RGBA(51, 51, 51, 1);

    CGFloat btnW = kUIScreenWidth / 2;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, btnW, RSS(titleH));
    [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setImage:Img(@"arrow_down_white") forState:UIControlStateNormal];
    leftBtn.titleLabel.font = Font(RSS(14));
    leftBtn.backgroundColor = RGBA(51, 51, 51, 1);
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //调整图片文字的位置
    [leftBtn buttonImageOnRight];
    [self addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(btnW, 0, btnW, RSS(titleH));
    [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setImage:Img(@"arrow_down_white") forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font(RSS(14));
    rightBtn.backgroundColor = RGBA(51, 51, 51, 1);
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //调整图片文字的位置
    [rightBtn buttonImageOnRight];
    [self addSubview:rightBtn];
    self.rightBtn = rightBtn;
}

-(void)leftBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    self.lastSelectedModel = nil;
    
    if (self.rightBtn.selected) {
        self.rightBtn.selected = NO;
        self.rightBtn.backgroundColor = RGBA(51, 51, 51, 1);
        self.rightBtn.imageView.transform = CGAffineTransformIdentity;
        self.rightDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
    }
    
    if (btn.selected) {
        btn.backgroundColor = RGBA(102, 102, 102, 1);
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        [kWindow addSubview:self.collectionView];
        self.currentDataAry = self.leftDataAry;
        NSInteger column = (self.currentDataAry.count % 3 == 0) ? self.currentDataAry.count / 3 : (self.currentDataAry.count / 3 + 1);
        self.collectionView.height = column * RSS(30) + (column + 1) * RSS(15);
        for (BFDConfigModel *model in self.currentDataAry) {
            if (model.selected) {
                self.lastSelectedModel = model;
            }
        }
        [self.collectionView reloadData];
        
    }else{
        btn.backgroundColor = RGBA(51, 51, 51, 1);
        btn.imageView.transform = CGAffineTransformIdentity;
        [self.collectionView removeFromSuperview];
        self.leftDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
    }
}

-(void)rightBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    self.lastSelectedModel = nil;
    
    if (self.leftBtn.selected) {
        self.leftBtn.selected = NO;
        self.leftBtn.backgroundColor = RGBA(51, 51, 51, 1);
        self.leftBtn.imageView.transform = CGAffineTransformIdentity;
        self.leftDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
    }
    
    if (btn.selected) {
        btn.backgroundColor = RGBA(102, 102, 102, 1);
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        [kWindow addSubview:self.collectionView];
        self.currentDataAry = self.rightDataAry;
        NSInteger column = (self.currentDataAry.count % 3 == 0) ? self.currentDataAry.count / 3 : (self.currentDataAry.count / 3 + 1);
        self.collectionView.height = column * RSS(30) + (column + 1) * RSS(15);
        for (BFDConfigModel *model in self.currentDataAry) {
            if (model.selected) {
                self.lastSelectedModel = model;
            }
        }
    
        [self.collectionView reloadData];
        
    }else{
        btn.backgroundColor = RGBA(51, 51, 51, 1);
        btn.imageView.transform = CGAffineTransformIdentity;
        [self.collectionView removeFromSuperview];
        self.rightDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
    }
}

-(void)hiddenView{
    
    if (self.leftBtn.selected) {
        [self.leftBtn buttonImageOnRight];
        self.leftDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
        [self.collectionView removeFromSuperview];
        self.leftBtn.selected = NO;
        self.leftBtn.backgroundColor = RGBA(51, 51, 51, 1);
        self.leftBtn.imageView.transform = CGAffineTransformIdentity;
    }else{
        [self.rightBtn buttonImageOnRight];
        self.rightDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
        [self.collectionView removeFromSuperview];
        self.rightBtn.selected = NO;
        self.rightBtn.backgroundColor = RGBA(51, 51, 51, 1);
        self.rightBtn.imageView.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - 赋值
-(void)setDataWithLeftAry:(NSArray *)leftAry rightAry:(NSArray *)rightAry{
    self.leftDataAry = leftAry;
    self.rightDataAry = rightAry;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.currentDataAry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFDConfigCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.model = self.currentDataAry[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(RSS(15), RSS(18), 0, RSS(18));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //更新model
    self.lastSelectedModel.selected = NO;
    
    BFDConfigModel *model = self.currentDataAry[indexPath.row];
    model.selected = YES;
    [self.collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(selectConfigWithModel:)]) {
        [self.delegate selectConfigWithModel:model];
    }
    
    self.lastSelectedModel = model;
    
    //更新按钮文字
    NSString *title = @"";
    if (model.isClass) {
        title = model.brand_name;
    }else if (model.isBrand){
        title = model.name;
    }else if (model.isPrice){
        title = model.price;
    }
    if (self.leftBtn.selected) {
        [self.leftBtn setTitle:title forState:UIControlStateNormal];
        [self.leftBtn buttonImageOnRight];
        self.leftDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
        [self.collectionView removeFromSuperview];
        self.leftBtn.selected = NO;
        self.leftBtn.backgroundColor = RGBA(51, 51, 51, 1);
        self.leftBtn.imageView.transform = CGAffineTransformIdentity;
    }else{
        [self.rightBtn setTitle:title forState:UIControlStateNormal];
        [self.rightBtn buttonImageOnRight];
        self.rightDataAry = [NSMutableArray arrayWithArray:self.currentDataAry];
        [self.collectionView removeFromSuperview];
        self.rightBtn.selected = NO;
        self.rightBtn.backgroundColor = RGBA(51, 51, 51, 1);
        self.rightBtn.imageView.transform = CGAffineTransformIdentity;
    }
}

@end
