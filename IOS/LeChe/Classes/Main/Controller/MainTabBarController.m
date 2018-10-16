//
//  MainTabBarController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"

#import "BFDHomeViewController.h"
#import "ServeViewController.h"
#import "MineViewController.h"

static NSString *const kBundleVersionKey = @"CFBundleShortVersionString";

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTabBar];
    
    [self addChildViewControllers];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkVersion];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenFailedAction) name:kUserTokenFailNotification object:nil];
}

-(void)tokenFailedAction{
    MainNavigationController *navVC = self.viewControllers[self.selectedIndex];
    [navVC popToRootViewControllerAnimated:NO];
    self.selectedIndex = 0;
}


//版本检测
- (void)checkVersion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"2" forKey:@"type"];
    [params setObject:[AppUtil getAPPVersion] forKey:@"version"];
    
    [JKHttpRequestService POST:@"/Home/Common/getVersion" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            
            int value = [jsonDic[@"data"][@"status"] intValue];
            
            if (value == 0) { //最新版本
                
            }else{ //不是最新版本
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"发现新版本" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *appstoreUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", kAppID];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl] options:@{} completionHandler:nil];
                    if (value == 2) {
                        exit(0);
                    }
                }]];
                if (value == 1) { //非强制更新
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                }
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }
    } failure:^(void) {
        
    } animated:NO];
}

- (void)configureTabBar
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : RGBColor(153, 153, 153)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBA(232, 202, 126, 1)} forState:UIControlStateSelected];
    
    // TabBar背景色
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kTabbarHeight)];
    bgView.backgroundColor = RGBA(51, 51, 51, 1);
    [self.tabBar insertSubview:bgView atIndex:0];
    
    self.delegate = self;
}

- (void)addChildViewControllers{
    
    [self addChildViewController:@"BFDHomeViewController" title:@"首页" imageName:@"tabbar_home"];
    [self addChildViewController:@"ServeViewController" title:@"服务" imageName:@"tabbar_serve"];
    [self addChildViewController:@"MineViewController" title:@"我的" imageName:@"tabbar_mine"];
}

#pragma mark 添加子视图控制器详细方法
- (void)addChildViewController:(NSString *)childVCString title:(NSString *)title imageName:(NSString *)icon
{
    Class childClass = NSClassFromString(childVCString);
    UIViewController *childController = [[childClass alloc] init];
    UITabBarItem *item = childController.tabBarItem;
    
    UIImage *iconImage = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString *selectImageName = [icon stringByAppendingString:@"_selected"];
    UIImage *selectIconImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item.image = iconImage;
    item.selectedImage = selectIconImage;
    
    childController.title = title;
    
    MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    /*
    MainNavigationController *nav = (MainNavigationController *)viewController;
    UIViewController *selectedVc = [nav.viewControllers firstObject];
        if ([selectedVc isKindOfClass:[MineViewController class]] && !kUserLogin) {
            [ShowLoginManager showLoginVcFrom:self];
            return NO;
        }
    */
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
