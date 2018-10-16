//
//  WelcomeViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainTabBarController.h"
#import "MainNavigationController.h"

#define kPageCount 3

@interface WelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollImages];
}

- (void)addScrollImages
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(kUIScreenWidth * kPageCount, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((kUIScreenWidth - 40) / 2, kUIScreenHeight - kSafeBottomHeight - RSS(30), 50, RSS(10))];
    pageControl.numberOfPages = kPageCount;
    pageControl.pageIndicatorTintColor = RGBA(51, 51, 51, 1);
    pageControl.currentPageIndicatorTintColor = RGBA(151, 135, 92, 1);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    for (int i = 0; i < kPageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 1.显示图片
        NSString *name = @"";
        if (kStatusBarHeight > 20) {
            name = [NSString stringWithFormat:@"welcome_iphoneX_%d", i];
        }else{
            name = [NSString stringWithFormat:@"welcome_%d", i];
        }
        imageView.image = [UIImage imageNamed:name];
        imageView.userInteractionEnabled = YES;
        // 2.设置frame
        imageView.frame = CGRectMake(self.view.width * i, 0, self.view.width, self.view.height);
        [self.scrollView addSubview:imageView];
        
        if (i == kPageCount - 1) {
            [imageView addTapGesture:^{
                MainTabBarController *mainVC = [[MainTabBarController alloc]init];
                self.view.window.rootViewController = mainVC;
            }];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > kUIScreenWidth) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / kUIScreenWidth;
    self.pageControl.currentPage = page;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
