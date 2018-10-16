//
//  BFDCollectionViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCollectionViewController.h"
#import "BFDBrowsingHistoryViewController.h"
#import "BFDMyCollectionViewController.h"

@interface BFDCollectionViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *btnAry;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation BFDCollectionViewController

-(NSMutableArray *)btnAry{
    if (!_btnAry) {
        _btnAry = [NSMutableArray array];
    }
    return _btnAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTitleView];
    [self createChildViewController];
}

-(void)createTitleView{
    
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RSS(190), 32)];
    segmentView.backgroundColor = RGBA(51, 51, 51, 1);
    segmentView.layer.borderWidth = 0.5;
    segmentView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.navigationItem.titleView = segmentView;
    
    NSArray *titleAry = @[@"浏览记录",@"我的收藏"];
    for (int i = 0; i < 2; i++) {
        CGFloat margin = 0;
        CGFloat btnW = (segmentView.width - margin * 2) / 2;
        CGFloat btnH = segmentView.height - margin * 2;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(margin + btnW * i, margin, segmentView.width / 2, btnH);
        [btn setTitle:titleAry[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:RSS(16)];
        
        if (i == self.index) {
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [self.btnAry addObject:btn];
        
        [segmentView addSubview:btn];
    }
}

-(void)createChildViewController{
    
    BFDBrowsingHistoryViewController *browsVC = [[BFDBrowsingHistoryViewController alloc] init];
    BFDMyCollectionViewController *myCollectVC = [[BFDMyCollectionViewController alloc] init];
    
    [self addChildViewController:browsVC];
    [self addChildViewController:myCollectVC];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth ,kUIScreenHeight - kNavigationBarHeight)];
    scrollView.contentSize = CGSizeMake(kUIScreenWidth * 2, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.scrollEnabled = NO;
    browsVC.view.frame = CGRectMake(0, 0, kUIScreenWidth, scrollView.height);
    myCollectVC.view.frame = CGRectMake(kUIScreenWidth, 0, kUIScreenWidth, scrollView.height);
    
    scrollView.contentOffset = CGPointMake(kUIScreenWidth * self.index, 0);
    
    [scrollView addSubview:browsVC.view];
    [scrollView addSubview:myCollectVC.view];
    
    self.scrollView = scrollView;
    
    [self.view addSubview:scrollView];
}

-(void)btnClick:(UIButton *)sender{
    //按钮设置
    for (UIButton *btn in self.btnAry) {
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:kFirstTextColor forState:UIControlStateNormal];
    //页面切换
    self.scrollView.contentOffset = CGPointMake(kUIScreenWidth * (sender.tag - 100), 0);
}


#pragma mark - UIScrollViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    int index = scrollView.contentOffset.x / kUIScreenWidth;
//
//    for (int i = 0; i < self.btnAry.count; i++) {
//        UIButton *btn = self.btnAry[i];
//        if (i == index) {
//            btn.backgroundColor = [UIColor whiteColor];
//            [btn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
//        }else{
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor clearColor];
//        }
//    }
//}

@end
