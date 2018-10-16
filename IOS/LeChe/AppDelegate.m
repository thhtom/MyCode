//
//  AppDelegate.m
//  LeChe
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import "AppDelegate+Analysis.h"
#import "AppDelegate+Message.h"
#import "AppDelegate+Share.h"
#import <IQKeyboardManager.h>

static NSString *const kBundleVersionKey = @"CFBundleShortVersionString";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //友盟统计
    [self umengAnalysis];
    
    //友盟推送
    [self umengMessage:launchOptions];
    
    //友盟分享
    [self umengShare];

    //设置根控制器
    [self setRootViewController];
    
    //启动图停留时间
    [NSThread sleepForTimeInterval:1.5];
    
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 设置根控制器
- (void)setRootViewController
{
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kBundleVersionKey];
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][kBundleVersionKey];
    if ([currentVersion isEqualToString:saveVersion]) {
        MainTabBarController *mainVC = [[MainTabBarController alloc]init];
        self.window.rootViewController = mainVC;
    }else{
        WelcomeViewController *welcome = [[WelcomeViewController alloc]init];
        self.window.rootViewController = welcome;
        //保存Version
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kBundleVersionKey];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
