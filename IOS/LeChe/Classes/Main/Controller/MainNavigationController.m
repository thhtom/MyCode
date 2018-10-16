//
//  MainNavigationController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)initialize
{
    [self setNavigationItemTheme];
    [self setNavigationBarTheme];
}

+ (void)setNavigationItemTheme
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [barItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

+ (void)setNavigationBarTheme
{
    // 取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setTintColor:[UIColor whiteColor]];

    //设置导航栏背景颜色
    [navBar setBarTintColor:RGBA(51, 51, 51, 1)];
    navBar.translucent = NO;
    
    // 设置导航栏标题颜色
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [navBar setTitleTextAttributes:textAttributes];
    
    //去除导航下面的线
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
}


-(void)popself
{
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 0){
        UIImage *image = [UIImage imageNamed:@"navbar_back_white"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(nullable UIView*)view{
    return CGPointMake(kUIScreenWidth / 2, 0);
}

@end
